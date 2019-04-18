import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/ComputerWidget.dart';
import 'package:tictactoe/GameConstants.dart';
import 'package:tictactoe/GameRules.dart';
import 'package:tictactoe/GameState.dart';
import 'package:tictactoe/PlayerWidget.dart';
import 'package:tictactoe/WinWidget.dart';

import 'GameResultScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  GameRules gameRules;
  bool isDisableClick = false;

  Dio dio;

  @override
  void initState() {
    super.initState();
    init();
    dio = Dio();
    dio.options.connectTimeout = 1500; //5s
    dio.options.receiveTimeout = 1500;
  }

  void init() {
    gameRules = new GameRules();
    gameRules.initGameRules();
    isDisableClick = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: new AppBar(
                centerTitle: false,
                backgroundColor: Color.fromRGBO(44, 62, 80, 1),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        init();
                        isDisableClick = false;
                      });
                    },
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'RESET',
                      style: TextStyle(color: Colors.orangeAccent),
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
                        crossAxisCount: 3,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3),
                    itemBuilder: (BuildContext context, int index) {
                      GameState gameState = gameRules.getGameState(index);
                      String value = gameState.getValue;
                      return new GestureDetector(
                        child: getGridRow(value),
                        onTap: () {
                          if (!isDisableClick && gameRules.isNewMove(index)) {
                                setState(() {
                                  gameRules.updateState(
                                      index,
                                      GameState(
                                          position: gameState.position,
                                          value: GameConstants.PLAYER));
                                  isDisableClick = true;
                                });
                                postData(context);
                          }
                        },
                      );
                    }),
              ));
        }));
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
    try {
      debugPrint("Printing request " + gameRules.getBoardJSON());
      var response =  await dio.post(GameConstants.URL, data: gameRules.getBoardJSON());
      debugPrint("Response body " + response.data.toString());
      setState(() {
        isDisableClick = false;
        if (response.statusCode == GameConstants.RESULT_OK) {
          var gameResponse = gameRules.getGameStatesFromResponse(response.data);
          var gameStatus = gameResponse.gameStatus;

          if (gameStatus == GameConstants.STATUS_INPROGRESS) {
            gameRules.updateStates(gameResponse.gameStates);
          } else {
            loadMessagePopup(context, gameStatus);
          }
        }
      });
    } catch (error) {
      _handleError(context, error);
    }
  }

  String _handleError(BuildContext context, Error error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout!";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "No internet connection. Retry";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Timeout. You won!";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${error.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    loadMessagePopup(context, errorDescription);
    return errorDescription;
  }

  Future<void> loadMessagePopup(BuildContext context, String message) async {
    setState(() {
      init();
    });

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
