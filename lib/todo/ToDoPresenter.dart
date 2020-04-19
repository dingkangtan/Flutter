import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/base/BasePresenter.dart';
import 'package:flutterapp/data/DatabaseTodo.dart';
import 'package:flutterapp/models/Task.dart';
import 'package:flutterapp/todo/ToDoContract.dart';
import 'package:flutterapp/utils/Utils.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class TaskPresenter {
  void onSaveTaskClicked(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      Task task,
      bool isEditable,
      bool marked);

  void onDeleteTaskClicked(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey, int taskId);

  void fetchToDoList();
}

class ToDoPresenter extends BasePresenter<ToDoContract>
    implements TaskPresenter {
  DatabaseToDoHelper helper = DatabaseToDoHelper();

  // Input Validation
  bool checkNotNull(GlobalKey<ScaffoldState> scaffoldKey, String task,
      String date, String time) {
    bool res = false;
    if (task.isEmpty) {
      Utils.showSnackBar(scaffoldKey, 'Task cannot be empty');
      res = false;
    } else if (date.isEmpty) {
      Utils.showSnackBar(scaffoldKey, 'Please select the Date');
      res = false;
    } else if (time.isEmpty) {
      Utils.showSnackBar(scaffoldKey, 'Please select the Time');
      res = false;
    } else {
      res = true;
    }
    return res;
  }

  @override
  void onSaveTaskClicked(
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey,
      Task task,
      bool isEditable,
      bool marked) async {
    int result;
    if (isEditable) {
      if (marked) {
        task.status = "Task Completed";
      } else
        task.status = "";
    }

    if (checkNotNull(scaffoldKey, task.task, task.date, task.time) == true) {
      if (task.id != null) {
        result = await helper.updateTask(task);
      } else {
        result = await helper.insertTask(task);
      }

      fetchToDoList();
      Navigator.pop(context);

      if (result != 0) {
        Utils.showAlertDialog(context, 'Status', 'Task saved successfully.');
      } else {
        Utils.showAlertDialog(context, 'Status', 'Problem saving task.');
      }
    }
  }

  @override
  void onDeleteTaskClicked(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey, int taskId) async {
    await helper.deleteTask(taskId);
    fetchToDoList();
  }

  @override
  void fetchToDoList() {
    Future<Database> dbFuture = helper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = helper.getTaskList();
      taskListFuture.then((taskList) {
        getView().renderToDoList();
      });
    });
  }
}
