import 'dart:convert';
import 'package:api_app/views/homescreen.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/views/addproduct.dart';

import '../AppConfig/Appconfig.dart';
import '../model/post.dart';

class AuthServices {
  Future<List<Product>> getAllProducts() async {
    int page = 1;
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

    var last_page = (jsonData['last_page']);

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
}
