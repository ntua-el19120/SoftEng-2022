const express = require('../node_modules/express');
const router = express.Router();
const pool = require('../connect');
var id = 1;


router.post('/:questionnaireID/:questionID/:session', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});

router.post('/:questionnaireID/:questionID', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});
router.post('/:questionnaireID', function(req, res) {  // if there is a bad request ( here less parameters than required ) return status 400
	res.status(400).json({status:"failed", reason: "Missing required parameter."});
});

router.post('/:questionnaireID/:questionID/:session/:optionID', function (req, res) { 
	const { questionnaireID, questionID, session, optionID } = req.params;
	pool.getConnection(function (err, connection) {                   //get a connection to the database from the pool
		if (err) {
			res.status(500).json({ status: "failed" });       //if there is an error return status 500 (Internal Server Error)
			console.log("Failed to connect to database.", err);
		}
                          //query to create a session if it did not exist
		connection.query(`insert ignore into Session(session_id, Questionnaire_questionnaire_id) values ('${session}', '${questionnaireID}')`, function (err, result) {
			if (err) {
				res.status(400).json({ status: "failed" });  // bad request return status
				console.log("Usermod bad request", err);
			}
			else {
				console.log("created session if it didn't exist");
				//query to create an answer to a specific session and question
				connection.query(`insert into Answer(Option_option_id,Option_questionnaire_id,Option_question_id, Session_session_id) values ('${optionID}', '${questionnaireID}','${questionID}','${session}')`, function (err, result) {
					if (err) {
						res.status(400).json({ status: "failed" });  // if there is a bad request return status 400
						console.log("Usermod bad request", err);
					}
					else {
						res.status(200).json({ status: "OK" });  //else if everything is ok return status 200
						console.log("answer success.");
					}
				});
			}
		});
		connection.release();   //release the connection so someone else can use it
	});
});

module.exports = router;
