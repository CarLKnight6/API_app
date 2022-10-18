import 'package:api_app/Repositories/product_repository.dart';
import 'package:api_app/screens/product/edit_product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/models.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key, String? token}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _formKey2 = GlobalKey<FormState>();

  final descriptioncontroller = TextEditingController();

  final pricecontroller = TextEditingController();
  TextEditingController ispublishedcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  int page = 1;
  int last_page = 1;
  void clearText() {
    descriptioncontroller.clear();
    pricecontroller.clear();
  }

  @override
  void dispose() {
    descriptioncontroller.dispose();
    pricecontroller.dispose();
    ispublishedcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() async {
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
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Product List'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_left),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  if (page > 0) {
                    setState(() {
                      page--;
                      ProductRepositories(context).getAllProducts(page);
                    });
                  } else if (page == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('end of page')));
                  }

                  print(page);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('end of page')));
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                tooltip: 'Show Snackbar',
                onPressed: () async {
                  SharedPreferences lastpage =
                      await SharedPreferences.getInstance();
                  if (page < lastpage.getInt('last_page')!) {
                    setState(() {
                      page++;
                      ProductRepositories(context).getAllProducts(page);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('end of page')));
                  }
                },
              ),
            ],
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder<List<Product>>(
              future: ProductRepositories(context).getAllProducts(page),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Product> products = snapshot.data!;
                  return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        Product product = products[index];

                        return InkWell(
                          onTap: () {
                            print(product.id);
                            var productId = product.id;
                            var productName = product.name;
                            var productPrice = product.price;
                            var productUserid = product.userid;
                            var productImagelink = product.imagelink;
                            var productIspublished = product.is_published;

                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => EditProductScreen(
                                    productId,
                                    productName,
                                    productPrice,
                                    productUserid,
                                    productImagelink,
                                    productIspublished),
                              ),
                            )
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Colors.white12,
                              height: 200.0,
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            color: Colors.transparent,
                                            height: 100.0,
                                            width: double.infinity,
                                            child: Text(
                                              '${product.name}\n Product details here..',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.transparent,
                                          height: 60.0,
                                          width: double.infinity,
                                          child: Column(
                                            children: <Widget>[
                                              Text('\$ ${product.price}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              Text(
                                                  'ID ${product.id.toString()}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              Text(
                                                  'Is published? ${product.is_published.toString()}',
                                                  style: GoogleFonts.openSans(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(40),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Colors.transparent
                                      //           .withOpacity(0.5),
                                      //       offset: Offset(0, 25),
                                      //       blurRadius: 3,
                                      //       spreadRadius: -10)
                                      // ], https://www.trustedreviews.com/wp-content/uploads/sites/54/2022/03/best-phone-2022-920x613.jpg
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child:

                                          //  product.imagelink.isNotEmpty
                                          // ? Image.network(product.imagelink,
                                          //     fit: BoxFit.fill)
                                          // :
                                          Uri.parse(product.imagelink)
                                                  .isAbsolute
                                              ? Image.network(
                                                  product.imagelink,
                                                  fit: BoxFit.fill,
                                                )
                                              : Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/error_img.jpg"),
                                                      fit: BoxFit.cover),
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )),
      onWillPop: () async {
        return false;
      },
    );
  }
}
