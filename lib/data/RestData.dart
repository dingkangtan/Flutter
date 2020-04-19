import 'package:flutterapp/models/User.dart';
import 'package:flutterapp/utils/NetworkUtils.dart';

class RestData {
  NetworkUtil networkUtil = new NetworkUtil();

  static final baseUrl = "";
  static final loginUrl = baseUrl + "/";

  Future<User> login(String username, String password) {
    return new Future.value(new User(username, password));
  }
}
