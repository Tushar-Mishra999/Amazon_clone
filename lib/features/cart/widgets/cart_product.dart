import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../common/widgets/loader.dart';

class CartProduct extends StatefulWidget {
  final Product product;
  const CartProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();
  bool isLoaded = false;

  void increaseQuantity(Product product) async {
    isLoaded = true;
    setState(() {});
    await cartServices.addToCart(
        context: context, product: product, quantity: product.quantity + 1);
    isLoaded = false;
    setState(() {});
  }

  void decreaseQuantity(Product product) async {
    isLoaded = true;
    setState(() {});
    await cartServices.removeFromCart(
      context: context,
      product: product,
      quantity: product.quantity - 1,
    );
    isLoaded = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      if (isLoaded) const Center(child: Loader()),
      Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage.memoryNetwork(
                  image: widget.product.images[0],
                  fit: BoxFit.fitHeight,
                  placeholder: kTransparentImage,
                  width: 80,
                ),
                SizedBox(width: size.width * 0.07),
                Column(
                  children: [
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\₹${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text('Eligible for FREE Shipping'),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreaseQuantity(widget.product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            widget.product.quantity.toString(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(widget.product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
