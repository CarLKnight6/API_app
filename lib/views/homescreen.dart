// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, String? currentuseremail}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _signOut() async {
   
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('padayon'),
            backgroundColor: Color.fromRGBO(8, 120, 93, 3),
            //automaticallyImplyLeading: false,
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('MENU', style: TextStyle(color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(8, 120, 93, 3),
                  ),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  onTap: () {
                    _signOut();
                    Navigator.pushNamed(context, '/');
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Exit'),
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      exit(0);
                    });
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  // MaterialButton(
                  //   onPressed: () {
                  //     _signOut();
                  //     Navigator.pushNamed(context, '/');
                  //   },
                  //   color: Colors.black.withOpacity(0.05),
                  //   textColor: Colors.white,
                  //   child: Text(
                  //     "SIGNOUT",
                  //     // style: GoogleFonts.droidSans(
                  //     //     fontSize: 20.0, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        readOnly: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          labelText: 'WELCOME USER ',  //$currentuseremail
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
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/productlist');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Product List",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/addproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Add Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                    SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/editproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Edit Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                             SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/deleteproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Delete Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                    SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        //VIDEOCHATSCREEN FUNCTION
                        Navigator.pushNamed(context, '/singleproduct');
                      },
                      color: Colors.black.withOpacity(0.05),
                      textColor: Colors.white,
                      child: Text(
                        "Single Product",
                        // style: GoogleFonts.droidSans(
                        //     fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
         

                ],
              )),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
