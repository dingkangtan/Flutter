class NetworkUtil {
  static NetworkUtil instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => instance;

  Future<dynamic> get() {
    return null;
  }
}
