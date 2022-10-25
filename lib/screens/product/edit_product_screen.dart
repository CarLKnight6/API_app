import 'dart:async';
import 'package:api_app/Repositories/product_repository.dart';
import 'package:api_app/widgets/button.dart';
import 'package:api_app/widgets/product_textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/dropdownbutton_widget.dart';

class EditProductScreen extends StatefulWidget {
  // edit_product_screen({Key? key, String? token}) : super(key: key);

  int product_id;
  String product_name;
  String product_price;
  int product_userid;
  String product_imagelink;
  int? product_ispublished;
  EditProductScreen(this.product_id, this.product_name, this.product_price,
      this.product_userid, this.product_imagelink, this.product_ispublished);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late int captured_product_id;
  late String captured_product_name;
  late String captured_product_price;
  late int captured_product_userid;
  late String capture_product_imagelink;
  late int? captured_product_ispublished;

  final _formKey2 = GlobalKey<FormState>();

  final descriptioncontroller = TextEditingController();
  Object? is_published;
  var pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var productidcontroller = TextEditingController();
  var productnamecontroller = TextEditingController();
  var productimagelinkcontroller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  final _editproductformKey = GlobalKey<FormState>();
  late StreamController _streamController;
  late Stream _stream;
  late Timer _debounce;
  void clearText() {
    descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    captured_product_id = widget.product_id;
    captured_product_name = widget.product_name;
    captured_product_price = widget.product_price;
    captured_product_userid = widget.product_userid;
    capture_product_imagelink = widget.product_imagelink;
    productidcontroller.text = captured_product_id.toString();
    captured_product_ispublished = widget.product_ispublished;
    _search() async {
      //search function here
      print(captured_product_id);
    }

    @override
    void dispose() {
      productnamecontroller.dispose();
      descriptioncontroller.dispose();
      pricecontroller.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();

      _debounce = 0 as Timer;
    }

    return WillPopScope(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/productlist');
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Edit Product'),
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
                key: _editproductformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProductTextFormField(
                        enabled: false,
                        readOnly: true,
                        hintText: captured_product_id.toString(),
                        textController: productidcontroller,
                        label: 'Product ID'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_name,
                        textController: productnamecontroller,
                        label: 'Product Name'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_price,
                        textController: pricecontroller,
                        label: 'Price'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: captured_product_name,
                        textController: descriptioncontroller,
                        label: 'Description'),
                    ProductTextFormField(
                        readOnly: false,
                        hintText: capture_product_imagelink,
                        textController: productimagelinkcontroller,
                        label: 'Image Link'),
                    DropDownButtonWidget(
                      label: 'Is published?',
                      value: is_published,
                      onChanged: (newValue) {
                        setState(() {
                          is_published = newValue;
                        });
                      },
                      items:
                          <int>[1, 0].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    Button(
                      label: 'Update',
                      onPressed: () {
                        if (_editproductformKey.currentState!.validate()) {
                          _search();
                          ProductRepositories(context).edit_product_screen(
                              captured_product_id,
                              captured_product_userid,
                              productnamecontroller.text,
                              productimagelinkcontroller.text,
                              descriptioncontroller.text,
                              pricecontroller.text,
                              is_published as int);
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
