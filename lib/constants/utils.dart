import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(text),
  //   ),
  // );
  Fluttertoast.showToast(msg: text);
}
Future<List<XFile>> pickImages() async {
  List<XFile> imagesFile = [];
  try {
    // var files = await FilePicker.platform.pickFiles(
    //   type: FileType.image,
    //   allowMultiple: true,
    // );
    // if (files != null && files.files.isNotEmpty) {
    //   for (int i = 0; i < files.files.length; i++) {
    //     images.add(File(files.files[i].path!));
    //   }
    // }
    final ImagePicker _picker = ImagePicker();
  var images = await _picker.pickMultiImage(imageQuality: 85);
   images.forEach((image) {
       imagesFile.add(XFile(image.path));
   });
  } catch (e) {
    debugPrint(e.toString());
  }
  return imagesFile;
}
