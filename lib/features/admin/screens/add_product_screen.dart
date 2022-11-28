import 'dart:io';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/cateogory.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
   AddProductScreen({Key? key,required this.products}) : super(key: key);
  List<Product> products;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  List<Categories> productCategories = [];
  String category = 'Appliances';
  Map<String, String> mp = {};
  List<XFile> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchAllCategories();
  }

  fetchAllCategories() async {
    productCategories = await adminServices.fetchCategory(context);
    for (var x in productCategories) {
      mp[x.title] = x.categoryId;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  // List<String> productCategories = [
  //   'Mobiles',
  //   'Essentials',
  //   'Appliances',
  //   'Books',
  //   'Fashion'
  // ];

  void sellProduct() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final email = userProvider.user.email;
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: int.parse(priceController.text),
          quantity: int.parse(quantityController.text),
          category: mp[category],
          images: images,
          sellerId: email,
          id: idController.text,
          keywords: keywordController.text,
          products: widget.products);
    }
  } 

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: const Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body:productCategories.isEmpty
        ? const Loader(): SingleChildScrollView(
              child: Form(
                key: _addProductFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      images.isNotEmpty
                          ? CarouselSlider(
                              items: images.map(
                                (i) {
                                  return Builder(
                                    builder: (BuildContext context) =>
                                        Image.file(
                                      File(i.path),
                                      fit: BoxFit.cover,
                                      height: 200,
                                    ),
                                  );
                                },
                              ).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : GestureDetector(
                              onTap: selectImages,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Select Product Images',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: productNameController,
                        hintText: 'Product Name',
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: idController,
                        hintText: 'SKU',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: keywordController,
                        hintText: 'Keyword',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'Description',
                        maxLines: 7,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: priceController,
                        hintText: 'Price',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: quantityController,
                        hintText: 'Quantity',
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: productCategories.map((Categories item) {
                            return DropdownMenuItem(
                              value: item.title,
                              child: Text(item.title),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Sell',
                        onTap: sellProduct,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
