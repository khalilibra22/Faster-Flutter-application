import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  String mToken;
  SharedPreferences _prefs;
  AuthToken() {}
  /* String getToken() {
    loadData();
    return mToken;
  } */

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get data {
    return _prefs.getString('token') ?? '';
  }

  set data(String value) {
    _prefs.setString('token', value);
  }
}
