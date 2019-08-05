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
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      ProductCard(
                        productName: 'Banana',
                        productPrice: 32.6,
                        productIcon: Icons.face,
                      ),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(Icons.add_shopping_cart),
                          title: Text('Test'),
                        ),
                      ),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(Icons.add_shopping_cart),
                          title: Text('Test'),
                        ),
                      ),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: Icon(Icons.add_shopping_cart),
                          title: Text('Test'),
                        ),
                      ),
                    ],
                  )),
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
