import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/GameRules.dart';
import 'package:tictactoe/GameState.dart';

void main() {
  test(
      "should build defualt game state array with position and value as null and return the count as 9",
      () {
    GameRules gameRules = GameRules();
    expect(9, gameRules.getCount());
  });

  test(
      "should update first and last position with different state object and verify that the states has been changed",
      () {
    GameRules gameRules = GameRules();
    var firstPosition = 0;
    var lastPosition = 8;

    var firstObject = GameState(position: "1,1", value: "x");
    var secondObject = GameState(position: "3,3", value: "o");

    gameRules.updateState(firstPosition, firstObject);
    gameRules.updateState(lastPosition, secondObject);

    expect(firstObject, gameRules.getGameState(firstPosition));
    expect(secondObject, gameRules.getGameState(lastPosition));
    expect('x', firstObject.getValue);
    expect('o', secondObject.getValue);
    expect("1,1", firstObject.getPosition);
    expect("3,3", secondObject.getPosition);
  });

  test("should check for a new move based on a clicked position", () {
    GameRules gameRules = GameRules();

    var firstPosition = 0;

    expect(true, gameRules.isNewMove(firstPosition));

    var firstObject = GameState(position: "1,1", value: "x");
    gameRules.updateState(firstPosition, firstObject);

    expect(false, gameRules.isNewMove(firstPosition));
  });

  test("should get json for the very first move based on the position selected",
      () {
    GameRules gameRules = GameRules();

    String expectedJson = positionMap.toString();
    String initialJsonData = gameRules.getJSON();

    expect(expectedJson, initialJsonData);
  });

  test("should get json when first (computer) and last (player) positions are selected",
          () {
        GameRules gameRules = GameRules();

        String expectedJson = selectedPositionMap.toString();
        var firstPosition = 0;
        var lastPosition = 8;

        var firstObject = GameState(position: "1,1", value: "o");
        var secondObject = GameState(position: "3,3", value: "x");

        gameRules.updateState(firstPosition, firstObject);
        gameRules.updateState(lastPosition, secondObject);

        String jsonData = gameRules.getJSON();

        expect(expectedJson, jsonData);
      });
}

var positionMap  = [
    {"position": "1,1", "value": null},
    {"position": "1,2", "value": null},
    {"position": "1,3", "value": null},
    {"position": "2,1", "value": null},
    {"position": "2,2", "value": null},
    {"position": "2,3", "value": null},
    {"position": "3,1", "value": null},
    {"position": "3,2", "value": null},
    {"position": "3,3", "value": null}
];

var selectedPositionMap  = [
  {"position": "1,1", "value": "o"},
  {"position": "1,2", "value": null},
  {"position": "1,3", "value": null},
  {"position": "2,1", "value": null},
  {"position": "2,2", "value": null},
  {"position": "2,3", "value": null},
  {"position": "3,1", "value": null},
  {"position": "3,2", "value": null},
  {"position": "3,3", "value": "x"}
];
