## API testing

Functional tests for all IntelliQ API endpoints.

<sub>*Warning: the state of the database is not saved and restored during the testing process*</sub>

### Dependencies

- The testing script relies on Newman. Install the module globally using:

    ``` npm install -g newman ```
    
### How to run
    
- On Windows, go to ~/SoftEng22-13/test/api-testing and run the batch script by simply typing:

    ``` test-api ``` or ``` .\test-api ``` 
    
- On MacOS/Linux, go to ~/SoftEng22-13/test/api-testing and paste the following:

    ``` newman run collections/Constants.postman_collection.json
        newman run collections/UploadQuestionnairesTest.postman_collection.json
        newman run collections/QuestionsTest.postman_collection.json -d data-files/question.csv
        newman run collections/Answers.postman_collection.json -d data-files/answers.csv
        newman run collections/SessionAnswers.postman_collection.json -d data-files/sessions.csv
        newman run collections/QuestionAnswers.postman_collection.json -d data-files/getquestions.csv
        newman run collections/Reset.postman_collection.json 
    ```
    
<sub>Note that test results are meaningful only when IntelliQ and its database are up and running.</sub>


### How it works

The script tests the endpoints by making assertions on the HTTP responses based on the expected ones (as described in the API documentation). 
The order of calls aims to simulate normal operation.

- First, */healthcheck* is called to verify connection to the database followed by a */resetall* call to truncate all tables. 
- Sample data is inserted using */questionnaire_upd* followed by */questionnaire* and */question* calls to show the data and verify the questionnaires have been uploaded successfully. 
- Using */doanswer*, the questionnaires are filled with sample responses.
- */getsessionanswers* and */getquestionanswers* are run and expected to return the given answers.
- Finally, */resetq* is used to delete the answers given in all questionnaires.

At each step, the endpoints are tested for **response time**, **status code** and JSON response **value to path parameter consistency**. 
The CSVs in /file-data are fed as source files for the various calls.

#### Part of the output for reference:
![image](https://user-images.githubusercontent.com/115061993/218283303-3b052ef8-d29b-42af-9c49-4d874f0b1f10.png)
