import 'package:flutter/material.dart';
import 'package:sally_smart/utilities/scan_button_const.dart';

class ScanScreen extends StatefulWidget {
  static const String id = 'scan_screen';
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'ScanScreen',
              style: TextStyle(fontSize: 40),
            ),
          ),
          ScanMainButton(
            iconData: Icons.backspace,
            buttonText: 'חזור',
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.teal,
          )
        ],
      ),
    );
  }
}
