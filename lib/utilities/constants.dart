import 'package:flutter/material.dart';

class DividerSally extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 4,
      indent: 5,
      endIndent: 5,
      color: Colors.black,
    );
  }
}

const kAppBarMessagesTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w900,
  fontFamily: 'Nehama',
);

const kHeaderTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 25,
    fontFamily: 'Avraham');

const kProductNameTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 12);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  filled: true,
  fillColor: Color(0x8C03434D),
  alignLabelWithHint: true,
  hintStyle:
      TextStyle(color: Color(0x8CFFFFFF), fontFamily: 'Nehama', fontSize: 20),
  labelStyle: TextStyle(color: Colors.white70, fontFamily: 'Nehama'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black38, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kBackgroundGradientScan = BoxDecoration(
  gradient: LinearGradient(colors: [
    Color(0xFF21bacf),
    Color(0xFF027a8b),
    Color(0xFF046D7D)
  ], stops: [
    0.2,
    0.5,
    0.7,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
);

const kBackgroundGradientRegister = BoxDecoration(
  gradient: LinearGradient(colors: [
    Color(0xFF21bacf),
    Color(0xFF0689CA),
    Color(0xFF064ECA)
  ], stops: [
    0.2,
    0.5,
    0.7,
  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
);
