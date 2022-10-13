// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:api_app/model/models.dart';
import 'package:api_app/services/AuthServices.dart';
import 'package:api_app/widgets/button.dart';
import 'package:api_app/widgets/product_textfield_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/screens/home_screen.dart';

import '../../AppConfig/Appconfig.dart';

class edit_product_screen extends StatefulWidget {
  // edit_product_screen({Key? key, String? token}) : super(key: key);

  int product_id;
  String product_name;
  String product_price;
  int product_userid;

  edit_product_screen(this.product_id, this.product_name, this.product_price,
      this.product_userid);

  @override
  _edit_product_screenState createState() => _edit_product_screenState();
}

class _edit_product_screenState extends State<edit_product_screen> {
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
  TextEditingController _controller = TextEditingController();
  final _editproductformKey = GlobalKey<FormState>();
  late StreamController _streamController;
  late Stream _stream;
  late Timer _debounce;
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
    productidcontroller.text = captured_product_id.toString();
    _search() async {
      //search function here
      print(captured_product_id);
    }

    @override
    void dispose() {
      productnamecontroller.dispose();
      imagelink_descriptioncontroller.dispose();
      pricecontroller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();

      _debounce = 0 as Timer;
    }

    // Future<void> edit_product_screen(String name, String image_link,
    //     String description, String price, bool is_published) async {
    //   var jsonResponse;
    //   Map data = {
    //     'name': productnamecontroller.text,
    //     'image_link': imagelink_descriptioncontroller.text,
    //     'description': imagelink_descriptioncontroller.text,
    //     'price': pricecontroller.text,
    //     'is_published': false
    //   };
    //   print(data);
    //   print("the first token $token");

    //   String body = json.encode(data);
    //   // Uri url = Uri.parse(
    //   //     "${AppConfig().api_BASEURL}/api/products/$captured_product_id");
    //   var response = await http.put(
    //     Uri.parse(
    //         "${AppConfig().api_BASEURL}/api/products/$captured_product_id"),
    //     body: body,
    //     headers: {
    //       "Content-Type": "application/json",
    //       "accept": "application/json",
    //       "Access-Control-Allow-Origin": "*",
    //       "Authorization": 'Bearer $token'
    //     },
    //   );
    //   print("token $token");
    //   print(response.body);
    //   print(response.statusCode);

    //   if (response.statusCode == 200) {
    //     jsonResponse = json.decode(response.body.toString());
    //     Navigator.pushNamed(context, '/productlist');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Successfully updated the product')));
    //     // ignore: avoid_print
    //     print('success');
    //   } else {
    //     print('error');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Incomplete Product details')));
    //     print('error');
    //   }
    // }

    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/productlist');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Edit Product'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _editproductformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProductTextFormField(
                        enabled: false,
                        readOnly: true,
                        hintText: captured_product_id.toString(),
                        textController: productidcontroller,
                        label: 'Product ID'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_name,
                        textController: productnamecontroller,
                        label: 'Product Name'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_price,
                        textController: pricecontroller,
                        label: 'Price'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_name,
                        textController: imagelink_descriptioncontroller,
                        label: 'Description/Image Link'),
                    Button(
                      label: 'Update',
                      onPressed: () {
                        if (_editproductformKey.currentState!.validate()) {
                          //addprod here

                          // fetchProducts();
                          _search();
                          AuthServices(context).edit_product_screen(
                              captured_product_id,
                              captured_product_userid,
                              productnamecontroller.text,
                              imagelink_descriptioncontroller.text,
                              imagelink_descriptioncontroller.text,
                              pricecontroller.text,
                              false);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
