import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static const email = 'email', apiType = 'api_type';
  // Obtain shared preferences.
  Future<SharedPreferences> getInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  //For set or get Login Email
  setLoginEmail(String data) async {
    final prefs = await getInstance();

    await prefs.setString(email, data);
  }

  Future<String?> getLoginEmail() async {
    final prefs = await getInstance();

    String? data = prefs.getString(email);
    return data;
  }

  //For set or get API type
  setApiType(String data) async {
    final prefs = await getInstance();

    await prefs.setString(apiType, data);
  }

  Future<String?> getApiType() async {
    final prefs = await getInstance();

    String? data = prefs.getString(apiType);
    return data;
  }

  //For Logout with clear local data
  Future<bool> logout() async {
    final prefs = await getInstance();

    bool logout = await prefs.clear();
    return logout;
  }
}

LocalData localData = LocalData();
