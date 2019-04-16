class GameState {
  String position;
  String value;

  GameState({this.position, this.value});

  String get getPosition => this.position;

  String get getValue => this.value;

  factory GameState.fromJson(Map<String, dynamic> json) => new GameState(
        position: json["position"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "value": value == null ? null : value,
     };
}
