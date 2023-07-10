@ECHO OFF

ECHO ===================================================
ECHO Running tests on healthcheck, reseting database ...
ECHO ===================================================


call newman run collections\Constants.postman_collection.json


ECHO ===================================================
ECHO Running tests on uploads, verifying insertions ...
ECHO ===================================================


call newman run collections\UploadQuestionnairesTest.postman_collection.json


ECHO ===================================================
ECHO Running tests on questions, verifying results ...
ECHO ===================================================


call newman run collections\QuestionsTest.postman_collection.json -d data-files\question.csv


ECHO ===================================================
ECHO Running tests on doanswer ...
ECHO ===================================================

call newman run collections\Answers.postman_collection.json -d data-files\answers.csv


ECHO ===================================================
ECHO Running tests on getsessionanswers ...
ECHO ===================================================

call newman run collections\SessionAnswers.postman_collection.json -d data-files\sessions.csv


ECHO ===================================================
ECHO Running tests on getquestionanswers ...
ECHO ===================================================

call newman run collections\QuestionAnswers.postman_collection.json -d data-files\getquestions.csv

ECHO ===================================================
ECHO Running tests on resetq, deleting answers ...
ECHO ===================================================

call newman run collections\Reset.postman_collection.json

