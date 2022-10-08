// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';

import 'package:api_app/services/AuthServices.dart';
import 'package:api_app/views/editproduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/views/homescreen.dart';

import '../AppConfig/Appconfig.dart';
import '../model/post.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key, String? token}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _formKey2 = GlobalKey<FormState>();

  final imagelink_descriptioncontroller = TextEditingController();
  int last_page = 1;
  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  int page = 1;
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

    Future<List<Product>> getAllProducts() async {
      // Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/products?page=$page");
      var response = await http.get(
          Uri.parse("${AppConfig().api_BASEURL}/api/products?page=$page"),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Authorization": 'Bearer $token'
          });
      var jsonData = json.decode(response.body);
      print(jsonData['last_page']);

      last_page = (jsonData['last_page']);

      var jsonArray = jsonData['data'];
      List<Product> products = [];
      for (var jsonProduct in jsonArray) {
        Product product = Product(
            id: jsonProduct['id'],
            user_id: jsonProduct['user_id'],
            name: jsonProduct['name'],
            price: jsonProduct['price']);
        products.add(product);
      }
      return products;
    }

    //HERE^

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
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_left),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  if (page > 0) {
                    setState(() {
                      page--;
                      getAllProducts();
                    });
                  } else if (page == 0) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('end of page')));
                  }

                  print(page);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('end of page')));
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  if (page < last_page) {
                    setState(() {
                      page++;
                      getAllProducts();
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('end of page')));
                  }
                },
              ),
            ],
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
          ),
          body: FutureBuilder<List<Product>>(
            future: getAllProducts(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Product> products = snapshot.data!;
                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product product = products[index];

                      return InkWell(
                        onTap: () {
                          print(product.id);
                          var product_id = product.id;
                          var product_name = product.name;
                          var product_price = product.price;
                          var product_userid = product.user_id;
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => EditProduct(product_id,
                                  product_name, product_price, product_userid),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Card(
                          color: Color.fromARGB(255, 218, 211, 149),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product name: ${product.name}',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'product price: ${product.price}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "lato",
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Product ID: ${product.id.toString()}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "lato",
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Product USER ID: ${product.user_id.toString()}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "lato",
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
