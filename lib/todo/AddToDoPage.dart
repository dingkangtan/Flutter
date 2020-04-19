import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/Task.dart';
import 'package:flutterapp/tabs/ToDoListPage.dart';
import 'package:flutterapp/todo/ToDoContract.dart';
import 'package:flutterapp/todo/ToDoPresenter.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:flutterapp/utils/DateUtils.dart';

class AddTodoPage extends StatefulWidget {
  final String appBarTitle;
  final Task task;
  final ToDoListState todoState;

  AddTodoPage(this.task, this.appBarTitle, this.todoState);

  @override
  State<StatefulWidget> createState() {
    return AddTodoState(this.task, this.appBarTitle, this.todoState);
  }
}

class AddTodoState extends State<AddTodoPage> implements ToDoContract {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateUtils utility = new DateUtils();
  TextEditingController taskController = new TextEditingController();

  ToDoPresenter presenter;
  Task task;
  ToDoListState toDoListState;
  String appBarTitle;
  bool marked = false;

  AddTodoState(this.task, this.appBarTitle, this.toDoListState) {
    presenter = new ToDoPresenter();
    presenter.attachView(this);
  }

  @override
  void initState() {
    super.initState();
  }

  var formattedDate = "Pick Date";
  var formattedTime = "Select Time";

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  @override
  Widget build(BuildContext context) {
    taskController.text = task.task;
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: new GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(appBarTitle),
        ),
        body: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(0.0),
              child: isEditable()
                  ? CheckboxListTile(
                      title: Text("Mark as Done"),
                      value: marked,
                      onChanged: (value) {
                        setState(() {
                          marked = value;
                        });
                      }) //CheckboxListTile
                  : Container(
                      height: 0,
                    )),
          Padding(
            padding: EdgeInsets.only(
                left: ConstantUtils.commonPadding,
                right: ConstantUtils.commonPadding,
                bottom: ConstantUtils.commonPadding),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(
                  labelText: "Task",
                  hintText: "E.g. Flutter Lesson 1",
                  labelStyle: ConstantUtils.labelStyle,
                  hintStyle: ConstantUtils.hintStyle), //Input Decoration
              onChanged: (value) {
                updateTask();
              },
            ), //TextField
          ), //Padd
          Padding(
            padding: EdgeInsets.only(right: ConstantUtils.extraSmallPadding),
            child: ListTile(
              title: task.date.isEmpty ? Text("Pick Date") : Text(task.date),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                var pickedDate = await utility.selectDate(context, task.date);
                if (pickedDate != null)
                  setState(() {
                    this.formattedDate = pickedDate.toString();
                    task.date = formattedDate;
                  });
              },
            ),
          ), // ing
          Padding(
            padding: EdgeInsets.only(right: ConstantUtils.extraSmallPadding),
            child: ListTile(
              title: task.time.isEmpty ? Text("Select Time") : Text(task.time),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                var pickedTime = await utility.selectTime(context);
                if (pickedTime != null)
                  setState(() {
                    formattedTime = pickedTime;
                    task.time = formattedTime;
                  });
              },
            ),
          ), // ,//DateListTile
          Padding(
            padding: EdgeInsets.all(ConstantUtils.smallPadding),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              padding: EdgeInsets.all(ConstantUtils.smallPadding),
              color: Theme.of(context).primaryColor,
              elevation: 5.0,
              child: Text(
                "Save",
                style: ConstantUtils.buttonStyle,
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                setState(() {
                  presenter.onSaveTaskClicked(
                      context, scaffoldKey, task, isEditable(), marked);
                });
              },
            ), //RaisedButton
          ), //Padding
          Padding(
            padding: EdgeInsets.all(ConstantUtils.smallPadding),
            child: isEditable()
                ? RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding: EdgeInsets.all(ConstantUtils.smallPadding),
                    color: Theme.of(context).primaryColor,
                    elevation: 5.0,
                    child: Text(
                      "Delete",
                      style: ConstantUtils.buttonStyle,
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      setState(() {
                        deleteTask();
                      });
                    },
                  ) //RaisedButton
                : new Container(),
          ) //Padding
        ]) //ListView
        ); //Scaffold
  } //build()

  bool isEditable() {
    if (this.appBarTitle == "Add Task")
      return false;
    else {
      return true;
    }
  }

  void updateTask() {
    task.task = taskController.text;
  }

  void deleteTask() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure, you want to delete this task?"),
            actions: <Widget>[
              RawMaterialButton(
                onPressed: () async {
                  presenter.onDeleteTaskClicked(context, scaffoldKey, task.id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Yes"),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              )
            ],
          );
        });
  }

  @override
  void renderToDoList() {
    toDoListState.renderToDoList();
  }
} //class task_state
