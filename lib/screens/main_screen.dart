import 'dart:convert';

import 'package:api_app/services/getToken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'home_screen.dart';

class main_screen extends StatefulWidget {
  const main_screen({super.key});

  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  String? token2;

  @override
  void initState() {
    // TODO: implement initState
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
    // print('this ${getToken(tokenget!)}');
    return token2 != '' && token2 != null ? home_screen() : login_screen();
  }
}
