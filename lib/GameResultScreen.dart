import 'package:flutter/material.dart';

class GameResultScreen extends StatelessWidget {
  final String message;

  GameResultScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 62, 80, 1).withOpacity(0.95),
      appBar: AppBar(automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(44, 62, 80, 1).withOpacity(0.95),
          actions: <Widget>[
          IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: () {
            Navigator.pop(context);
          })
      ],),
      body: Center(
          child: Text(message, style: TextStyle(color: Colors.orangeAccent, fontSize: 28))
      ),
    );
  }

}

