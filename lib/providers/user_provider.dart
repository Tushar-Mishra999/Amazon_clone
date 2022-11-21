import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void updateQuantity(User user, int quantity,Product product) {
    for (var element in user.cart) {
        if(product.id==element.id){
          element.quantity=quantity;
        }
    }
    _user = user;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
