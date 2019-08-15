import 'package:flutter/material.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/round_icon_button.dart';

class ProductCard extends StatefulWidget {
  final String productName;
  final double productPrice;
  final IconData productIcon;
  final String id;
  final String barCode;

  const ProductCard({
    this.productIcon,
    @required this.productName,
    @required this.productPrice,
    @required this.id,
    @required this.barCode,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double finalPrice;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    finalPrice = quantity * widget.productPrice;
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(
            left: 2.0,
          ),
          child: Icon(
            widget.productIcon,
            size: 35,
          ),
        ),
        title: Text(
          widget.productName,
          style: kProductNameTextStyle,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RoundIconButton(
                      icon: Icons.add,
                      color: Colors.green,
                      function: () {
                        setState(() {
                          quantity++;
                        });
                      }),
                  Text(
                    '$quantity',
                  ),
                  RoundIconButton(
                      icon: Icons.remove,
                      color: Colors.red,
                      function: () {
                        setState(() {
                          quantity--;
                          if (quantity == 0) {
                            quantity++;
                          }
                        });
                      }),
                ],
              ),
            ),
            Text(
              '${finalPrice.toStringAsFixed(2)} ₪',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
