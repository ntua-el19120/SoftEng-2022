const express = require('../node_modules/express');
const router = express.Router();
const pool  = require('../connect');
const { parse } = require('../node_modules/json2csv');

router.get('/:questionnaireID', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});

router.get('/:questionnaireID/:session', function(req, res) {
	
    const { questionnaireID, session } = req.params;

	pool.getConnection(function(err, connection) {   //get a connection to the database from the pool
//fasfwaf
		if(err) {
			res.status(500).json({status:"failed", reason: "connection to database not established."});  //if there is an error return status 500 (Internal Server Error)
			console.log(err);
		}
		else{
			//query to select a specific session
            q = `select Answer.answer_id, Option.Question_question_id from Answer inner join mydb.Option ON Answer.Option_option_id = mydb.Option.option_id where (Option.Question_Questionnaire_questionnaire_id= ${questionnaireID} AND Answer.Session_session_id = "${session}")`;		
            connection.query(q, function(err, result) {

        	if(err) {   // if there is a bad request return status 400
				res.status(400).json({status:"failed", reason: "Error getting question information."});
                console.log(err);
			}
			else if(result==0) {  // if the specific sessions doesn't exist return status 204
				res.status(204).json({status:"failed", reason: "This session does not exist."});
                console.log("getsessionanswers query no data");
			}
			else if (result) {
   				const answers = [];
    			for (const row of result) {
      				const answer = { qID: row.Question_question_id, ans: row.answer_id };
      				answers.push(answer);
    			}
				console.log(answers);

				if(req.query.format === "csv") { // if we want the output to be in csv
					const csv_input = [];
					for (const row of result) {
						const inputty = {
							"questionnaireID":questionnaireID.toString(),
							"session":session.toString(),
							"qID":row.Question_question_id.toString(),
							"ans":row.answer_id.toString(),
					}
					csv_input.push(inputty)
				}

					const csvHeader = ['questionnaireID,session,qid,ans'];
                    const csvObj = { csvHeader };
                    var csvData = parse(csv_input, csvObj);
                    res.status(200).send(csvData);
                    console.log("Question info OK.");
				}
				else {  // else the output is in json
					const input = {
						"questionnaireID":questionnaireID.toString(),
						"session":session.toString(),
						"answers":answers
				}
					const json = JSON.stringify(input);
               		const response = JSON.parse(json, (key, val) => (
                    	typeof val !== 'object' && val !== null ? String(val) : val
                  ));
					
                    // JSON response: default if no query format specified.					
					res.status(200).json(response);   // if everything worked correctly return status 200 OK
					console.log("Question info OK.");
				}

        	}	
   		});
	}
	connection.release();          //release the connection so someone else can use it
	});

});


module.exports = router;
