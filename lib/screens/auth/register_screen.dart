// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:api_app/services/AuthServices.dart';
import 'package:api_app/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';

import 'dart:math';

import '../../AppConfig/Appconfig.dart';
import '../../widgets/auth_textfield_widget.dart';

class register_screen extends StatefulWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  _register_screenState createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  @override
  void initState() {
    super.initState();
    ;
  }

  final _regformKey = GlobalKey<FormState>();

  final regemailcontroller = TextEditingController();

  final regpasswordcontroller = TextEditingController();
  final regconfirmpasswordcontroller = TextEditingController();

  var namecontroller = TextEditingController();
  var donetext = 'done';

  void clearText() {
    regemailcontroller.clear();
    regpasswordcontroller.clear();
    regconfirmpasswordcontroller.clear();
    namecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> RegisterOfuser(
    //     String name, email, password, password_confirmation) async {
    //   var jsonResponse;
    //   Map data = {
    //     'name': namecontroller.text,
    //     'email': regemailcontroller.text,
    //     'password': regpasswordcontroller.text,
    //     'password_confirmation': regconfirmpasswordcontroller.text
    //   };
    //   print(data);

    //   String body = json.encode(data);
    //   Uri url = Uri.parse(AppConfig().api_BASEURL + "/api/register");
    //   var response = await http.post(
    //     url,
    //     body: body,
    //     headers: {
    //       "Content-Type": "application/json",
    //       "accept": "application/json",
    //       "Access-Control-Allow-Origin": "*"
    //     },
    //   ).timeout(Duration(seconds: 10));

    //   print(response.body);
    //   print(response.statusCode);

    //   if (response.statusCode == 201) {
    //     jsonResponse = json.decode(response.body.toString());

    //     Navigator.pushNamed(context, '/');
    //     // ignore: avoid_print
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Successfully registered')));
    //     print('success');
    //   } else {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Invalid Data')));
    //     print('error');
    //   }
    // }

    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loginscreen');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Create Account'),
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: _regformKey,
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTextFormField(
                      textController: namecontroller,
                      label: 'Name',
                    ),
                    AuthTextFormField(
                      textController: regemailcontroller,
                      label: 'Email',
                    ),
                    AuthTextFormField(
                      textController: regpasswordcontroller,
                      label: 'Password',
                    ),
                    AuthTextFormField(
                      textController: regconfirmpasswordcontroller,
                      label: 'Confirm Password',
                    ),
                    Button(
                      label: 'Submit',
                      formKey: _regformKey,
                      onPressed: () {
                        if (_regformKey.currentState!.validate()) {
                          AuthServices(context).RegisterOfuser(
                              namecontroller.text,
                              regemailcontroller.text,
                              regpasswordcontroller.text,
                              regconfirmpasswordcontroller.text);
                        }
                      },
                    )
                  ],
                )),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
