import 'package:flutter/material.dart';

class GameResultScreen extends StatelessWidget {
  final String message;

  GameResultScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.indigoAccent.shade100,
      body: Center(
          child: Text(message)
      ),
    );
  }

}

