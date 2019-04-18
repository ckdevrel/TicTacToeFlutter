import 'dart:ui';

import 'package:flutter/material.dart';

class GameResultScreen extends StatelessWidget {
  final String message;

  GameResultScreen(this.message);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(44, 62, 80, 1).withOpacity(0.95),
        appBar: AppBar(automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(44, 62, 80, 1).withOpacity(0.95),
            actions: <Widget>[
            IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: () {
              Navigator.pop(context);
            })
        ],),
        body: new BackdropFilter(
          child: new Container(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(message, style: TextStyle(color: Colors.orangeAccent, fontSize: 22, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                )
            ),
          ),
          filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.6),
        )

      ),
    );
  }

}

