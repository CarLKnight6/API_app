import 'package:api_app/Repositories/product_repository.dart';
import 'package:api_app/widgets/button.dart';
import 'package:api_app/widgets/product_textfield_widget.dart';

import 'package:flutter/material.dart';

class DeleteProductScreen extends StatefulWidget {
  DeleteProductScreen({Key? key, String? token}) : super(key: key);

  @override
  _DeleteProductScreenState createState() => _DeleteProductScreenState();
}

class _DeleteProductScreenState extends State<DeleteProductScreen> {
  final _formKey2 = GlobalKey<FormState>();
  final _deleteformKey = GlobalKey<FormState>();
  String deleterespo = '1';
  final imagelink_descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var productidcontroller = TextEditingController();

  void clearText() {
    imagelink_descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  void dispose() {
    productidcontroller.dispose();
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
            title: const Text('Delete Product'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _deleteformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProductTextFormField(
                        readOnly: false,
                        textController: productidcontroller,
                        label: 'Product ID'),
                    Button(
                      label: 'Delete',
                      onPressed: () {
                        if (_deleteformKey.currentState!.validate()) {
                          //add delete function here
                          ProductRepositories(context).delete_product_screen(
                              int.parse(productidcontroller.text));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
