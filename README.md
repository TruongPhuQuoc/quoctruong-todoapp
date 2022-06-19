# quoctruong_todoapp

This is a simple Todo App project developed in Flutter.

## How to run the project

You can use the command line run the project with the below command:
flutter run lib/main.dart

## How to run test in this project

In this project, I have unit test, widget test and integration test

### Unit test

I have only 1 class for unit test in this project. Using below command to run unit test for task model logic:

> flutter test test/unit_task_logic.dart

### Widget test

Using below command to run widget test for home screen UI:

> flutter test test/widget_homescreen_test.dart

### Integration test

I have 1 class to run integration test. This test to check UI and logic when add new task.
To run integration test, firstly you have to select a device to run on. You can view your list of connected devices by the command.

> flutter devices

After run the above command, terminal will show you list all connected devices with an device id for each one. Select 1 device that you want to run the integration test and run the command below (replace {device-id} with device id that you want to run test)

> flutter test integration_test/integration_homescreen_test.dart -d {device-id}
