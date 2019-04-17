import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe/ComputerWidget.dart';
import 'package:tictactoe/GameConstants.dart';
import 'package:tictactoe/GameRules.dart';
import 'package:tictactoe/GameState.dart';
import 'package:tictactoe/PlayerWidget.dart';
import 'package:tictactoe/WinWidget.dart';
import 'package:connectivity/connectivity.dart';

import 'GameResultScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  GameRules gameRules;
  bool isDisableClick = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    gameRules = new GameRules();
    gameRules.initGameRules();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return  Scaffold(
          backgroundColor: Colors.grey.shade200,
            appBar: new AppBar(
              centerTitle: false,
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
                    return new GestureDetector(
                      child: getGridRow(value),
                      onTap: () {
                        if (!isDisableClick && gameRules.isNewMove(index)) {
                          isNetworkAvailable().then((isThere) {
                            if (isThere) {
                              setState(() {
                                gameRules.updateState(
                                    index,
                                    GameState(
                                        position: gameState.position,
                                        value: GameConstants.PLAYER));
                                isDisableClick = true;
                              });
                              postData(context);
                            } else {
                              loadMessagePopup(context, "No internet connection");
                            }
                          });
                        }
                      },
                    );
                  }),
            ));
      })

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

  Future<void> postData(BuildContext context) async {
    debugPrint("Printing request " + gameRules.getBoardJSON());
    http.Response res = await http.post(
        GameConstants.URL,
        body: gameRules.getBoardJSON());
    debugPrint("Response body " + res.body.toString());
    setState(() {
      isDisableClick = false;
      var response = gameRules.getGameStatesFromResponse(res.body);
      var status = response.gameStatus;

      if(status == GameConstants.STATUS_INPROGRESS){
        gameRules.updateStates(response.gameStates);
      } else {
        loadMessagePopup(context, status);
      }
    });
  }

  Future<void> loadMessagePopup(BuildContext context, String message) async {
    init();
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            GameResultScreen(message)));
  }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
