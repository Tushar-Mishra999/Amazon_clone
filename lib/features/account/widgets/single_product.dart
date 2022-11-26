import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10),
          child: FadeInImage.memoryNetwork(
            image:image,
            fit: BoxFit.fitHeight,
            placeholder: kTransparentImage,
            width: 180,
          ),
        ),
      ),
    );
  }
}