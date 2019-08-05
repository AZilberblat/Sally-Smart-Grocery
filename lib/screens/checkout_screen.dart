import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  static const String id = 'checkout_screen';
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        'Soon To Come',
        style: TextStyle(fontSize: 60, color: Colors.white),
      ),
    ));
  }
}
