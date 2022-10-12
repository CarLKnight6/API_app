// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:api_app/screens/main_screen.dart';
import 'package:api_app/screens/product/add_product_screen.dart';
import 'package:api_app/screens/product/delete_product_screen.dart';
import 'package:api_app/screens/home_screen.dart';
import 'package:api_app/screens/auth/login_screen.dart';
import 'package:api_app/screens/product/product_list_screen.dart';
import 'package:api_app/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ROOT
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(errorColor: Colors.white),
      title: "api app",
      initialRoute: '/',
      routes: {
        '/': (context) => main_screen(),
        '/loginscreen': (context) => login_screen(),
        '/homescreen': (context) => home_screen(),
        '/register': (context) => register_screen(),
        '/deleteproduct': (context) => delete_product_screen(),
        '/productlist': (context) => product_list_screen(),
        '/addproduct': (context) => add_product_screen()
      },
    );
  }
}
