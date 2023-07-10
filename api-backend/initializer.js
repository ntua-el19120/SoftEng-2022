const express = require('./node_modules/express');
const router = express.Router();
const pool = require('./connect');
var fs = require('fs');
const { exec } = require("child_process");

var sql = fs.readFileSync('../data/sql-scripts/answers_script_questionnaire1.sql').toString();

exec("se2213 questionnaire_upd --source ../data/import_questionnaires/example_questionnaire_1.json", (error, stdout, stderr) => {
    if (error) {
        console.log(`error: ${error.message}`);
        return;
    }
    if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
    }

    console.log(`stdout: ${stdout}`);
    console.log("Questionnaire 1 inserted, now going to insert dummy answers");
    var queries = sql.split(';');

    pool.getConnection(function (err, connection) {                 //get a connection to the database from the pool
        if (err) {
            console.log("Connection failed", err);

        }
        else {
            for (i = 0; i < queries.length; i++) {
                console.log(queries[i]);
                console.log(queries[i]);
                q = queries[i];
                connection.query(q, function (err, res) {
                    if (err) {
                        console.log(err);
                    }
                });
            }
        }
        console.log("All answers for questionnaire inserted")
        connection.release();
    });
});




