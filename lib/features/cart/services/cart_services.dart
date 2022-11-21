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

class CartServices {
  Future<List<Product>> fetchCartProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$userUri/cart?username=${userProvider.user.email}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromCartJson(
                jsonEncode(
                  jsonDecode(res.body)['cart'][i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> addToCart(
      {required BuildContext context,
      required Product product,
      required int quantity}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.put(
        Uri.parse('$userUri/cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'sku': product.id,
          'quantity': quantity,
          'username': userProvider.user.email
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          userProvider.updateQuantity(userProvider.user, quantity, product);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required Product product,
    required int quantity,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.put(
        Uri.parse('$userUri/cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'sku': product.id,
          'quantity': quantity,
          'username': userProvider.user.email
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          userProvider.updateQuantity(userProvider.user, quantity, product);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
