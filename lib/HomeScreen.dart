import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tictactoe/ComputerWidget.dart';
import 'package:tictactoe/GameConstants.dart';
import 'package:tictactoe/GameRules.dart';
import 'package:tictactoe/GameState.dart';
import 'package:tictactoe/PlayerWidget.dart';
import 'package:tictactoe/WinWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  GameRules gameRules;

  bool isChecked = false;

  String jsonData;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    gameRules = new GameRules();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Color.fromRGBO(44, 62, 80, 1),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    init();
                  });
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  'RESET',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Switch(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  }),
            ],
            title: new Text('Tic Tac Toe'),
          ),
          body: Center(
            child: GridView.builder(
              shrinkWrap: true,
                itemCount: gameRules.getCount(),
                padding: EdgeInsets.all(16),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 3, crossAxisSpacing: 3),
                itemBuilder: (BuildContext context, int index) {
                  GameState gameState = gameRules.getGameState(index);
                  String value = gameState.getValue;
                  getGridRow(value);
                  return new GestureDetector(
                    child: getGridRow(value),
                    onTap: () {
                      if (gameRules.isNewMove(index)) {
                        setState(() {
                          this.gameRules.updateState(
                              index,
                              GameState(
                                  position: gameState.position,
                                  value: isChecked
                                      ? GameConstants.COMPUTER
                                      : GameConstants.PLAYER));
                          jsonData = gameRules.getJSON();
                        });
                      }
                    },
                  );
                }),
          )),
    );
  }

  Widget getGridRow(String value) {
    Widget childWidget;
    switch (value) {
      case GameConstants.PLAYER:
        childWidget = PlayerWidget();
        break;
      case GameConstants.COMPUTER:
        childWidget = ComputerWidget();
        break;
      case 'W':
        childWidget = WinWidget('W');
        break;
      case 'I':
        childWidget = WinWidget('I');
        break;
      case 'N':
        childWidget = WinWidget('N');
        break;
      default:
        childWidget = Container(color: Colors.indigoAccent);
        break;
    }
    return childWidget;
  }
}
