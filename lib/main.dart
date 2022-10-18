import 'package:api_app/screens/main_screen.dart';
import 'package:api_app/screens/product/add_product_screen.dart';
import 'package:api_app/screens/product/delete_product_screen.dart';
import 'package:api_app/screens/home_screen.dart';
import 'package:api_app/screens/auth/login_screen.dart';
import 'package:api_app/screens/product/product_list_screen.dart';
import 'package:api_app/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ROOT
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(errorColor: Colors.white),
      title: "api app",
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/loginscreen': (context) => const LoginScreen(),
        '/homescreen': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/deleteproduct': (context) => DeleteProductScreen(),
        '/productlist': (context) => ProductListScreen(),
        '/addproduct': (context) => AddProductScreen()
      },
    );
  }
}
