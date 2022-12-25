import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences _sharedPreferences;

  CacheHelper(this._sharedPreferences);

  dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    return await _sharedPreferences.setInt(key, value);
  }

  void removeData({required String key})async{
   await _sharedPreferences.remove(key);
  }
}
