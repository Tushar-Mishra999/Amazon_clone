import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);
  bool isMount = true;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    widget.isMount = true;
    super.initState();
    fetchAllProducts();
  }

  @override
  void dispose() {
    widget.isMount = false;
    super.dispose();
  }

  Future<void >fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    if (widget.isMount) {
      setState(() {});
    }
  }

  void deleteProduct(String id, int index) {
    adminServices.deleteProduct(
      context: context,
      id: id,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName,
        arguments: products);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : products!.isEmpty
            ? const Center(
                child: Text(
                "No products found",
                style: TextStyle(fontSize: 20),
              ))
            : Scaffold(
                body: RefreshIndicator(
                  onRefresh: fetchAllProducts,
                  child: Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: products!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final productData = products![index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child: SingleProduct(
                                image: productData.images[0],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      deleteProduct(productData.id, index),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: navigateToAddProduct,
                  tooltip: 'Add a Product',
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
  }
}
