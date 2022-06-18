part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class TaskListUpdatedState extends HomeScreenState {
  final TaskStatus taskStatus;
  final List<TaskModel> taskList;

  TaskListUpdatedState({required this.taskList, required this.taskStatus});

  @override
  List<Object> get props =>
      [taskList, taskStatus, DateTime.now().millisecondsSinceEpoch];
}

class AddUpdateTaskState extends HomeScreenState {
  final bool success;
  final String message;

  AddUpdateTaskState({required this.message, required this.success});

  @override
  List<Object> get props =>
      [message, success, DateTime.now().millisecondsSinceEpoch];
}
