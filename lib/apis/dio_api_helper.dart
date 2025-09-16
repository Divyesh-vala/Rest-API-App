import 'package:dio/dio.dart';
import 'package:rest_api_app/apis/urls.dart';
import 'package:rest_api_app/model/user_list_model.dart';

class DioApiHelper {
  var dio = Dio();

  Future<bool> loginApi({
    required String email,
    required String password,
  }) async {
    String url = urls.loginUrl;
    final body = {"email": email, "password": password};
    bool isLogin = false;
    await dio
        .post(url, data: body, options: Options(headers: urls.headers))
        .then((value) {
          print("Dio Login Response - ${value.data}");
          if (value.statusCode == 200) {
            print("Login Success.");
            isLogin = true;
          }
        });
    return isLogin;
  }

  Future<List<UserData>> getUserList(int page) async {
    final url = "${urls.fetchUsers}$page";
    UserListModel? userListModel;
    await dio.get(url, options: Options(headers: urls.headers)).then((value) {
      print("Dio User List Response - ${value.data}");
      if (value.statusCode == 200) {
        userListModel = UserListModel.fromJson(value.data);
      }
    });
    return userListModel?.data ?? [];
  }
}

DioApiHelper dioApi = DioApiHelper();
