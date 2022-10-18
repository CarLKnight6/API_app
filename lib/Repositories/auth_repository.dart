import 'dart:convert';
import 'package:api_app/AppConfig/Appconfig.dart';
import 'package:api_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/models.dart';
import 'auth_repository_interface.dart';

class AuthRepositories implements AuthRepositoryInterface {
  AuthRepositories(this.context);
  BuildContext context;

  @override
  Future<List<Logindetails>?> LoginOfuser(String email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      'email': email,
      'password': password,
    };

    String body = json.encode(data);
    Uri url = Uri.parse("${AppConfig.baseUrl}/login");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(const Duration(seconds: 10));

    print(response.body);
    print('access token is -> ${json.decode(response.body)['token']}');

    if (response.statusCode == 201) {
      prefs.setString("token", json.decode(response.body)['token']);
      token = prefs.getString('token')!;
      Navigator.pushNamed(context, '/homescreen');

      print('Response -> ${json.decode(response.body)}');
      print('success');
    } else {
      print('error');
    }
    return null;
  }

  @override
  Future<List<Registerdetails>?> RegisterOfuser(
      String name, email, password, passwordConfirmation) async {
    var jsonResponse;
    Map data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
    print(data);

    String body = json.encode(data);
    Uri url = Uri.parse("${AppConfig.baseUrl}/register");
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(const Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body.toString());

      Navigator.pushNamed(context, '/loginscreen');

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully registered')));
      print('success');
    } else if (response.statusCode == 422) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The email has already been taken')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid Data')));
      print('error');
    }
    return null;
  }
}
