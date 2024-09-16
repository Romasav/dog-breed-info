import 'package:flutter_test/flutter_test.dart';

class StateCollector<T> {
  List<T> states = [];

  void collect(T state) => states.add(state);

  void assertStates(List<Matcher> expectedStates) {
    expect(states, containsAllInOrder(expectedStates));
  }
}
