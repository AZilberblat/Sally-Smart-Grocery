import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sally_smart/change_notifiers/cart_change_notifier.dart';
import 'package:sally_smart/utilities/constants.dart';
import 'package:sally_smart/utilities/product.dart';
import 'package:sally_smart/utilities/round_icon_button.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({@required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double finalPrice;

  int get quantity => widget.product.quantity;

  @override
  Widget build(BuildContext context) {
    finalPrice = quantity * widget.product.price;
    return Card(
      elevation: 5.0,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(
            left: 2.0,
          ),
          child: Icon(
            Icons.account_circle,
            size: 35,
          ),
        ),
        title: Text(
          widget.product.name,
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
                        Provider.of<CartNotifier>(context)
                            .increment(widget.product);
                      }),
                  Text(
                    '$quantity',
                  ),
                  RoundIconButton(
                      icon: Icons.remove,
                      color: Colors.red,
                      function: () {
                        Provider.of<CartNotifier>(context)
                            .decrement(widget.product);
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
