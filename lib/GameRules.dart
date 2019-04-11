import 'package:tictactoe/GameState.dart';

class GameRules {
  List<GameState> gameStates;

  GameRules() {
    gameStates = [
      GameState(position: "1,1"),
      GameState(position: "1,2"),
      GameState(position: "1,3"),
      GameState(position: "2,1"),
      GameState(position: "2,2"),
      GameState(position: "2,3"),
      GameState(position: "3,1"),
      GameState(position: "3,2"),
      GameState(position: "3,3")
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

  String getJSON() {
    return gameStates
        .map((gameState) =>
            {"position": gameState.position, "value": gameState.value})
        .toList()
        .toString();
  }

  void winGame() {
    updateState(0, GameState(position: "1,1", value: "W"));
    updateState(4, GameState(position: "2,2", value: "I"));
    updateState(8, GameState(position: "3,3", value: "N"));
  }
}
