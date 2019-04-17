import 'package:tictactoe/GameState.dart';
import 'dart:convert' show json;

import 'GameConstants.dart';

class GameRules {
  List<GameState> gameStates;

  String gameStatus;

  GameRules({
    this.gameStates,
    this.gameStatus,
  });

  void initGameRules(){
    gameStatus = GameConstants.STATUS_INPROGRESS; //lost, won, draw

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
    return json.encode(toJson());
  }

    GameRules getGameStatesFromResponse(String data) {
      final jsonData = json.decode(data);
      return GameRules.fromJson(jsonData);
    }

  //to access the response
  factory GameRules.fromJson(Map<String, dynamic> json) => new GameRules(
    gameStates: new List<GameState>.from(json["cells"].map((x) => GameState.fromJson(x))),
    gameStatus: json["gameStatus"],
  );

  Map<String, dynamic> toJson() => {
    "cells": new List<dynamic>.from(gameStates.map((gameState) => gameState.toJson())),
    "gameStatus": gameStatus,
  };

    void updateStates(List<GameState> gameStateList) {
      gameStates.clear();
      gameStates.addAll(gameStateList);
    }
  }
