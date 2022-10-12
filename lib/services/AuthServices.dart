import 'dart:convert';
import 'package:api_app/model/models.dart';
import 'package:api_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/screens/product/add_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AppConfig/Appconfig.dart';

late String body;


class AuthServices {
  // Future<List<Logindetails>?> LoginOfuser(String email, password) async {
  //   var jsonResponse;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   Map data = {
  //     'email': email,
  //     'password': password,
  //   };

  //   String body = json.encode(data);
  //   Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/login");
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
  //   print('access token is -> ${json.decode(response.body)['token']}');

  //   if (response.statusCode == 201) {
  //     prefs.setString("token", json.decode(response.body)['token']);
  //     token = prefs.getString('token')!;
  //     // ignore: avoid_print
  //     print('Response -> ${json.decode(response.body)}');
  //     print('success');
  //   } else {
  //     print('error');
  //   }
  // }

  // Future<List<Logindetails>?> LogoutOfuser() async {
  //   var jsonResponse;

  //   Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/logout");
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "accept": "application/json",
  //       "Access-Control-Allow-Origin": "*",
  //       "Authorization": 'Bearer $token'
  //     },
  //   );

  //   print(response.body);
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     jsonResponse = json.decode(response.body.toString());

  //     // Navigator.pushNamed(context, '/');
  //     // // ignore: avoid_print
  //     // ScaffoldMessenger.of(context)
  //     //     .showSnackBar(SnackBar(content: Text('Account logged out')));
  //     print('success');
  //   } else {
  //     print('error');
  //   }
  // }

  // Future<List<Product>?> AddProduct(String name, String image_link,
  //     String description, String price, bool is_published) async {
  //   var jsonResponse;
  //   Map data = {
  //     'name': name,
  //     'image_link': name,
  //     'description': name,
  //     'price': price,
  //     'is_published': false
  //   };
  //   print(data);
  //   print("the first token $token");

  //   String body = json.encode(data);
  //   Uri url = Uri.parse("${AppConfig().api_BASEURL}/api/products");
  //   var response = await http.post(
  //     url,
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

  //   if (response.statusCode == 201) {
  //     jsonResponse = json.decode(response.body.toString());

  //     // ignore: avoid_print
  //     print('success');
  //   } else {
  //     print('error');
  //   }
  // }
}
