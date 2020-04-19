import 'package:flutterapp/models/User.dart';

abstract class LoginContract {
  void onLoginSuccess(User user);

  void onLoginError(Error error);
}
