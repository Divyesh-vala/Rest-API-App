import 'package:flutter/material.dart';
import 'package:rest_api_app/apis/dio_api_helper.dart';
import 'package:rest_api_app/apis/http_api_helper.dart';
import 'package:rest_api_app/local_data/local_data.dart';
import 'package:rest_api_app/screens/main_screen.dart';

enum ApiType { httpType, dioType }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiType apiType = ApiType.httpType;
  final emailController = TextEditingController(text: 'eve.holt@reqres.in'),
      passwordController = TextEditingController(text: 'cityslicka');

  //For show or hide password
  bool showPassword = false;
  showOrHidePwd() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  //For login api calling
  bool loading = false;
  loginAPI() async {
    setState(() {
      loading = true;
    });
    bool isLogin = false;
    if (apiType == ApiType.httpType) {
      isLogin = await httpApi.loginApi(
        email: emailController.text,
        password: passwordController.text,
      );
    } else {
      isLogin = await dioApi.loginApi(
        email: emailController.text,
        password: passwordController.text,
      );
    }
    setState(() {
      loading = false;
    });
    if (isLogin) {
      localData.setLoginEmail(emailController.text);
      localData.setApiType(apiType == ApiType.httpType ? 'http' : 'dio');
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false,
      );
    }
  }

  checkApiType() async {
    String? type = await localData.getApiType();
    if (type == 'http') {
      setState(() {
        apiType = ApiType.httpType;
      });
    } else if (type == 'dio') {
      setState(() {
        apiType = ApiType.dioType;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkApiType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          if (emailController.text != 'eve.holt@reqres.in' ||
              passwordController.text != 'cityslicka')
            IconButton(
              onPressed: () {
                setState(() {
                  emailController.text = 'eve.holt@reqres.in';
                  passwordController.text = 'cityslicka';
                });
              },
              icon: Icon(Icons.refresh),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    tileColor: Colors.amber.shade200,
                    value: ApiType.httpType,
                    groupValue: apiType,
                    onChanged: (value) {
                      if (value != null) {
                        print("HTTP TYPE Assing - $value");
                        setState(() {
                          apiType = value;
                        });
                      }
                    },
                    title: Text('Http'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: RadioListTile(
                    tileColor: Colors.amber.shade200,
                    value: ApiType.dioType,
                    groupValue: apiType,
                    onChanged: (value) {
                      if (value != null) {
                        print("DIO TYPE Assing - $value");
                        setState(() {
                          apiType = value;
                        });
                      }
                    },
                    title: Text('Dio'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            txtField(
              controller: emailController,
              enabled: !loading,
              hintText: 'Email',
            ),
            const SizedBox(height: 15),
            txtField(
              controller: passwordController,
              enabled: !loading,
              hintText: 'Password',
              obscureText: !showPassword,
              suffixIcon: IconButton(
                onPressed: () {
                  showOrHidePwd();
                },

                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            const SizedBox(height: 25),
            loading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(double.infinity, 60),
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    loginAPI();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  TextFormField txtField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
    required bool enabled,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
      ),
      obscureText: obscureText,
    );
  }
}
