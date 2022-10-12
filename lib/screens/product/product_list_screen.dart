// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ffi';

import 'package:api_app/screens/product/edit_product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:api_app/screens/home_screen.dart';

import '../../AppConfig/Appconfig.dart';
import '../../model/models.dart';

class product_list_screen extends StatefulWidget {
  product_list_screen({Key? key, String? token}) : super(key: key);

  @override
  _product_list_screenState createState() => _product_list_screenState();
}

class _product_list_screenState extends State<product_list_screen> {
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homescreen');
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Product List'),
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
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder<List<Product>>(
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
                                builder: (context) => edit_product_screen(
                                    product_id,
                                    product_name,
                                    product_price,
                                    product_userid),
                              ),
                            )
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Colors.white12,
                              height: 200.0,
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            height: 100.0,
                                            width: double.infinity,
                                            child: Text(
                                              '${product.name}\n Product details here..',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          height: 50.0,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('\$ ${product.price}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              Text(
                                                  'ID ${product.id.toString()}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(40),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Colors.transparent
                                      //           .withOpacity(0.5),
                                      //       offset: Offset(0, 25),
                                      //       blurRadius: 3,
                                      //       spreadRadius: -10)
                                      // ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          "https://asia-exstatic-vivofs.vivo.com/PSee2l50xoirPK7y/1663488134047/726b466c7d68c4f7db93bb41b6070f29.png",
                                          fit: BoxFit.fill),
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
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
