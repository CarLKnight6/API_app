import 'dart:convert';
import 'dart:ffi';

import 'package:api_app/AppConfig/Appconfig.dart';
import 'package:api_app/Repositories/product_repository_interface.dart';
import 'package:api_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/models.dart';

class ProductRepositories extends ProductRepositoryInterface {
  ProductRepositories(this.context);
  BuildContext context;

  @override
  Future<List<Productdetails>?> AddProduct(String name, String image_link,
      String description, String price, int is_published) async {
    var jsonResponse;
    Map data = {
      'name': name,
      'image_link': image_link,
      'description': description,
      'price': price,
      'is_published': is_published
    };
    print(data);
    print("the first token $token");

    String body = json.encode(data);
    Uri url = Uri.parse("${AppConfig().apibaseurl}/api/products");
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully added the product')));
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid product details')));
    }
  }

  @override
  Future<List<ProductID>?> delete_product_screen(int id) async {
    Map data = {
      'id': id,
    };
    print(data);
    print("the first token $token");

    String body = json.encode(data);

    Uri url =
        Uri.parse("${AppConfig().apibaseurl}/api/products/${id.toString()}");
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

    if (response.statusCode == 200 && response.body == '1') {
      Navigator.pushNamed(context, '/homescreen');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully deleted the product')));

      print('success');
    } else {
      print('error');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid ID')));
    }
  }

  @override
  Future<List<UpdateProduct>?> edit_product_screen(
      int id,
      int user_id,
      String name,
      String image_link,
      String description,
      String price,
      int is_published) async {
    var jsonResponse;
    Map data = {
      'id': id,
      'user_id': user_id,
      'name': name,
      'image_link': image_link,
      'description': description,
      'price': price,
      'is_published': is_published
    };

    String body = json.encode(data);

    var response = await http.put(
      Uri.parse("${AppConfig().apibaseurl}/api/products/${id}"),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": 'Bearer $token'
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body.toString());
      Navigator.pushNamed(context, '/productlist');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated the product')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incomplete Product details')));
    }
  }

  @override
  Future<List<Product>> getAllProducts(int? page) async {
    print('this is page inside funct ${page}');

    var response = await http.get(
        Uri.parse("${AppConfig().apibaseurl}/api/products?page=$page"),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": 'Bearer $token'
        });

    print(response.statusCode);

    var jsonData = json.decode(response.body);
    int last_page = (jsonData['last_page']);
    SharedPreferences lastpage = await SharedPreferences.getInstance();
    lastpage.setInt('last_page', last_page);
    Map data = {'current_page': page, 'last_page': last_page};

    print(response.statusCode);
    print(response.body);
    var jsonArray = jsonData['data'];
    List<Product> products = [];
    for (var jsonProduct in jsonArray) {
      Product product = Product(
          id: jsonProduct['id'],
          userid: jsonProduct['user_id'],
          name: jsonProduct['name'],
          imagelink: jsonProduct['image_link'],
          price: jsonProduct['price'],
          is_published: jsonProduct['is_published']);

      products.add(product);
    }
    return products;
  }
}
