import 'dart:io';

/// Loads a JSON fixture from the given file name under the test/fixtures directory.
String loadJsonFixture(String fileName) {
  // The path to the fixture file
  var path = 'test/fixtures/$fileName';

  // Reading the file synchronously (since it's only used in tests, blocking IO isn't a big deal)
  var fileContents = File(path).readAsStringSync();

  return fileContents;
}
