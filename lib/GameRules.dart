import 'package:tictactoe/GameState.dart';
import 'dart:convert' show json;

class GameRules {
  List<GameState> gameStates;

  GameRules() {
    gameStates = [
      GameState(position: "0,0"),
      GameState(position: "0,1"),
      GameState(position: "0,2"),
      GameState(position: "1,0"),
      GameState(position: "1,1"),
      GameState(position: "1,2"),
      GameState(position: "2,0"),
      GameState(position: "2,1"),
      GameState(position: "2,2"),
    ];
  }

  void updateState(int position, GameState gameState) {
    gameStates[position] = gameState;
  }

  int getCount() {
    return gameStates.length;
  }

  GameState getGameState(int position) {
    return gameStates[position];
  }

  bool isNewMove(int position) {
    return gameStates[position].value == null;
  }

  String getBoardJSON() {
    final dyn = new List<dynamic>.from(
        gameStates.map((gameState) => gameState.toJson()));
    return json.encode(dyn);
  }

    List<GameState> getGameStatesFromResponse(String data) {
      final jsonData = json.decode(data);
      return new List<GameState>.from(jsonData.map((x) => GameState.fromJson(x)));
    }

    void updateStates(List<GameState> gameStateList) {
      gameStates.clear();
      gameStates.addAll(gameStateList);
    }
  }
