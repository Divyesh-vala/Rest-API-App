import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_app/apis/urls.dart';
import 'package:rest_api_app/model/user_list_model.dart';

class HttpApiHelper {
  Future<bool> loginApi({
    required String email,
    required String password,
  }) async {
    Uri url = Uri.parse(urls.loginUrl);

    final body = {"email": email, "password": password};
    bool isLogin = false;
    await http.post(url, body: body, headers: urls.headers).then((value) {
      print("Http Login Response - ${value.body}");
      if (value.statusCode == 200) {
        print("Login Success.");
        isLogin = true;
      }
    });
    return isLogin;
  }

  Future<List<UserData>> getUserList(int page) async {
    Uri url = Uri.parse("${urls.fetchUsers}$page");
    UserListModel? userListModel;
    await http.get(url, headers: urls.headers).then((value) {
      print("Http User List Response - ${value.body}");
      if (value.statusCode == 200) {
        userListModel = UserListModel.fromJson(jsonDecode(value.body));
      }
    });
    return userListModel?.data ?? [];
  }
}

HttpApiHelper httpApi = HttpApiHelper();
