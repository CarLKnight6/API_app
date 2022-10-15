// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:api_app/Repositories/product_repositories.dart';

import 'package:api_app/widgets/button.dart';
import 'package:api_app/widgets/product_textfield_widget.dart';

import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key, String? token}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey2 = GlobalKey<FormState>();

  final descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  final imagelinkcontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  final _productformKey = GlobalKey<FormState>();
  void clearText() {
    descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  void dispose() {
    descriptioncontroller.dispose();
    ispublishedcontroller.dispose();
    pricecontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

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
            centerTitle: true,
            title: Text('ADD PRODUCT'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
                key: _formKey2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Form(
                  key: _productformKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProductTextFormField(
                          readOnly: false,
                          textController: namecontroller,
                          label: 'Product Name'),
                      ProductTextFormField(
                          readOnly: false,
                          textController: descriptioncontroller,
                          label: 'Description'),
                      ProductTextFormField(
                          readOnly: false,
                          textController: pricecontroller,
                          label: 'Price'),
                      ProductTextFormField(
                          readOnly: false,
                          textController: imagelinkcontroller,
                          label: 'Image Link'),
                      ProductTextFormField(
                          readOnly: false,
                          textController: ispublishedcontroller,
                          label: 'Is published?'),
                      Button(
                        label: 'Submit',
                        onPressed: () {
                          if (_productformKey.currentState!.validate()) {
                            ProductRepositories(context).AddProduct(
                                namecontroller.text,
                                imagelinkcontroller.text,
                                descriptioncontroller.text,
                                pricecontroller.text,
                                false);
                          }
                        },
                      )
                    ],
                  ),
                )),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
