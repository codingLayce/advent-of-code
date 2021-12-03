class EmptyDataException implements Exception {
  String message = "No data provided !";
}

class InvalidMoveException implements Exception {
  final String _move;
  String get message => "Inllegal move : $_move";

  InvalidMoveException(this._move);
}

class ElementSizeDifferentException implements Exception {
  String message = "An element in the list has a wrong size !";
}

class NotBinaryException implements Exception {
  final String _element;
  String get tmessage => "The element ($_element) ins't a binary";

  NotBinaryException(this._element);
}
