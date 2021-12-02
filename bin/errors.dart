class EmptyDataException implements Exception {
  String message = "No data provided !";
}

class InvalidMoveException implements Exception {
  final String _move;
  String get message => "Inllegal move : $_move";

  InvalidMoveException(this._move);
}
