import 'package:flutter/material.dart';

class ProductModel {
  String? image, name, description, category;
  double? price;
  Color? color;
  int? id;

  ProductModel(
      {required this.price,
      required this.image,
      required this.id,
      required this.color,
      required this.category,
      required this.name,
      required this.description});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = getColor(json['color']);
    category = json['category'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }

  getColor(String color) {
    return Color(int.parse(color));
  }
}
