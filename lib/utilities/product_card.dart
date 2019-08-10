import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final IconData productIcon;
  final String id;

  const ProductCard(
      {this.productIcon,
      @required this.productName,
      @required this.productPrice,
      @required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
          leading: Padding(
            padding: EdgeInsets.only(left: 5.0, right: 10),
            child: Icon(
              widget.productIcon,
              size: 35,
            ),
          ),
          title: Text(widget.productName),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$finalPrice ₪',
              ),
              SizedBox(
                width: 40,
              ),
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
              Text('$quantity'),
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
              SizedBox(
                width: 15,
              ),
            ],
=======
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 10),
          child: Icon(
            productIcon,
            size: 35,
>>>>>>> parent of 822e52c... UI and functionaloty changes
          ),
        ),
        title: Text(productName),
        subtitle: Text('${productPrice.toString()} ₪'),
        trailing: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.redAccent,
            ),
<<<<<<< HEAD
          )),
>>>>>>> parent of 8c31881... bardoce sound
=======
            onPressed: () {}),
      ),
>>>>>>> parent of 822e52c... UI and functionaloty changes
    );
  }
}
