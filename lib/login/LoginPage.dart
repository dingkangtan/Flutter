import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/data/DatabaseLogin.dart';
import 'package:flutterapp/login/LoginPresenter.dart';
import 'package:flutterapp/models/User.dart';
import 'package:flutterapp/tabs/MainPage.dart';
import 'package:flutterapp/utils/AppNavigator.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';
import 'package:flutterapp/utils/Utils.dart';

import 'LoginContract.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> implements LoginContract {
  bool isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String username, password;
  LoginPagePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new LoginPagePresenter();
    presenter.attachView(this);
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = new RaisedButton(
      onPressed: submit,
      child: new Text("Login"),
      padding: EdgeInsets.all(ConstantUtils.smallPadding),
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
          child: new Text("Login Account", textScaleFactor: 2),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Container(),
              new Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: new TextFormField(
                  onSaved: (val) => username = val,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: new TextFormField(
                  onSaved: (val) => password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              )
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: ConstantUtils.extraLargePadding),
          child: loginBtn,
        ),
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Flutter"),
      ),
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        isLoading = true;
        form.save();
        presenter.doLogin(username, password);
      });
    }
  }

  @override
  void onLoginError(Error error) {
    Utils.showSnackBar(scaffoldKey, error.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Future<void> onLoginSuccess(User user) async {
    setState(() {
      isLoading = false;
    });
    var db = new DatabaseLogin();
    await db.saveUser(user);
    AppNavigator.pushReplacement(context, MainPage());
  }
}
