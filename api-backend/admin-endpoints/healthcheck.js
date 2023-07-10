const express = require('../node_modules/express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function(req, res) {
	pool.getConnection(function(err, connection) {			//get a connection to the database from the pool
		if(err) {
		        res.status(500).json({status:"failed", "dbconnection":"mysql://root:password@localhost:9103/intelliq"});	//if there is an error return status 500 (Internal Server Error)
                        console.log("Connection could not be established.", err);
  		}
		else {
			res.status(200).json({status:"OK", "dbconnection":"mysql://root:password@localhost:9103/intelliq"});
                       	console.log("Successful connection to MySQL database.");
		}
		connection.release();		//lastly release the connection so someone else can take it
	});
});

module.exports = router;
