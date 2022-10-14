import 'package:api_app/Repositories/product_repositories.dart';
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

    // Future<void> delete_product_screen(String id) async {
    //   var jsonResponse;
    //   Map data = {
    //     'id': productidcontroller.text,
    //   };
    //   print(data);
    //   print("the first token $token");

    //   String body = json.encode(data);

    //   Uri url = Uri.parse(
    //       "${AppConfig().api_BASEURL}/api/products/${productidcontroller.text}");
    //   var response = await http.delete(
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

    //   if (response.statusCode == 200 && response.body == deleterespo) {
    //     jsonResponse = json.decode(response.body.toString());

    //     Navigator.pushNamed(context, '/homescreen');
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Successfully deleted the product')));

    //     print('success');
    //   } else {
    //     print('error');
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text('Invalid credential')));
    //   }
    // }

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
            title: Text('Delete Product'),
            backgroundColor: Colors.transparent,
          ),
          body: FractionallySizedBox(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            child: Container(
              decoration: BoxDecoration(
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
