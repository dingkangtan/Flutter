import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/data/DatabaseTodo.dart';
import 'package:flutterapp/models/Task.dart';
import 'package:flutterapp/todo/AddToDoPage.dart';
import 'package:flutterapp/utils/AppNavigator.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:flutterapp/utils/DateUtils.dart';
import 'package:flutterapp/widget/ToDoWidgetView.dart';

import '../todo/ToDoContract.dart';
import '../todo/ToDoPresenter.dart';

class ToDoListPage extends StatefulWidget {
  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoListPage>
    with AutomaticKeepAliveClientMixin
    implements ToDoContract {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  ToDoPresenter presenter;
  DatabaseToDoHelper databaseHelper = DatabaseToDoHelper();
  DateUtils utility = new DateUtils();
  List<Task> taskList;
  int count = 0;

  @override
  void initState() {
    super.initState();
    presenter = new ToDoPresenter();
    presenter.attachView(this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (taskList == null) {
      taskList = List<Task>();
      presenter.fetchToDoList();
    }

    var tabController = new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('ToDo List'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.list, size: 28), text: "To-Do"),
              Tab(
                  icon: Icon(Icons.playlist_add_check, size: 28),
                  text: "Completed"),
            ],
          ),
        ),
        body: TabBarView(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: new FutureBuilder(
              future: databaseHelper.getInCompleteTaskList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("Loading");
                } else {
                  if (snapshot.data.length < 1) {
                    return Center(
                      child: Text(
                        'No Tasks Added',
                        style: ConstantUtils.largeTextStyle,
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int position) {
                        return new GestureDetector(
                            onTap: () {
                              if (snapshot.data[position].status !=
                                  "Task Completed")
                                navigateToTask(
                                    snapshot.data[position], "Edit Task", this);
                            },
                            child: Card(
                              margin: EdgeInsets.all(
                                  ConstantUtils.extraSmallMargin),
                              elevation: 2.0,
                              child: ToDoWidgetView(
                                title: snapshot.data[position].task,
                                sub1: snapshot.data[position].date,
                                sub2: snapshot.data[position].time,
                                status: snapshot.data[position].status,
                                delete: snapshot.data[position].status ==
                                        "Task Completed"
                                    ? IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: null,
                                      )
                                    : Container(),
                                trailing: Icon(
                                  Icons.edit,
                                  size: 24,
                                ),
                              ),
                            ) //Card
                            );
                      });
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: databaseHelper.getCompleteTaskList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("Loading");
                } else {
                  if (snapshot.data.length < 1) {
                    return Center(
                      child: Text(
                        'No Tasks Completed',
                        style: ConstantUtils.largeTextStyle,
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int position) {
                        return new GestureDetector(
                            onTap: () {
                              if (snapshot.data[position].status !=
                                  "Task Completed")
                                navigateToTask(
                                    snapshot.data[position], "Edit Task", this);
                            },
                            child: Card(
                              margin: EdgeInsets.all(
                                  ConstantUtils.extraSmallMargin),
                              elevation: 2.0,
                              child: ToDoWidgetView(
                                  title: snapshot.data[position].task,
                                  sub1: snapshot.data[position].date,
                                  sub2: snapshot.data[position].time,
                                  status: snapshot.data[position].status,
                                  delete: snapshot.data[position].status ==
                                          "Task Completed"
                                      ? IconButton(
                                          icon: Icon(Icons.delete, size: 24),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Are you sure, you want to delete this task?"),
                                                  actions: <Widget>[
                                                    RawMaterialButton(
                                                      onPressed: () async {
                                                        presenter
                                                            .onDeleteTaskClicked(
                                                                context,
                                                                scaffoldKey,
                                                                snapshot
                                                                    .data[
                                                                        position]
                                                                    .id);
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
                                              },
                                            );
                                          },
                                        )
                                      : Container(),
                                  trailing: Container()),
                            ) //Card
                            );
                      });
                }
              },
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add ToDo Task",
          child: Icon(Icons.add),
          onPressed: () {
            navigateToTask(Task('', '', '', ''), "Add Task", this);
          },
        ),
      ),
    );

    return Scaffold(
      body: tabController,
    );
  } //build()

  void navigateToTask(Task task, String title, ToDoListState obj) async {
    AppNavigator.push(context, AddTodoPage(task, title, obj));
  }

  @override
  void renderToDoList() {
    setState(() {
      this.taskList = taskList;
      this.count = taskList.length;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
