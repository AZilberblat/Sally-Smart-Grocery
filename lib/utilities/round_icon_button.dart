import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, this.function, this.color});
  final IconData icon;
  final Function function;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: function,
      elevation: 5.0,
      constraints: BoxConstraints.tightFor(width: 25.0, height: 25.0),
      fillColor: color,
      shape: CircleBorder(),
    );
  }
}
