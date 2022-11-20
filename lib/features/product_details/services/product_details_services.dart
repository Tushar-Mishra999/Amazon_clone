import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Product> fetchProduct(BuildContext context, String sku) async {
     Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0,
        keywords: '',
        sellerId: '',
        rating: 0,
        review: 0,
        id: '');
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await http.get(Uri.parse(
          "$userUri/products?sku=$sku&username=${userProvider.user.email}"));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        product = Product.fromMap(body["product"]);
        
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double review,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$userUri/review'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'sku': product.id,
          'review': review,
          'username':userProvider.user.email
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
