// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:io';
import 'package:api_app/AppConfig/Appconfig.dart';
import 'package:api_app/screens/product/product_list_screen.dart';
import 'package:api_app/widgets/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/button.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? token;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    getCred();
  }

  deletetokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    setState(() {
      token = '';
    });
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('token');
    });
  }

  Future<void> LogoutOfuser() async {
    var jsonResponse;

    Uri url = Uri.parse("${AppConfig().apibaseurl}/api/logout");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": 'Bearer $token'
      },
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      deletetokenValue();
      Navigator.pushNamed(context, '/loginscreen');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Account logged out')));
      print('success');
    } else {
      print('error');
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Home Page'),
            backgroundColor: Colors.transparent,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('MENU', style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    LogoutOfuser();
                  },
                ),
                ListTile(
                  title: Text('Exit'),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      exit(0);
                    });
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                      width: double.infinity,
                      child: TextFieldWidget(
                        label: 'Welcome User $token',
                      ),
                    ),
                  ),
                  Button(
                    label: 'Product List',
                    onPressed: () {
                      print(token);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductListScreen(token: token)));
                      Navigator.pushNamed(context, '/productlist');
                    },
                  ),
                  Button(
                    label: 'Add Product',
                    onPressed: () {
                      print(token);

                      Navigator.pushNamed(context, '/addproduct');
                    },
                  ),
                  Button(
                    label: 'Delete Product',
                    onPressed: () {
                      Navigator.pushNamed(context, '/deleteproduct');
                    },
                  )
                ],
              )),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
