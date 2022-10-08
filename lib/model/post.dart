class Product {
  int id;
  int user_id;
  String name;
  String price;

  Product(
      {required this.id,
      required this.user_id,
      required this.name,
      required this.price});
}

class Logindetails {
  String email;
  String password;

  Logindetails({required this.email, required this.password});
}
