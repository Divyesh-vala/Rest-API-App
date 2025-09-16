import 'package:flutter/material.dart';
import 'package:rest_api_app/local_data/local_data.dart';
import 'package:rest_api_app/screens/login_screen.dart';
import 'package:rest_api_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      String? email = await localData.getLoginEmail();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => email != null ? MainScreen() : LoginScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Image.asset('assets/api.png', fit: BoxFit.fill),
        ),
      ),
    );
  }
}
