// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:quoctruong_todoapp/main.dart';

void main() {
  testWidgets('Appbar title change when selected tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Make sure have 3 tabs in bottom navigation bar as requirements
    expect(find.text('All tasks'), findsOneWidget);
    expect(find.text('Incompleted'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);

    //App bar title changed when selected tab
    await tester.tap(find.text('Incompleted'));
    await tester.pump();
    expect(find.text('Incompleted Tasks'), findsOneWidget);
    await tester.tap(find.text('Completed'));
    await tester.pump();
    expect(find.text('Completed Tasks'), findsOneWidget);
  });
  testWidgets('Make sure have Add Task UI to create task',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    //Make sure home screen have button to add task
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    //Add task UI with textfield and button to add
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
  });
  testWidgets('Show snackbar error messsage if add task error',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    //Make sure home screen have button to add task
    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Add"), findsOneWidget);
    //Tap Add button without input task description
    await tester.tap(find.text("Add"));
    await tester.pump(const Duration(seconds: 1));
    //Snackbar only show when have error
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
