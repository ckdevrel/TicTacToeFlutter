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
      home: new Scaffold(
          appBar: new AppBar(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    gameRules.winGame();
                  });
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  'WIN',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    init();
                  });
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  'RESET',
                  style: TextStyle(color: Colors.yellow),
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
            leading: Icon(Icons.home),
            title: new Text('Game'),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    itemCount: gameRules.getCount(),
                    padding: EdgeInsets.all(16),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3),
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
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(jsonData ?? "",
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 10)),
              ),
            ],
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
        childWidget = Container(color: Colors.indigo);
        break;
    }
    return childWidget;
  }
}
