import '../model/models.dart';

abstract class ProductRepositoryInterface {
  Future<List<Productdetails>?> AddProduct(String name, String imageLink,
      String description, String price, int isPublished);

  Future<List<ProductID>?> delete_product_screen(int id);
  Future<List<UpdateProduct>?> edit_product_screen(
      int id,
      int userId,
      String name,
      String imageLink,
      String description,
      String price,
      int isPublished);

  Future<List<Product>> getAllProducts(int? page);
}
