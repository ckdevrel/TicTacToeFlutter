import 'package:tictactoe/GameState.dart';

class GameRules {
  List<GameState> gameStates;

  GameRules() {
    gameStates = [
      GameState(position: 11),
      GameState(position: 12),
      GameState(position: 13),
      GameState(position: 21),
      GameState(position: 22),
      GameState(position: 23),
      GameState(position: 31),
      GameState(position: 32),
      GameState(position: 33)
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
    updateState(0, GameState(position: 11, value: "W"));
    updateState(4, GameState(position: 22, value: "I"));
    updateState(8, GameState(position: 33, value: "N"));
  }
}
