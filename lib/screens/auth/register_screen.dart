// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';

import 'dart:math';

import '../../AppConfig/Appconfig.dart';

class register_screen extends StatefulWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  _register_screenState createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  @override
  void initState() {
    super.initState();
    setState(() {
      namecontroller.clear();
      namecontroller.text = getRandomString(10);
    });
  }

  final _formKey2 = GlobalKey<FormState>();

  final regemailcontroller = TextEditingController();

  final regpasswordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  bool _randomtext = true;
  var donetext = 'done';
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  void clearText() {
    regemailcontroller.clear();
    regpasswordcontroller.clear();
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          clearText();
          Navigator.pushNamed(context, '/loginscreen');
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("padayon:"),
        content: Text("Successfully registered!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showAlertDialog2passwordweak(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          clearText();
          Navigator.pushNamed(context, '/register_screen');
        },
      );

      // set up the AlertDialog
      AlertDialog alert2 = AlertDialog(
        title: Text("padayon:"),
        content: Text("password is too weak!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert2;
        },
      );
    }

    showAlertDialog2emailalreadyexist(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          clearText();
          Navigator.pushNamed(context, '/register_screen');
        },
      );

      // set up the AlertDialog
      AlertDialog alert3 = AlertDialog(
        title: Text("padayon:"),
        content: Text("email already exists!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert3;
        },
      );
    }

    showAlertDialoginvalidemail(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          clearText();
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert4 = AlertDialog(
        title: Text("padayon:"),
        content: Text("Invalid email address provided!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert4;
        },
      );
    }

    showAlertDialog2invalidentry(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          clearText();
          Navigator.pushNamed(context, '/register_screen');
        },
      );

      // set up the AlertDialog
      AlertDialog alert4 = AlertDialog(
        title: Text("padayon:"),
        content: Text("please check again!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert4;
        },
      );
    }

    Future<void> RegisterOfuser(
        String name, email, password, password_confirmation) async {
      var jsonResponse;
      Map data = {
        'name': namecontroller.text,
        'email': regemailcontroller.text,
        'password': regpasswordcontroller.text,
        'password_confirmation': regpasswordcontroller.text
      };
      print(data);

      String body = json.encode(data);
      Uri url = Uri.parse(AppConfig().api_BASEURL + "/api/register");
      var response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      ).timeout(Duration(seconds: 10));

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        jsonResponse = json.decode(response.body.toString());

        Navigator.pushNamed(context, '/');
        // ignore: avoid_print
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Successfully registered')));
        print('success');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Data')));
        print('error');
      }
    }

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Create Account'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
          ),
          body: Container(
              key: _formKey2,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      readOnly: true,
                      style: TextStyle(color: Colors.white),
                      controller: namecontroller,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'press the box to get anon name';
                        }
                        return null;
                      },
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_randomtext
                              ? Icons.account_box
                              : Icons.add_box_outlined),
                          onPressed: () {
                            namecontroller.clear();
                            setState(() {
                              namecontroller.clear();
                              namecontroller.text =
                                  getRandomString(10); // randomfunction here
                            });
                          },
                        ),
                        labelText: 'your name',
                        prefixIcon: Icon(Icons.person),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),

                        //when error has occured
                        errorStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: regpasswordcontroller,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'password is required!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your password',
                        prefixIcon: Icon(Icons.person),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        //when error has occured
                        // errorStyle: TextStyle(
                        //   color: Colors.red,
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: regemailcontroller,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'e-mail address is required.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your email address',

                        prefixIcon: Icon(Icons.person),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        //when error has occured
                        // errorStyle: TextStyle(
                        //   color: Colors.red,
                        // ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text(
                            '',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                          onPressed: () {
                            // _launchURL3();
                          })
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      // if (_formKey2.currentState!.validate()) {
                      if (regemailcontroller.text.isEmpty &&
                          regpasswordcontroller.text.isEmpty &&
                          namecontroller.text.isEmpty) {
                        showAlertDialog2invalidentry(context);
                      } else if (namecontroller.text.isEmpty) {
                        showAlertDialog2invalidentry(context);
                      } else if (regemailcontroller.text.isEmpty) {
                        showAlertDialoginvalidemail(context);
                      } else if (regpasswordcontroller.text.isEmpty) {
                        showAlertDialog2invalidentry(context);
                      } else {
                        RegisterOfuser(
                            namecontroller.text,
                            regemailcontroller.text,
                            regpasswordcontroller.text,
                            regemailcontroller.text);
                      }

                      // }
                    },
                    color: Colors.black.withOpacity(0.05),
                    textColor: Colors.white,
                    child: Text(
                      donetext,
                      // style: GoogleFonts.droidSans(
                      //     fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ))),
      onWillPop: () async {
        return false;
      },
    );
  }
}
