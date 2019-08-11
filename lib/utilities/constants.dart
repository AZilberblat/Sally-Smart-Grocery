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
  fontFamily: 'SecularOne',
);

const kHeaderTextStyle =
    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4, fontSize: 25);

const kProductNameTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 12);

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  icon: Icon(
    Icons.search,
  ),
  alignLabelWithHint: true,
  hintStyle: TextStyle(color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
