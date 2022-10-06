// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

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

class ProductList extends StatefulWidget {
  ProductList({Key? key, String? token}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _formKey2 = GlobalKey<FormState>();
  Future<ProductModel>? futureProduct;
  final imagelink_descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();

  void clearText() {
    imagelink_descriptioncontroller.clear();
    pricecontroller.clear();
  }

  Future<ProductModel> fetchProducts() async {
    final response = await http.get(
      Uri.parse('${AppConfig().api_BASEURL}/api/products'),
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 201) {
      print(token);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ProductModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      futureProduct = fetchProducts();
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
          body: Center(
            child: FutureBuilder<ProductModel>(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return Text('${snapshot.error}');
              },
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
