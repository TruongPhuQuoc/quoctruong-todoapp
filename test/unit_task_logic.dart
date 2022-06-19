import 'package:flutter_test/flutter_test.dart';
import 'package:quoctruong_todoapp/model/task_model.dart';

void main() {
  group(
    'Task model logic - ',
    () {
      test('Default task status is incompleted', () {
        final task = TaskModel(description: "the new task");
        expect(task.isCompleted, false);
      });

      test('Convert task instance to map and otherwise', () {
        final task =
            TaskModel(id: 1, description: "the new task", isCompleted: true);

        final map = task.toMap();
        expect(map['id'], 1);
        expect(map['description'], "the new task");
        expect(map['isCompleted'],
            1); //Convert boolean to integer number 0/1 for save to local database

        final taskFromMap = TaskModel.fromMap(map);
        expect(taskFromMap.id, 1);
        expect(taskFromMap.description, "the new task");
        expect(taskFromMap.isCompleted, true);
      });

      test('Toggle task completed/incompleted', () {
        final task =
            TaskModel(id: 1, description: "the new task", isCompleted: true);

        expect(task.isCompleted, true);
        task.isCompleted = !task.isCompleted;
        expect(task.isCompleted, false);
      });
    },
  );
}
