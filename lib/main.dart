// ignore_for_file: prefer_const_constructors

import 'package:api_app/views/addproduct.dart';
import 'package:api_app/views/deleteproduct.dart';
import 'package:api_app/views/editproduct.dart';
import 'package:api_app/views/homescreen.dart';
import 'package:api_app/views/loginscreen.dart';
import 'package:api_app/views/productlist.dart';
import 'package:api_app/views/register.dart';
import 'package:api_app/views/singleproduct.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(errorColor: Colors.white),
      title: "api app",
      initialRoute: '/',
      routes: {
        '/': (context) => loginscreen(),
        '/homescreen': (context) => HomeScreen(),
        '/register': (context) => registrationscreen(),
        '/deleteproduct': (context) => DeleteProduct(),
        '/productlist': (context) => ProductList(),
        '/singleproduct': (context) => SingleProduct(),
        '/addproduct': (context) => AddProduct()

        //'/journalscreen': (context) => journalscreen(),
        //  '/journalnotescreen': (context) => journalnotescreen(),
      },
    );
  }
}
