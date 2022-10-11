// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/screens/home_screen.dart';

import '../../AppConfig/Appconfig.dart';

class delete_product_screen extends StatefulWidget {
  delete_product_screen({Key? key, String? token}) : super(key: key);

  @override
  _delete_product_screenState createState() => _delete_product_screenState();
}

class _delete_product_screenState extends State<delete_product_screen> {
  final _formKey2 = GlobalKey<FormState>();
  String deleterespo = '1';
  final imagelink_descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var productidcontroller = TextEditingController();

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

    Future<void> delete_product_screen(String id) async {
      var jsonResponse;
      Map data = {
        'id': productidcontroller.text,
      };
      print(data);
      print("the first token $token");

      String body = json.encode(data);

      Uri url = Uri.parse(
          "${AppConfig().api_BASEURL}/api/products/${productidcontroller.text}");
      var response = await http.delete(
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

      if (response.statusCode == 200 && response.body == deleterespo) {
        jsonResponse = json.decode(response.body.toString());

        Navigator.pushNamed(context, '/homescreen');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully deleted the product')));

        print('success');
      } else {
        print('error');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid credential')));
      }
    }

    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homescreen');
              },
              icon: Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            title: Text('Delete Product'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
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
                        controller: productidcontroller,
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
                          //     productidcontroller.clear();
                          //     setState(() {
                          //       productidcontroller.clear();
                          //       productidcontroller.text =
                          //           getRandomString(10); // randomfunction here
                          //     });
                          //   },
                          // ),
                          labelText: 'Enter Product ID ',
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
                        //add delete function here
                        delete_product_screen(productidcontroller.text);
                        print(productidcontroller.text);

                        // delete_product_screen(
                        //     productidcontroller.text,
                        //     imagelink_descriptioncontroller.text,
                        //     imagelink_descriptioncontroller.text,
                        //     pricecontroller.text,
                        //     false);

                        // }
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        'delete',
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
