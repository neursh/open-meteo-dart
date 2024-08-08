class OpenMeteoApiError implements Exception {
  String reason;
  OpenMeteoApiError(this.reason);

  @override
  String toString() => '$runtimeType: $reason';
}
