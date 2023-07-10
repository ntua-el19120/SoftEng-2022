<!-- CLI TESTING -->
## CLI Testing

Functionality tests for the command line interface using Chai and Mocha.

### Prerequisites

* Install the CLI globally. Go to ~/SoftEng22-13/cli and run:
  ```sh
  npm install -g
  ```
* Install Mocha. Run:
  ```sh
  npm install mocha -g
  ```
* Install child_process and Chai. Go to ~/SoftEng22-13/test/cli-testing and run:
  ```sh
  npm install child_process, chai
  ```

### How to run
Simply run:
  ```sh
  mocha ./cli-tests.js
  ```
### What it does
This script performs a test on intelliQ's CLI calls. It performs them on a database of 5 questionnaires with ~10 questions and ~7 answer sessions each. You can find these in ~/SoftEng22-13/data/import_questionnaires along with the corresponding SQL scripts for sessions and answers. The following things are tested:
1. (json & csv) exit code 0
2. (json & csv) Return status: 'OK'
3. (json) The return object has the correct keys (i.e. if it calls /questionnaire it checks whether it contains "questionnaireID:" etc.)
4. (json) The return object has data (i.e. if it calls /questionnaire it checks whether it contains questions, if it calls /question it checks whether it contains options etc.)
5. (csv) The return object has the correct labels.

![image](https://user-images.githubusercontent.com/115226054/218302548-484a3c83-7e56-4b19-b122-e9948f408c2e.png)
