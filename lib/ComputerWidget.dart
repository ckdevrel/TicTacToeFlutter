import 'package:flutter/material.dart';

class ComputerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.indigoAccent,
        alignment: Alignment.center,
        child: CircleAvatar(backgroundColor: Colors.pinkAccent, radius: 30));
  }
}
