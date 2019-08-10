import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(left: 5.0, right: 10),
          child: Icon(
            widget.productIcon,
            size: 35,
          ),
        ),
        title: Text(widget.productName),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.tealAccent,
                        size: 37,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });

                        print('$quantity');
                      }),
                  SizedBox(width: 3),
                  Text(
                    '$quantity',
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.do_not_disturb_on,
                        color: Colors.red[200],
                        size: 37,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity--;
                          if (quantity == 0) {
                            quantity++;
                          }
                        });

                        print('$quantity');
                      }),
                ],
              ),
            )
          ],
        ),
        trailing: Text(
          '$finalPrice ₪',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
