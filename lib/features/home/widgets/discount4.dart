import 'package:flutter/material.dart';

class ElectronicSale extends StatelessWidget {
  const ElectronicSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        height: size.height * 0.1,
        width: size.width * 0.9,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 86, 198, 232),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "Mega electronic days",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text("23-25 Dec upto 70% off",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20))
          ],
        ));
  }
}
