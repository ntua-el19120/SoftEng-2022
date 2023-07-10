const express = require('../node_modules/express');
const router = express.Router();
const pool = require('../connect');

router.post('/:questionnaireID', function(req, res) {
	const { questionnaireID } = req.params;
	pool.getConnection(function(err, connection) {                 //get a connection to the database from the pool
		if(err) {
			console.log("Connection failed", err);         
			res.status(500).json({status:"failed"});       //if there is an error return status 500 (Internal Server Error)
				
		}
		q = `delete from Answer where Answer.Option_questionnaire_id = ${questionnaireID};`;    // query for deleting a specific answer
		connection.query(q, function(err, result) {                                             // Executing the query, if any error happens return error 400 status failed (Bad Request)
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Couldn't delete answers"});
                
			}
			else {
				console.log("Answers for questionnaire deleted.");
				res.status(200).json({status:"OK"});                                     // and if everything worked correctly return status 200 OK
			}
		});
		connection.release();                                                                    // release the connection so someone else can use it
	});
});

module.exports = router;
