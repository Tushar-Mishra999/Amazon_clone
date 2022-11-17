import 'dart:convert';
import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String? category;
  final double price;
  final String id;
  final String keywords;
  final List<Rating>? rating;
  final String sellerId;
  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      this.category,
      required this.price,
      required this.id,
      this.rating,
      required this.keywords,
      required this.sellerId});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'inventory': quantity,
      'images': images,
      'category': category,
      'reg_price': price,
      'seller_id':sellerId,
      'keywords':keywords,
      'sku': id,
      //'rating': rating,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['Title'] ?? '',
      description: map['Description'] ?? '',
      quantity: map['Inventory']?.toDouble() ?? 0.0,
      images: List<String>.from(map['Images']),
      category: map['category'] ?? '',
      price: map['Reg_price']?.toDouble() ?? 0.0,
      id: map['SKU'],
      keywords: map['keywords'],
      sellerId: map['seller_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
