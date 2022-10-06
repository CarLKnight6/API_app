// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/views/homescreen.dart';

import '../AppConfig/Appconfig.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key, String? token}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey2 = GlobalKey<FormState>();

  final imagelink_descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  void clearText() {
    imagelink_descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    Future<void> AddProduct(String name, String image_link, String description,
        String price, bool is_published) async {
      var jsonResponse;
      Map data = {
        'name': namecontroller.text,
        'image_link': imagelink_descriptioncontroller.text,
        'description': imagelink_descriptioncontroller.text,
        'price': pricecontroller.text,
        'is_published': false
      };
      print(data);
      print("the first token $token");

      String body = json.encode(data);
      Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/products");
      var response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": 'Bearer $token'
        },
      );
      print("token $token");
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        jsonResponse = json.decode(response.body.toString());

        Navigator.pushNamed(context, '/homescreen');
        // ignore: avoid_print
        print('success');
      } else {
        print('error');
      }
    }

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homescreen');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('padayon'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
          ),
          body: SingleChildScrollView(
            child: Container(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        readOnly: false,
                        style: TextStyle(color: Colors.white),
                        controller: namecontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'press the box to get anon name';
                          }
                          return null;
                        },
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          // suffixIcon: IconButton(
                          //   icon: Icon(_randomtext
                          //       ? Icons.account_box
                          //       : Icons.add_box_outlined),
                          //   onPressed: () {
                          //     namecontroller.clear();
                          //     setState(() {
                          //       namecontroller.clear();
                          //       namecontroller.text =
                          //           getRandomString(10); // randomfunction here
                          //     });
                          //   },
                          // ),
                          labelText: 'your product name',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: imagelink_descriptioncontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password is required!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your description and imagelink',
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: pricecontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'e-mail address is required.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your price',

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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        // controller: ispublishedcontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'password is required!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Is published?',
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
                        //addprod here

                        AddProduct(
                            namecontroller.text,
                            imagelink_descriptioncontroller.text,
                            imagelink_descriptioncontroller.text,
                            pricecontroller.text,
                            false);
                              
                        // }
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        'donetext',
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
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
