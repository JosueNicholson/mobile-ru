import 'package:shared_preferences/shared_preferences.dart';

class StorageResource {

  static StorageResource get instance {
    if (_instance == null) {
      _instance = StorageResource._init();
    }
    return _instance;
  }

  static StorageResource _instance;
  StorageResource._init();

  SharedPreferences _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  dynamic getKey(String key) async {
    final _pref = await preferences;
    return _pref.get(key);
  }

  dynamic saveKey(String key, String value) async {
    final _pref = await preferences;
    return await _pref.setString(key, value);
  }

  dynamic removeKey(String key) async {
    final _pref = await preferences;
    return await _pref.remove(key);
  }


}