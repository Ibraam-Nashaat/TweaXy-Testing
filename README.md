# TweaXy Testing
## Overview
Welcome to the TweaXy Testing repository! This repository contains testing scripts for frontend, cross-platform, and stress tests for the backend of the TweaXy application. The testing suite is designed to ensure the robustness and reliability of the application across different layers.
## Frontend Tests
The frontend tests in this repository are written using Cypress, a powerful end-to-end testing framework. To run the frontend tests, follow these steps:
1. Open a terminal window.
2. Navigate to the root of this repository.
3. Run the command: ```npx cypress open```
4. In the Cypress Test Runner, pick the "e2e" suite based on the configuration provided in the testing repository.
## Cross-Platform Tests
The cross-platform tests in this repository are written using the Flutter integration test library. To run the Flutter tests, follow these steps:
1. Ensure that you have Flutter installed on your machine. (Verify with ``` flutter doctor ```)
2. Open a terminal window.
3. Navigate to the root of this repository.
4. Place all the testing scripts in a folder available in the Cross Platform repository, call the folder integration_test.
5. Run the command: ```flutter test integration_test```
## Stress Tests
The stress tests in this repository are written using Grafana k6. To run the stress tests, follow these steps:
1. Navigate to the "stress tests/Backend_Image" directory.
2. Run a Docker container of the backend API by executing: ```docker-compose up```
3. Once the backend container is up, navigate to the "stress tests/scripts" directory.
4. Run any testing script provided in the directory using the following command: ```k6 run SCRIPTNAME.js```

Please ensure that you have Docker and k6 installed on your machine before running the stress tests.
