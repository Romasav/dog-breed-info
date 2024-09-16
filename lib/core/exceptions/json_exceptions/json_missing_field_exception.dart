class JsonMissingFieldException implements Exception {
  final String fieldName;

  JsonMissingFieldException(this.fieldName);

  String get message => 'Missing mandatory field: $fieldName';
}
