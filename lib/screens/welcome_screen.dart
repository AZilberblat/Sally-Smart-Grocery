import 'package:flutter/material.dart';
import 'package:sally_smart/utilities/product_card.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

import 'scan_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String productName = 'Product Test';
  double productPrice = 55.5;
  IconData productIcon = Icons.add_shopping_cart;
//  List<ProductCard> tempShoppingList = [];
  List<ProductCard> shoppingList = [];

//  List<ProductCard> reverseList() {
//    List<ProductCard> myShoppingList = tempShoppingList.reversed;
//
//    return myShoppingList;
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.shopping_basket),
          title: Text(
            'Sally',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    child: Text(
                      'Welcome Message',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  reverse: true,
                  itemCount: shoppingList.length,
                  itemBuilder: (context, index) {
                    return shoppingList[index];
                  },
//                  children: myShoppingList,
                )),
//                Expanded(
//                  child: Padding(
//                    padding: EdgeInsets.all(10.0),
//                    child: Container(
//                        child: Column(
//                      children: <Widget>[
//                        ProductCard(
//                          productName: 'Banana',
//                          productPrice: 32.6,
//                          productIcon: Icons.face,
//                        ),
//                        Card(
//                          elevation: 5.0,
//                          child: ListTile(
//                            leading: Icon(Icons.add_shopping_cart),
//                            title: Text('Test'),
//                          ),
//                        ),
//                        Card(
//                          elevation: 5.0,
//                          child: ListTile(
//                            leading: Icon(Icons.add_shopping_cart),
//                            title: Text('Test'),
//                          ),
//                        ),
//                        Card(
//                          elevation: 5.0,
//                          child: ListTile(
//                            leading: Icon(Icons.add_shopping_cart),
//                            title: Text('Test'),
//                          ),
//                        ),
//                      ],
//                    )),
//                  ),
//                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: ScanMainButton(
                          color: Colors.indigo,
                          iconData: Icons.add,
                          buttonText: 'Add Test Product',
                          onPressed: () {
                            setState(() {
                              shoppingList.add(ProductCard(
                                productName: productName,
                                productPrice: productPrice,
                                productIcon: productIcon,
                              ));
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
                            onPressed: () {
                              Navigator.pushNamed(context, ScanScreen.id);
                            },
                            color: Colors.teal,
                          ),
                          ScanMainButton(
                              buttonText: 'סרוק מוצר', onPressed: () {}),
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
