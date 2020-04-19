import 'package:flutterapp/base/BasePresenter.dart';
import 'package:flutterapp/data/RestData.dart';

import 'LoginContract.dart';

class LoginPagePresenter extends BasePresenter<LoginContract> {
  RestData api = new RestData();

  void doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => getView().onLoginSuccess(user))
        .catchError((onError) => getView().onLoginError(onError));
  }
}
