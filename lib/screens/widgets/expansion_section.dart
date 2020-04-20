import 'package:flutter/material.dart';

class ExpansionSection extends StatefulWidget {
  final Widget child;
  final String title;
  final TextStyle titleStyle;
  final Widget action;
  final EdgeInsets padding;

  const ExpansionSection({
    Key key,
    @required this.child,
    this.title,
    this.titleStyle = const TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    this.action,
    this.padding = const EdgeInsets.symmetric(horizontal: 30),
  }) : super(key: key);

  @override
  _ExpansionSectionState createState() => _ExpansionSectionState();
}

class _ExpansionSectionState extends State<ExpansionSection> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          widget.title,
          style: widget.titleStyle,
        ),
      ),
      trailing: widget.action,
      children: [widget.child],
      onExpansionChanged: (bool isExpanded) {},
    );
  }
}
