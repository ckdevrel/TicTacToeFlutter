import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      alignment: Alignment.center,
      child: Icon(Icons.close, color: Colors.yellowAccent, size: 60)
    );
  }
}
