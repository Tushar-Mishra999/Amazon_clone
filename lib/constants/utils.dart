import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackBar(BuildContext context, String text) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(text),
  //   ),
  // );
  Fluttertoast.showToast(msg: text);
}
