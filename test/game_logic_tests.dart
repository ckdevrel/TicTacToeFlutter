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

  test("should get board json before the player makes a first move",
      () {
    GameRules gameRules = GameRules();

    String initialJsonData = gameRules.getBoardJSON();

    expect(getEmptyStateBoardJson(), initialJsonData);
  });

  test(
      "should get json when first (player) and last (computer) positions are selected",
      () {
    GameRules gameRules = GameRules();

    var firstPosition = 0;
    var lastPosition = 8;

    var firstObject = GameState(position: "0,0", value: "X");
    var secondObject = GameState(position: "2,2", value: "O");

    gameRules.updateState(firstPosition, firstObject);
    gameRules.updateState(lastPosition, secondObject);

    String jsonData = gameRules.getBoardJSON();

    expect(getActualJsonRequest(), jsonData);
  });
}

String getActualJsonRequest() {
  return [
    {"position": "0,0", "value": "X"},
    {"position": "0,1", "value": null},
    {"position": "0,2", "value": null},
    {"position": "1,0", "value": null},
    {"position": "1,1", "value": null},
    {"position": "1,2", "value": null},
    {"position": "2,0", "value": null},
    {"position": "2,1", "value": null},
    {"position": "2,2", "value": "O"}
  ].toString();
}

String getEmptyStateBoardJson() {
  return [{"position":"0,0","value":"X"},{"position":"0,1","value":"X"},{"position":"0,2","value":null},{"position":"1,0","value":null},{"position":"1,1","value":null},{"position":"1,2","value":null},{"position":"2,0","value":"O"},{"position":"2,1","value":null},{"position":"2,2","value":null}].toString();
}
