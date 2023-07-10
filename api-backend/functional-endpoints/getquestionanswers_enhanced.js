const express = require('express');
const router = express.Router();
const pool = require('../connect');
const { parse } = require('json2csv');


router.get('/:questionnaireID', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});

router.get('/:questionnaireID/:questionID', function(req, res){

    const { questionnaireID, questionID } = req.params;
    pool.getConnection(function(err, connection){                      //get a connection to the database from the pool

        if(err) {
			res.status(500).json({status:"failed", reason: "connection to database not established."});   //if there is an error return status 500 (Internal Server Error)
			console.log(err);
		}
        else{
		//query that returns the answers for a specific question
            q = `select Questionnaire.title, Question.question_text, Session.session_id, Answer.answer_id, Option.option_text 
            from Option join Answer on (Option.option_id = Answer.Option_option_id)
            join Question on (Option.Question_question_id = Question.question_id)
            join Questionnaire on (Question.Questionnaire_questionnaire_id = Questionnaire.questionnaire_id)
            join Session on (Answer.Session_session_id = Session.session_id)
            where (Questionnaire.questionnaire_id = ${questionnaireID} and Question.question_id = ${questionID} and Option.Question_Questionnaire_questionnaire_id = ${questionnaireID})
            order by Answer.answer_id ASC;`;
            connection.query(q, function(err, result){
                if(err) {                                             // if there is a bad request return status 400
                    res.status(400).json({status:"failed", reason: "Error getting question information."});
                    console.log(err);
                }
                else if(result==0) {                                  // if the specific question doesn't exist, or answers for this question do not exist return status 204
                    res.status(204).json({status:"failed", reason: " no data for this query"});
                    console.log("getquestionanswers query no data");
                }
                else{
                    const answers = [];
    			    for (const row of result) {
      				    const answer = { SessionID: row.session_id, answerID: row.answer_id, answer_txt: row.option_text };
      				    answers.push(answer);
                        questionnaire_title = row.title;
					    question_text = row.question_text;
    			    }

                    console.log(answers);

                    if(req.query.format === "csv") {  // if we want the output object to be csv
                        const csv_input = [];
                        for (const row of result) {
                            const inputty = {
                                "questionnaireID":questionnaireID,
                                "qID":questionID,
                                "Questionnaire_title":row.title,
                                "qtext":row.question_text,
                                "Session_id": row.session_id.toString(),
                                "answer_id": row.answer_id.toString(),
                                "answer_text": row.option_text
                            }
                            csv_input.push(inputty)
                        }
    
                        const csvHeader = ['questionnaireID,qID,Questionnaire_title,qtext,Session_id,answer_id,answer_text'];
                        const csvObj = { csvHeader };
                        var csvData = parse(csv_input, csvObj);
                        res.status(200).send(csvData);
                        console.log("Question info OK.");
                    }
                    else { // else the output object is in json
                        const input = {
                            "questionnaireID":questionnaireID.toString(),
                            "qID":questionID.toString(),
                            "questionnaire_title": questionnaire_title,
                            "qtext":question_text.toString(),
                            "answers": answers
                        }
                        const json = JSON.stringify(input);
                        const response = JSON.parse(json, (key, val) => (
                            typeof val !== 'object' && val !== null ? String(val) : val
                        ));
                        // JSON response: default if no query format specified.					
                        res.status(200).json(response);   //if everything worked correctly return status 200 OK
                        console.log("Question info OK.");
                    }
                }
            });
        }

    connection.release();            //release the connection so someone else can use it
    });
});

module.exports = router;