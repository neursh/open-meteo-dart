class InvalidDataException implements Exception {
  String cause;
  InvalidDataException(this.cause);
}

class OpenMeteoApiError implements Exception {
  String reason;
  OpenMeteoApiError(this.reason);

  @override
  String toString() => '$runtimeType: $reason';
}
