import 'dart:convert';
import 'package:amazon_clone/models/product.dart';

class Order {
  final String orderNo;
  final String sku;
  final String title;
  final String description;
  final List<String> images;
  final int regPrice;
  final String sellerId;
  final String category;
  final int quantity;
  final String shippingAddress;
  final String username;
  final int status;
  final String orderedAt;

  Order(
      {required this.orderNo,
      required this.sku,
      required this.title,
      required this.description,
      required this.images,
      required this.regPrice,
      required this.sellerId,
      required this.category,
      required this.quantity,
      required this.shippingAddress,
      required this.username,
      required this.status,
      required this.orderedAt});

// class Order {
//   final String id;
//   final List<Product> products;
//   final List<int> quantity;
//   final String address;
//   final String userId;
//   final int orderedAt;
//   final int status;
//   final double totalPrice;
//   Order({
//     required this.id,
//     required this.products,
//     required this.quantity,
//     required this.address,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.totalPrice,
//   });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'products': products.map((x) => x.toMap()).toList(),
  //     'quantity': quantity,
  //     'address': address,
  //     'userId': userId,
  //     'orderedAt': orderedAt,
  //     'status': status,
  //     'totalPrice': totalPrice,
  //   };
  // }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderNo: map['Order_No'] ?? '',
      sku:map['SKU']??'',
      title: map['Title'],
      description: map['Description'],
      images: List<String>.from(map['Images']),
      quantity: map["Quantity"],
      regPrice: map["Reg_price"],
      sellerId: map["seller_id"],
      category: map["category"],
      shippingAddress: map['address'] ?? '',
      username: map['username'] ?? '',
      orderedAt: map['Date'] ??'',
      status: map['Status']?.toInt() ?? 0,
    );
  }

  // String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
// }

}
