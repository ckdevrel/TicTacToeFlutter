import 'package:flutter/material.dart';

class WinWidget extends StatelessWidget {
  var text;
  WinWidget(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.indigo,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.yellowAccent, fontSize: 36))
    );
  }
}