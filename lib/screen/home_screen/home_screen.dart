import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoctruong_todoapp/screen/home_screen/enum_task_status.dart';
import 'package:quoctruong_todoapp/screen/home_screen/widget_task_list.dart';

import 'bloc/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _appBarTitle = "All Tasks";

  late HomeScreenBloc _bloc;

  final List<Widget> _widgetTaskLists = <Widget>[
    const WidgetTaskList(key: ValueKey<TaskStatus>(TaskStatus.all)),
    const WidgetTaskList(key: ValueKey<TaskStatus>(TaskStatus.incompleted)),
    const WidgetTaskList(key: ValueKey<TaskStatus>(TaskStatus.completed)),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }
    switch (index) {
      case 1:
        _appBarTitle = "Incompleted Tasks";
        break;
      case 2:
        _appBarTitle = "Completed Task";
        break;
      default:
        _appBarTitle = "All Tasks";
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeScreenBloc>(context);
  }

  String? codeDialog;
  String? valueText;
  Future _showDialogAddNewTask() {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              controller: _textFieldController,
              decoration:
                  const InputDecoration(hintText: "input task description..."),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  _bloc.add(AddNewTaskEvent(
                      taskDescription: _textFieldController.text.trim()));
                  // _textFieldController.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is AddUpdateTaskState) {
            //Only show error message when add/update task failed
            if (!state.success) {
              var snackBar = SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_appBarTitle),
          ),
          body: Container(
            child: _widgetTaskLists.elementAt(_selectedIndex),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: _showDialogAddNewTask,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'All tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Completed',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
