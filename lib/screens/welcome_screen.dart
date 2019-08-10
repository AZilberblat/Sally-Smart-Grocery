<<<<<<< HEAD
<<<<<<< HEAD
import 'dart:math';

=======
>>>>>>> parent of 8c31881... bardoce sound
=======
import 'dart:math';

>>>>>>> parent of 822e52c... UI and functionaloty changes
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sally_smart/screens/checkout_screen.dart';
import 'package:sally_smart/utilities/product_card.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

//List<ProductCard> shoppingList = [];

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _scanBarcode = 'Unknown';
  String productName = 'Product Test';
  double productPrice;
  IconData productIcon = Icons.add_shopping_cart;
  final List<ProductCard> shoppingList = [];
  int productId = 0;

  Future<void> initPlatformState() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes =
          await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          leading: Icon(
            Icons.shopping_basket,
            size: 30,
          ),
          title: Text(
            'Sally',
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 4, fontSize: 25),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    child: Text(
                      'Welcome message',
                      style: kHeaderTextStyle,
                    ),
                  ),
                ),
<<<<<<< HEAD
                DividerSally(),
                shoppingListBuilder(),
                DividerSally(),
=======
                Divider(
                  height: 4,
                  indent: 5,
                  endIndent: 5,
                  color: Colors.blueGrey,
                ),
                Expanded(
                    child: Container(
                  color: Colors.black38,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: shoppingList.length,
                    itemBuilder: (context, index) {
                      ProductCard item = shoppingList[index];
                      return Dismissible(
                          key: Key(item.id),
                          onDismissed: (direction) {
                            setState(() {
                              shoppingList.removeAt(index);
                            });
                          },
                          background: Container(color: Colors.red),
                          child:
                              item //ListTile(title: Text('${item.productName}.')),
                          );
                    },
                  ),
                )),
                Divider(
                  height: 4,
                  indent: 5,
                  endIndent: 5,
                  color: Colors.blueGrey,
                ),
>>>>>>> parent of 822e52c... UI and functionaloty changes
                Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: ScanMainButton(
                          color: Colors.indigo,
                          iconData: Icons.add,
                          buttonText: 'Add Test Product',
                          onPressed: () {
                            productPrice = Random().nextDouble() * 100;
                            setState(() {
                              //adding a ProductCard to the shopping list with the ProductCard const. Works on scan
                              shoppingList.add(
                                ProductCard(
                                  id: productId.toString(),
                                  productName: productName,
                                  productPrice: productPrice.toStringAsFixed(2),
                                  productIcon: productIcon,
                                ),
                              );
                              productId++;
                            });
                            print(shoppingList);
                          }),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          ScanMainButton(
                            iconData: Icons.camera,
                            buttonText: 'סרוק מוצר',
                            onPressed: () async {
                              //Navigator.pushNamed(context, ScanScreen.id);
                              productPrice = Random().nextDouble() * 100;
                              await initPlatformState();
                              //Changes the product name by referencing to the p.name
                              productName = _scanBarcode;
<<<<<<< HEAD
<<<<<<< HEAD
=======
                              productBarCode = _scanBarcode;
>>>>>>> parent of 8c31881... bardoce sound
=======
>>>>>>> parent of 822e52c... UI and functionaloty changes
                              setState(() {
                                //adding a ProductCard to the shopping list with the ProductCard const. Works on scan
                                shoppingList.add(ProductCard(
                                  id: shoppingList.length.toString(),
                                  productName: productName,
                                  productPrice: productPrice.toStringAsFixed(2),
                                  productIcon: productIcon,
                                ));
                              });
                            },
                            color: Colors.teal,
                          ),
                          ScanMainButton(
                              iconData: Icons.check,
                              buttonText: 'Pay Now',
                              color: Colors.green,
                              onPressed: () {
                                Navigator.pushNamed(context, CheckoutScreen.id);
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Expanded shoppingListBuilder() {
    return Expanded(
        child: Container(
      color: Colors.black38,
      child: ListView.builder(
        reverse: true,
        itemCount: shoppingList.length,
        itemBuilder: (context, index) {
          ProductCard item = shoppingList[index];
          return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                setState(() {
                  shoppingList.removeAt(index);
                });
              },
              background: Container(
                child: Icon(
                  Icons.restore_from_trash,
                  size: 40,
                ),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple[200],
                    Colors.deepPurple[300],
                    Colors.deepPurple[400],
                    Colors.deepPurple[600],
                  ],
                  stops: [0.1, 0.3, 0.6, 0.9],
                )),
              ),
              child: item //ListTile(title: Text('${item.productName}.')),
              );
        },
      ),
    ));
  }
}

//class MyShoppingList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    List<ProductCard> myShoppingList = [];
//    for (var item in myShoppingList) {
//      final String productName = 'Test product';
//      final double productPrice = 55.5;
//      final IconData productIcon = Icons.add_shopping_cart;
//      final productCard = ProductCard(
//        productName: productName,
//        productPrice: productPrice,
//        productIcon: productIcon,
//      );
//    }
//    return Column(
//      children: myShoppingList,
//    );
//  }
//}
