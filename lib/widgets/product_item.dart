import 'package:agenceteste/models/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            product.image,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 35,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                )),
            child: Text(product.name),
          ),
        )
      ]),
    );
  }
}
