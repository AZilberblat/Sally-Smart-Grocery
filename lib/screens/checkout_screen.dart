import 'package:flutter/material.dart';
import 'package:sally_smart/utilities/constants.dart';

class CheckoutScreen extends StatefulWidget {
  static const String id = 'checkout_screen';
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF21bacf),
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.black54,
          leading: Icon(
            Icons.shopping_basket,
            size: 30,
          ),
          title: Text(
            'Sally',
            style: kHeaderTextStyle,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF21bacf),
              Color(0xFF027a8b),
              Color(0xFF046D7D)
            ], stops: [
              0.1,
              0.3,
              0.7,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Center(
            child: Hero(
              tag: 'Sally',
              child: CircleAvatar(
                backgroundImage: AssetImage('images/missing_avatar_F.png'),
                maxRadius: 140,
              ),
            ),
          ),
        ));
  }
}
