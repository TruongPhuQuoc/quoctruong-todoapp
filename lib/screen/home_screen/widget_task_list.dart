import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoctruong_todoapp/model/task_model.dart';
import 'package:quoctruong_todoapp/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:quoctruong_todoapp/screen/home_screen/enum_task_status.dart';

class WidgetTaskList extends StatefulWidget {
  const WidgetTaskList({Key? key}) : super(key: key);
  @override
  State<WidgetTaskList> createState() => _WidgetTaskListState();
}

class _WidgetTaskListState extends State<WidgetTaskList> {
  late TaskStatus _currentTaskStatus;
  List<TaskModel> _taskList = [];

  @override
  void initState() {
    super.initState();
    _currentTaskStatus = (widget.key as ValueKey<TaskStatus>).value;
    BlocProvider.of<HomeScreenBloc>(context)
        .add(GetTaskListEvent(taskStatus: _currentTaskStatus));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is TaskListUpdatedState &&
            _currentTaskStatus == state.taskStatus) {
          setState(() {
            _taskList = state.taskList;
          });
        } else if (state is AddUpdateTaskState) {
          BlocProvider.of<HomeScreenBloc>(context)
              .add(GetTaskListEvent(taskStatus: _currentTaskStatus));
        }
      },
      child: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_taskList[index].description ?? "-"),
              leading: Checkbox(
                value: _taskList[index].isCompleted,
                onChanged: (bool? value) {
                  BlocProvider.of<HomeScreenBloc>(context).add(
                    ToggleTaskStatusEvent(
                      task: _taskList[index],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
