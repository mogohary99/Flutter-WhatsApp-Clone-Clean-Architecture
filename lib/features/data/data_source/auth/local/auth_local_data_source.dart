import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuthLocalDataSource {
  Future<void> setUserLoggedIn(String uid);

  Future<void> removeUser(String uid);

  String? getUser();
}

class AuthLocalDataSource extends BaseAuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> setUserLoggedIn(String uid) {
    return sharedPreferences.setString('uid', uid);
  }

  @override
  Future<void> removeUser(String uid) {
    return sharedPreferences.remove(uid);
  }

  @override
  String? getUser() {
    return sharedPreferences.getString('uid');
  }
}
