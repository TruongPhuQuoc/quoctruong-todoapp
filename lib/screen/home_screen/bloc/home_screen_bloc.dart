import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quoctruong_todoapp/data/local/local_db_helper.dart';
import 'package:quoctruong_todoapp/model/task_model.dart';
import 'package:quoctruong_todoapp/screen/home_screen/enum_task_status.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final LocalDbHelper _dbHelper = LocalDbHelper();

  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<AddNewTaskEvent>(_addNewTask);
    on<ToggleTaskStatusEvent>(_toggleTaskStatus);
    on<GetTaskListEvent>(_getTaskList);
  }

  Future<void> _addNewTask(
      AddNewTaskEvent event, Emitter<HomeScreenState> emit) async {
    TaskModel task = TaskModel(description: event.taskDescription);
    var result = await _dbHelper.addTask(task);
    if (result is int) {
      emit(AddUpdateTaskState(message: "Add task success!", success: true));
    } else {
      emit(AddUpdateTaskState(
          message: "Add task failed! Detail: ${result.toString()}",
          success: false));
    }
  }

  Future<void> _toggleTaskStatus(
      ToggleTaskStatusEvent event, Emitter<HomeScreenState> emit) async {
    var result = await _dbHelper.updateTask(
        taskId: event.task.id ?? -1, newTaskStatus: !event.task.isCompleted);
    if (result is int) {
      emit(AddUpdateTaskState(
          message: "Updated: ${event.task.description}", success: true));
    } else {
      emit(AddUpdateTaskState(
          message: "Update task failed! Detail: ${result.toString()}",
          success: false));
    }
  }

  Future<void> _getTaskList(
      GetTaskListEvent event, Emitter<HomeScreenState> emit) async {
    emit(
      TaskListUpdatedState(
        taskStatus: event.taskStatus,
        taskList: await _dbHelper.getTaskList(event.taskStatus),
      ),
    );
  }
}
