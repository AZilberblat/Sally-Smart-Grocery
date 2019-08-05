import 'package:flutter/material.dart';

class ScanMainButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final String buttonText;
  final Color color;
  const ScanMainButton(
      {this.iconData,
      @required this.buttonText,
      @required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: color,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
