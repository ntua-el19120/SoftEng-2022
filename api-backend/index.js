const path = require('path');
const express = require('express'),
 app = express(),
 webapp = express(),
 router = express.Router();
const https = require('https');
const fs = require('fs');
const cors = require('cors');

const fileupload = require("express-fileupload");

const PORT = 9103;
const baseurl = '/intelliq_api';

const server = https.createServer(/*{ key, cert },*/ app);
const webserver = https.createServer(/*{ key, cert },*/ webapp);

// API WEB SERVER

app.listen(PORT, () => {								//rest api listening to port 9103 and
	console.log(`App listening at: http://localhost:${PORT}${baseurl}`);		//creating url to access endpoints from
});

app.get(baseurl, function (req,res) {											
	res.send('intelliQ IS UP!');
});

// MIDDLEWARE FOR CROSS-ORIGIN REQUESTS
app.use(cors());

app.use(fileupload());
app.use(express.urlencoded({ extended: true }));

// WEB SERVER (for frontend)
webapp.listen(80, () => {								//create a web server listening to port 80
 	console.log('Web-server is up and runing at: http://www.intelliQ.com');		//and link it to www.inteliQ.com
 });

webapp.get("/", function (req,res) {
	res.send("Webserver IS UP!");
});

const adminhealth = require('./admin-endpoints/healthcheck'),					//set from where to get each endpoint
	questionnaireupd = require('./admin-endpoints/questionnaire_upd'),
	resetall = require('./admin-endpoints/resetall'),
	resetq = require('./admin-endpoints/resetq'),
    // login = require('./admin-endpoints/usermod'),	these two are not yet implemented
    // logout = require('./admin-endpoints/users'),
	questionnaire = require('./functional-endpoints/questionnaire'),
	question = require('./functional-endpoints/question'),
	doanswer = require('./functional-endpoints/doanswer'),
	getsessionanswers = require('./functional-endpoints/getsessionanswers'),
	getquestionanswers = require('./functional-endpoints/getquestionanswers');
	getquestionanswers_enhanced = require('./functional-endpoints/getquestionanswers_enhanced');
const { homedir } = require('os');

// RESTFUL API ROUTES
app.use(baseurl+'/admin/healthcheck', adminhealth);					//and set the paths from the base url we created before
app.use(baseurl+'/admin/questionnaire_upd', questionnaireupd);				// to access the endpoints through the url
app.use(baseurl+'/admin/resetall', resetall);
app.use(baseurl+'/admin/resetq', resetq);
// app.use(baseurl+'/admin/usermod', login)
// app.use(baseurl+'/admin/users', logout)
app.use(baseurl+'/questionnaire', questionnaire);
app.use(baseurl+'/question', question);
app.use(baseurl+'/doanswer', doanswer);
app.use(baseurl+'/getsessionanswers', getsessionanswers);
app.use(baseurl+'/getquestionanswers', getquestionanswers);
app.use(baseurl+'/getquestionanswersenhanced', getquestionanswers_enhanced);


// ROUTES FOR FRONTEND

webapp.use(express.static(path.join(__dirname, '..') + "/frontend/frontend1/build"));

module.exports = router;