import 'package:flutter/material.dart';
import 'package:rest_api_app/local_data/local_data.dart';
import 'package:rest_api_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String loginEmail = '';
  getLoginEmail() async {
    loginEmail = await localData.getLoginEmail() ?? '';
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getLoginEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loginEmail),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                await localData.logout().then((value) {
                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                });
              },
              child: Text(
                'Logout',
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
}
