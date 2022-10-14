import 'package:api_app/services/getToken.dart';
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? token2;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    getToken().then((value) {
      setState(() {
        token2 = value;
      });
    });
    return token2 != '' && token2 != null ? HomeScreen() : LoginScreen();
  }
}
