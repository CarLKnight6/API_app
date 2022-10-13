import 'dart:ffi';

class Product {
  int id;
  int user_id;
  String name;
  String price;
  int? current_page;
  int? last_page;

  Product(
      {required this.id,
      required this.user_id,
      required this.name,
      required this.price,
      this.current_page,
      this.last_page});
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
  String password_confirmation;

  Registerdetails(
      {required this.name,
      required this.email,
      required this.password,
      required this.password_confirmation});
}

class Productdetails {
  String name;
  String? image_link;
  String? description;
  String price;
  Bool is_published;

  Productdetails(
      {required this.name,
      this.image_link,
      this.description,
      required this.price,
      required this.is_published});
}

class ProductID {
  int id;
  ProductID({
    required this.id,
  });
}

class UpdateProduct {
  int id;
  int user_id;
  String name;
  String? image_link;
  String? description;
  String price;
  Bool? is_published;

  UpdateProduct(
      {required this.id,
      required this.user_id,
      required this.name,
      this.image_link,
      this.description,
      required this.price,
      this.is_published});
}
