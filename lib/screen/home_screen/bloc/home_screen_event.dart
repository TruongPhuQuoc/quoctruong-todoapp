part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class AddNewTaskEvent extends HomeScreenEvent {
  final String taskDescription;
  AddNewTaskEvent({required this.taskDescription});

  @override
  List<Object> get props => [taskDescription];
}

class ToggleTaskStatusEvent extends HomeScreenEvent {
  final TaskModel task;

  ToggleTaskStatusEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task.id ?? "", task.isCompleted];
}

class GetTaskListEvent extends HomeScreenEvent {
  final TaskStatus taskStatus;

  GetTaskListEvent({
    required this.taskStatus,
  });

  @override
  List<Object> get props => [taskStatus];
}
