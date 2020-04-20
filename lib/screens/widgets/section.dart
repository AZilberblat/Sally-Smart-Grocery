import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  final String title;
  final TextStyle titleStyle;
  final Widget action;
  final EdgeInsets padding;

  const Section(
      {Key key,
      @required this.child,
      this.title,
      this.titleStyle = const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      this.action,
      this.padding = const EdgeInsets.symmetric(horizontal: 30)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          if (action != null)
            Positioned(top: padding.top - 15, right: 5, child: action),
          Padding(
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      title,
                      style: titleStyle,
                    ),
                  ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
