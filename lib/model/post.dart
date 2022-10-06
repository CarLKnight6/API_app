// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageLink,
    required this.description,
    required this.price,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String name;
  String imageLink;
  String description;
  String price;
  int isPublished;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        imageLink: json["image_link"],
        description: json["description"] == null ? null : json["description"],
        price: json["price"],
        isPublished: json["is_published"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "image_link": imageLink,
        "description": description == null ? null : description,
        "price": price,
        "is_published": isPublished,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
