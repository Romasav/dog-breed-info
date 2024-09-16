class NoMatchFoundException implements Exception {
  final String message;

  NoMatchFoundException(this.message);

  @override
  String toString() => "NoMatchFoundException: $message";
}
