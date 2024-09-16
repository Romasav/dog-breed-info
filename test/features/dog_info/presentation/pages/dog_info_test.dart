import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_project/core/usecases/usecase.dart';
import 'package:test_project/features/dog_info/domain/entities/dog_info.dart';
import 'package:test_project/features/dog_info/domain/providers/get_random_dog_info_usecase.dart';
import 'package:test_project/features/dog_info/domain/providers/get_specific_dog_info_usecase.dart';
import 'package:test_project/features/dog_info/domain/usecases/get_random_dog_info.dart';
import 'package:test_project/features/dog_info/domain/usecases/get_specific_dog_info.dart';
import 'package:test_project/features/dog_info/presentation/pages/dog_info.dart';

import 'dog_info_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GetRandomDogInfo>(), MockSpec<GetSpecificDogInfo>()])
void main() {
  late GetRandomDogInfo getRandomDogInfoUseCase;
  late GetSpecificDogInfo getSpecificDogInfoUseCase;

  setUp(() {
    getRandomDogInfoUseCase = MockGetRandomDogInfo();
    getSpecificDogInfoUseCase = MockGetSpecificDogInfo();
    HttpOverrides.global = null;
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        getRandomDogInfoUseCaseProvider
            .overrideWithValue(getRandomDogInfoUseCase),
        getSpecificDogInfoUseCaseProvider
            .overrideWithValue(getSpecificDogInfoUseCase),
      ],
      child: MaterialApp(
        home: DogInfoPage(),
      ),
    );
  }

  const DogInfo tRandomDogInfo = DogInfo(
    breed: 'Labrador',
    imageUrl: 'http://example.com/dog.jpg',
    description: 'Friendly Dog',
  );

  const DogInfo tSpecificDogInfo = DogInfo(
    breed: 'Golden Retriever',
    imageUrl: 'http://example.com/golden_retriever.jpg',
    description: 'Very active and friendly dog',
  );

  group('initial state', () {
    testWidgets('should display loading indicator once entering the page',
        (WidgetTester widgetTester) async {
      when(getRandomDogInfoUseCase.call(NoParams()))
          .thenAnswer((_) async => tRandomDogInfo);

      await widgetTester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
      'should display initial Data once loaded',
      (widgetTester) async {
        when(getRandomDogInfoUseCase.call(NoParams()))
            .thenAnswer((_) async => tRandomDogInfo);

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        expect(find.text('Labrador'), findsOneWidget);
        expect(find.text('Friendly Dog'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets('should display error when it fails to get initial state',
        (widgetTester) async {
      when(getRandomDogInfoUseCase.call(NoParams())).thenThrow(Exception());

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      expect(find.text('Something went wrong'), findsOneWidget);
    });
  });

  group('get_dog_info_button', () {
    testWidgets(
      'should display circular progress indicator when get_dog_info_button is pressed',
      (widgetTester) async {
        // arrange
        when(getRandomDogInfoUseCase.call(NoParams()))
            .thenAnswer((_) async => tRandomDogInfo);
        when(getSpecificDogInfoUseCase
                .call(const Params(breed: 'Golden Retriever')))
            .thenAnswer((_) async => Future.delayed(
                const Duration(milliseconds: 10), () => tSpecificDogInfo));

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        // act
        final breedTextField = find.byType(TextField);
        final getDogInfoButton = find.byKey(const Key('get_dog_info_button'));

        await widgetTester.enterText(breedTextField, 'Golden Retriever');
        await widgetTester.tap(getDogInfoButton);
        await widgetTester.pump();

        // assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // wait for the future to complete
        await widgetTester.pumpAndSettle();
      },
    );

    testWidgets(
        'should display specific dog info when getSpecificDogInfo is called',
        (widgetTester) async {
      // arrange
      when(getRandomDogInfoUseCase.call(NoParams()))
          .thenAnswer((_) async => tRandomDogInfo);
      when(getSpecificDogInfoUseCase
              .call(const Params(breed: 'Golden Retriever')))
          .thenAnswer((_) async => tSpecificDogInfo);

      await widgetTester.pumpWidget(createWidgetUnderTest());
      await widgetTester.pumpAndSettle();

      // act
      final breedTextField = find.byType(TextField);
      final getDogInfoButton = find.byKey(const Key('get_dog_info_button'));

      await widgetTester.enterText(breedTextField, 'Golden Retriever');
      await widgetTester.tap(getDogInfoButton);
      await widgetTester.pumpAndSettle();

      // assert
      expect(find.text('Golden Retriever'), findsOneWidget);
      expect(find.text('Very active and friendly dog'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets(
      'should display error when it fails to get specific dog info',
      (widgetTester) async {
        // arrange
        when(getRandomDogInfoUseCase.call(NoParams()))
            .thenAnswer((_) async => tRandomDogInfo);
        when(getSpecificDogInfoUseCase
                .call(const Params(breed: 'Golden Retriever')))
            .thenThrow(Exception());

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        // act
        final breedTextField = find.byType(TextField);
        final getDogInfoButton = find.byKey(const Key('get_dog_info_button'));

        await widgetTester.enterText(breedTextField, 'Golden Retriever');
        await widgetTester.tap(getDogInfoButton);
        await widgetTester.pumpAndSettle();

        // assert
        expect(find.text('Something went wrong'), findsOneWidget);
      },
    );
  });

  group('get_random_dog_info_button', () {
    testWidgets(
      'should display circular progress indicator when get_random_dog_info_button is pressed',
      (widgetTester) async {
        // arrange
        when(getRandomDogInfoUseCase.call(NoParams())).thenAnswer((_) async =>
            Future.delayed(
                const Duration(milliseconds: 10), () => tRandomDogInfo));

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        // act
        final getRandomDogInfoButton =
            find.byKey(const Key('get_random_dog_info_button'));

        await widgetTester.tap(getRandomDogInfoButton);
        await widgetTester.pump();

        // assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // wait for the future to complete
        await widgetTester.pumpAndSettle();
      },
    );

    testWidgets(
      'should display random dog info when getRandomDogInfo is called',
      (widgetTester) async {
        // arrange
        when(getRandomDogInfoUseCase.call(NoParams()))
            .thenAnswer((_) async => tRandomDogInfo);

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        // act
        final getRandomDogInfoButton =
            find.byKey(const Key('get_random_dog_info_button'));

        await widgetTester.tap(getRandomDogInfoButton);
        await widgetTester.pumpAndSettle();

        // assert
        expect(find.text('Labrador'), findsOneWidget);
        expect(find.text('Friendly Dog'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      },
    );

    testWidgets(
      'should display error when it fails to get random dog info',
      (widgetTester) async {
        // arrange
        when(getRandomDogInfoUseCase.call(NoParams())).thenThrow(Exception());

        await widgetTester.pumpWidget(createWidgetUnderTest());
        await widgetTester.pumpAndSettle();

        // act
        final getRandomDogInfoButton =
            find.byKey(const Key('get_random_dog_info_button'));

        await widgetTester.tap(getRandomDogInfoButton);
        await widgetTester.pumpAndSettle();

        // assert
        expect(find.text('Something went wrong'), findsOneWidget);
      },
    );
  });
}
