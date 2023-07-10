const express = require('../node_modules/express');
const router = express.Router();
const pool = require('../connect');
const bodyParser = require('body-parser');
const fs = require('fs');
//const multer = require(multer);
//const upload = multer();
var fileupload = require("express-fileupload");



router.post('/', function (req, res) {
    pool.getConnection(function (err, connection) {      //get a connection to the database from the pool
        if (err) {
            return res.status(500).json({ status: "failed", reason: "connection to database" });       //if there is an error with the connection return status 500 (Internal Server Error)
            console.log("connection failed", err);
        }
        else {
            // converting the buffer to Json 
            console.log(req);
            const questionnaire_json = JSON.parse(req.files.my_questionnaire.data);     //get the data and give it to a number of variables to insert into database correctly

            const questionnaireID = questionnaire_json.questionnaireID;
            const questionnaire_title = questionnaire_json.questionnaireTitle;
            const questions = questionnaire_json.questions;                         //get all questions
            const options = [];
            for (let i = 0; i < questionnaire_json.questions.length; i++) {
                for (let j = 0; j < questionnaire_json.questions[i].options.length; j++) {
                    options.push(questionnaire_json.questions[i].options[j]);       //get all options for each question
                }
            }
            const keywords = questionnaire_json.keywords;

            // Now we start inserting the data into the database

            q = `INSERT INTO Questionnaire (questionnaire_ID, title) VALUES (${questionnaireID}, "${questionnaire_title}");`    //insert the questionnaire
            connection.query(q, function (err, result) {

                if (err) {
                    return res.status(400).json({ status: "failed", reason: "Error when executing query. Could be duplicate" });
                    console.log(err);
                }
                else if (result == 0) {                    //if no rows were inserted then return status 204
                    console.log("no rows inserted");
                    return res.status(204);
                }
                else if (result) {               //if everything worked correctly then inserts all keywords
                    for (let i = 0; i < keywords.length; i++) {

                        q = `INSERT INTO Keyword (keyword_text, Questionnaire_questionnaire_id) VALUES ("${keywords[i]}", ${questionnaireID});`
                        connection.query(q, function (err, result) {

                            if (err) {
                                return res.status(400).json({ status: "failed", reason: "Error when executing query." });
                                console.log(err);
                            }

                        });
                    }
                    //again if everything worked correctly insert all questions
                    for (let i = 0; i < questions.length; i++) {

                        q = `INSERT INTO Question (question_id, question_text, required, type, Questionnaire_questionnaire_id) 
                        VALUES (${questions[i].qID}, "${questions[i].qtext}", "${questions[i].required}", "${questions[i].type}", ${questionnaireID});`
                        connection.query(q, function (err, result) {

                            if (err) {
                                return res.status(400).json({ status: "failed", reason: "Error when executing query." });
                                console.log(err);
                            }

                        });
                    }
                    //and then all options
                    for (let i = 0; i < questions.length; i++) {
                        for (let j = 0; j < questions[i].options.length; j++) {
                            const option = questions[i].options[j];
                            q = `INSERT INTO Option (option_text, Question_nextquestion_id, Question_Questionnaire_questionnaire_id1, Question_question_id, Question_Questionnaire_questionnaire_id)
                            VALUES ("${option.opttxt}", ${option.nextqID}, ${questionnaireID}, ${questions[i].qID}, ${questionnaireID});`
                            connection.query(q, function (err, result) {

                                if (err) {
                                    return res.status(400).json({ status: "failed", reason: "Error when executing query." });
                                    console.log(err);
                                }

                            });
                        }
                    }
                    res.status(200).json({ status: "OK" });     //if everything worked correctly return status 200 OK
                }
            });

        }
        connection.release();       // finally release the connection so someone else can use it
    });
});

module.exports = router;
