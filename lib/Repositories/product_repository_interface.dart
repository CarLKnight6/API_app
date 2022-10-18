import 'dart:ffi';

import '../model/models.dart';

abstract class ProductRepositoryInterface {
  Future<List<Productdetails>?> AddProduct(String name, String image_link,
      String description, String price, int is_published);

  Future<List<ProductID>?> delete_product_screen(int id);
  Future<List<UpdateProduct>?> edit_product_screen(
      int id,
      int user_id,
      String name,
      String image_link,
      String description,
      String price,
      int is_published);

  Future<List<Product>> getAllProducts(int? page);
}
