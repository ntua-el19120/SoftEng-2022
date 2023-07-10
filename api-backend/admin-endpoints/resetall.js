const express = require('../node_modules/express');
const router = express.Router();
const pool = require('../connect');   

router.post('/', function(req, res) {
	pool.getConnection(function(err, connection) {		//get a connection to the database from the pool

		if(err) {
			console.log("connection failed", err);
			return res.status(500).json({status:"failed"});
				
		}
        connection.query("SET FOREIGN_KEY_CHECKS=0;", function(err)		//first disable foreign key checks so we can empty all tables without worrying about the order
        {
            if(err) { 
				console.log(err);
                return res.status(400).json({status:"failed", reason: "Could not turn off foreign key checks."});
               
            }
        })
		// connection.query("TRUNCATE TABLE User", function(err) 							not yet implemented
		// {
        // 	if(err) {
		// 		return res.status(400).json({status:"failed", reason: "Table User not truncated"});
        //         console.log(err);
		// 	}
		// 	else {
        //         console.log("Table User truncated");
		// 	}
		// })

		// Then empty all tables in the database if any error happens return error 400 status failed (Bad Request)

        connection.query("TRUNCATE TABLE Keyword", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Table Keyword not truncated"});
			}
			else {
                console.log("Table Keyword truncated");
			}
		})
        connection.query("TRUNCATE TABLE Answer", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Table Answer not truncated"}); 
			}
			else {
                console.log("Table Answer truncated");
			}
		})
        connection.query("TRUNCATE TABLE Session", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Table Session not truncated"});
			}
			else {
                console.log("Table Session truncated");
			}
		})
        connection.query("TRUNCATE TABLE Option", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Table Option not truncated"});
			}
			else {
                console.log("Table Option truncated");
			}
		})
        connection.query("TRUNCATE TABLE Question", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(400).json({status:"failed", reason: "Table Question not truncated"});
			}
			else {
                console.log("Table Question truncated");
			}
		})
        connection.query("TRUNCATE TABLE Questionnaire", function(err) 
		{
        	if(err) {
				console.log(err);
				return res.status(500).json({status:"failed", reason: "Table Questionnaire not truncated"});
			}
			else {
                console.log("Table Questionnaire truncated");
			}
		})
        connection.query("SET FOREIGN_KEY_CHECKS=1;", function(err)			//Enable foreign key checks again
        {
            if(err) {
                console.log(err);
				return res.status(500).json({status:"failed", reason: "Could not turn foreign key checks back on."}); 
            }
			else {
				res.status(200).json({status:"OK"});			// and if everything worked correctly return status 200 OK
                console.log("All tables trunctated successfully.");
			}
        })
        ;
		connection.release();			// finally release the connection so someone else can use it
	});
});

module.exports = router;
