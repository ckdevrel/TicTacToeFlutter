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

    var firstObject = GameState(position: 11, value: "x");
    var secondObject = GameState(position: 33, value: "o");

    gameRules.updateState(firstPosition, firstObject);
    gameRules.updateState(lastPosition, secondObject);

    expect(firstObject, gameRules.getGameState(firstPosition));
    expect(secondObject, gameRules.getGameState(lastPosition));
    expect('x', firstObject.getValue);
    expect('o', secondObject.getValue);
    expect(11, firstObject.getPosition);
    expect(33, secondObject.getPosition);
  });

  test("should check for a new move based on a clicked position", () {
    GameRules gameRules = GameRules();

    var firstPosition = 0;

    expect(true, gameRules.isNewMove(firstPosition));

    var firstObject = GameState(position: 11, value: "x");
    gameRules.updateState(firstPosition, firstObject);

    expect(false, gameRules.isNewMove(firstPosition));
  });

  test("should get json for the very first move based on the position selected",
      () {
    GameRules gameRules = GameRules();

    String expectedJson = getInitialJsonData();
    String initialJsonData = gameRules.getJSON();

    expect(expectedJson, initialJsonData);
  });
}

String getInitialJsonData() {
  return [
    {"position": 11, "value": null},
    {"position": 12, "value": null},
    {"position": 13, "value": null},
    {"position": 21, "value": null},
    {"position": 22, "value": null},
    {"position": 23, "value": null},
    {"position": 31, "value": null},
    {"position": 32, "value": null},
    {"position": 33, "value": null}
  ].toString();
}
