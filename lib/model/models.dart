import 'dart:ffi';

class Product {
  int id;
  int userid;
  String name;
  String price;
  int? currentpage;
  int? lastpage;

  Product(
      {required this.id,
      required this.userid,
      required this.name,
      required this.price,
      this.currentpage,
      this.lastpage});
}

class Logindetails {
  String email;
  String password;

  Logindetails({required this.email, required this.password});
}

class Registerdetails {
  String name;
  String email;
  String password;
  String passwordconfirmation;

  Registerdetails(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordconfirmation});
}

class Productdetails {
  String name;
  String? imagelink;
  String? description;
  String price;
  Bool ispublished;

  Productdetails(
      {required this.name,
      this.imagelink,
      this.description,
      required this.price,
      required this.ispublished});
}

class ProductID {
  int id;
  ProductID({
    required this.id,
  });
}

class UpdateProduct {
  int id;
  int userid;
  String name;
  String? imagelink;
  String? description;
  String price;
  Bool? ispublished;

  UpdateProduct(
      {required this.id,
      required this.userid,
      required this.name,
      this.imagelink,
      this.description,
      required this.price,
      this.ispublished});
}
