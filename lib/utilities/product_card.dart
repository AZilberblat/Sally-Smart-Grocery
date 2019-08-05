import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final double productPrice;
  final IconData productIcon;
  final String id;

  const ProductCard(
      {this.productIcon,
      @required this.productName,
      @required this.productPrice,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 10),
          child: Icon(
            productIcon,
            size: 35,
          ),
        ),
        title: Text(productName),
        subtitle: Text('${productPrice.toString()} ₪'),
        trailing: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.redAccent,
            ),
            onPressed: () {}),
      ),
    );
  }
}
