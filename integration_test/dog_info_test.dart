import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_project/features/dog_info/presentation/pages/dog_info.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest() {
    return ProviderScope(
      child: MaterialApp(
        home: DogInfoPage(),
      ),
    );
  }

  testWidgets("Complete user flow for fetching and displaying dog info",
      (tester) async {
    // Launch the app
    await tester.pumpWidget(createWidgetUnderTest());

    // Check for the initial UI
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle(); // Wait for the initial loading to complete
    expect(find.byKey(const Key('dog_info_displayed')), findsOneWidget);

    // Tap the 'Get Random Dog' button
    final randomDogButton = find.byKey(const Key('get_random_dog_info_button'));
    await tester.tap(randomDogButton);
    await tester.pumpAndSettle(); // Wait for network and animations to complete

    // Check for displayed dog information
    expect(find.byKey(const Key('dog_info_displayed')), findsOneWidget);

    // Enter a breed in the search box and tap 'Get Dog'
    await tester.enterText(find.byType(TextField), 'Golden Retriever');
    final getDogButton = find.byKey(const Key('get_dog_info_button'));
    await tester.tap(getDogButton);
    await tester.pumpAndSettle();

    // Verify the specific dog info is displayed
    expect(find.byKey(const Key('dog_info_displayed')), findsOneWidget);
    expect(find.text('Golden Retriever'), findsOneWidget);
  });
}
