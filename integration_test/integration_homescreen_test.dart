// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:quoctruong_todoapp/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // testWidgets('Add new task flow', (WidgetTester tester) async {
  //   //Create random task description to test
  //   final String taskDescription = "New task ${Random().nextInt(1000)}";
  //   await tester.pumpWidget(const MyApp());

  //   //Make sure home screen have button to add task
  //   expect(find.byIcon(Icons.add), findsOneWidget);
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //   //Add task UI with textfield and button to add
  //   expect(find.byType(TextField), findsOneWidget);
  //   expect(find.text("Add"), findsOneWidget);
  //   await tester.enterText(find.byType(TextField).first, taskDescription);
  //   await tester.tap(find.text("Add"));
  //   await tester.pump(const Duration(seconds: 1));
  //   expect(find.text("Add"), findsNothing);
  //   expect(find.text(taskDescription), findsOneWidget);
  // });

  testWidgets('Add task and update status', (WidgetTester tester) async {
    //Create random task description to test
    final String taskDescription = "New task ${Random().nextInt(1000)}";
    await tester.pumpWidget(const MyApp());

    //Make sure home screen have button to add task
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    //Add task UI with textfield and button to add
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, taskDescription);
    await tester.tap(find.text("Add"));
    await tester.pumpAndSettle();
    //After add new task, go to tab Incompleted Task
    await tester.tap(find.text('Incompleted'));
    await tester.pumpAndSettle();
    //New task status default is incompleted and show in Incompleted Tasks tab
    expect(find.text(taskDescription), findsOneWidget);
    //Get number completed and incompleted task
    int numberIncompletedTask = find.byType(Checkbox).evaluate().length;
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();
    int numberCompletedTask = find.byType(Checkbox).evaluate().length;
    //return incompleted task screen and Check 1 task to mark completed
    await tester.tap(find.text('Incompleted'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    //The number incompleted task will decrease 1
    expect(find.byType(Checkbox).evaluate().length, numberIncompletedTask - 1);
    //Back to completed task screen, The number completed task will increase 1
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();
    expect(find.byType(Checkbox).evaluate().length, numberCompletedTask + 1);
  });
}
