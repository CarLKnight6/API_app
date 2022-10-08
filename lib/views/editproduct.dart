// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:api_app/model/post.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/views/homescreen.dart';

import '../AppConfig/Appconfig.dart';

class EditProduct extends StatefulWidget {
  // EditProduct({Key? key, String? token}) : super(key: key);

  int product_id;
  String product_name;
  String product_price;
  int product_userid;

  EditProduct(this.product_id, this.product_name, this.product_price,
      this.product_userid);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late int captured_product_id;
  late String captured_product_name;
  late String captured_product_price;
  late int captured_product_userid;

  final _formKey2 = GlobalKey<FormState>();

  final imagelink_descriptioncontroller = TextEditingController();

  var pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var productidcontroller = TextEditingController();
  var productnamecontroller = TextEditingController();

  void clearText() {
    imagelink_descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    captured_product_id = widget.product_id;
    captured_product_name = widget.product_name;
    captured_product_price = widget.product_price;
    captured_product_userid = widget.product_userid;
    TextEditingController _controller = TextEditingController();

    late StreamController _streamController;
    late Stream _stream;
    late Timer _debounce;

    _search() async {
      //search function here
      print(captured_product_id);
    }

    @override
    void initState() {
      super.initState();
      _debounce = 0 as Timer;
    }

    Future<void> EditProduct(String name, String image_link, String description,
        String price, bool is_published) async {
      var jsonResponse;
      Map data = {
        'name': productnamecontroller.text,
        'image_link': imagelink_descriptioncontroller.text,
        'description': imagelink_descriptioncontroller.text,
        'price': pricecontroller.text,
        'is_published': false
      };
      print(data);
      print("the first token $token");

      String body = json.encode(data);
      // Uri url = Uri.parse(
      //     "${AppConfig().api_BASEURL}/api/products/$captured_product_id");
      var response = await http.put(
        Uri.parse(
            "${AppConfig().api_BASEURL}/api/products/$captured_product_id"),
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

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        Navigator.pushNamed(context, '/productlist');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully updated the product')));
        // ignore: avoid_print
        print('success');
      } else {
        print('error');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Incomplete Product details')));
        print('error');
      }
    }

    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/productlist');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Edit Product'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
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
                        readOnly: true,
                        style: TextStyle(color: Colors.white),
                        // controller: productidcontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'press the box to get anon name';
                          }
                          return null;
                        },
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Product ID  $captured_product_id',
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
                        readOnly: false,
                        style: TextStyle(color: Colors.white),
                        controller: productnamecontroller,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'press the box to get anon name';
                          }
                          return null;
                        },
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),

                          labelText:
                              'current product name $captured_product_name',
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
                          labelText: 'current desc $captured_product_name',
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
                          labelText: 'current price $captured_product_price',

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
                    MaterialButton(
                      onPressed: () {
                        // if (_formKey2.currentState!.validate()) {
                        //addprod here

                        // fetchProducts();
                        _search();
                        EditProduct(
                            productnamecontroller.text,
                            imagelink_descriptioncontroller.text,
                            imagelink_descriptioncontroller.text,
                            pricecontroller.text,
                            false);

                        // }
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        'UPDATE',
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
