const express = require('../node_modules/express');
const router = express.Router();
const pool  = require('../connect');
const { parse } = require('../node_modules/json2csv');


router.get('/:questionnaireID', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});

router.get('/:questionnaireID/:questionID', function(req, res) {
	
    const { questionnaireID, questionID } = req.params;
	pool.getConnection(function(err, connection) {     //get a connection to the database from the pool
		if(err) {
			res.status(500).json({status:"failed", reason: "connection to database not established."});   //if there is an error return status 500 (Internal Server Error)
			console.log(err);
		}
		else{
			//query to select the specific question we want
		q = `select Question.question_text, Question.required, Question.type, Option.option_id, Option.option_text, Option.Question_nextquestion_id from Question inner join Option ON Question.question_id = Option.Question_question_id where (Question.Questionnaire_questionnaire_id = ${questionnaireID} AND Question.question_id = ${questionID} AND Option.Question_Questionnaire_questionnaire_id = ${questionnaireID})`;	
		connection.query(q, function(err, result) {

        	if(err) {      //if there is a bad request return status 400
				res.status(400).json({status:"failed", reason: "Error getting question information."});
                console.log(err);
			}
			else if(result==0) {   // if the specific question doesn't exist return status 204
				res.status(204).json({status:"failed", reason: " This question does not exist "});
                console.log("question query no data");
			}
			
			else if (result) {  
   				const options = [];
    			for (const row of result) {
      				const option = { optID: row.option_id, opttxt: row.option_text, nextqID: row.Question_nextquestion_id };
      				options.push(option);
					question_text = row.question_text;
					required = row.required;
					type = row.type;
    			}
				
				console.log(options);

				//generate response

				  
				if(req.query.format === "csv") {   // if we want the output to be csv
					const csv_input = [];
					for (const row of result) {
						const inputty = {
							"questionnaireID":questionnaireID,
							"qID":questionID,
							"qtext":row.question_text,
							"required":row.required,
							"type":row.type,
                     		"optID": row.option_id.toString(),
							"opttxt": row.option_text,
							"nextqID": row.Question_nextquestion_id.toString()
					}
					csv_input.push(inputty)
				}

					const csvHeader = ['questionnaireID,qID,qtext,required,type,optID,opttxt,nextqID'];
                    const csvObj = { csvHeader };
                    var csvData = parse(csv_input, csvObj);
                    res.status(200).send(csvData);
                    console.log("Question info OK.");
				}
				else {   //else the output is in json format
					const input = {
						"questionnaireID":questionnaireID.toString(),
						"qID":questionID.toString(),
						"qtext":question_text.toString(),
						"required":required,
						"type":type,
                        "options":options
				}
					const json = JSON.stringify(input);
               		const response = JSON.parse(json, (key, val) => (
                    	typeof val !== 'object' && val !== null ? String(val) : val
                  ));
                    // JSON response: default if no query format specified.					
					res.status(200).json(response);    // if everything worked correctly return status 200 OK
					console.log("Question info OK.");
				}

        	}	
   		});
	}
	connection.release();     //release the connection so someone else can use it
	});

});


module.exports = router;
