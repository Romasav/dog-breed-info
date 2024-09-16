class JsonTypeMismatchException implements Exception {
  final String fieldName;
  final String expectedType;
  final dynamic actualValue;

  JsonTypeMismatchException(
      this.fieldName, this.expectedType, this.actualValue);

  String get message => 'Type mismatch for field "$fieldName". '
      'Expected: $expectedType, Found: ${actualValue.runtimeType}';
}
