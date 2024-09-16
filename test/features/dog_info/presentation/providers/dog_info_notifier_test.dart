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
import 'package:test_project/features/dog_info/presentation/providers/dog_info_notifier.dart';

import '../../../../test_utilities/state_collector.dart';
import 'dog_info_notifier_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GetSpecificDogInfo>(), MockSpec<GetRandomDogInfo>()])
void main() {
  group('DogInfoNotifier', () {
    late ProviderContainer container;
    late MockGetSpecificDogInfo getSpecificDogInfoUseCaseMock;
    late MockGetRandomDogInfo getRandomDogInfoUseCaseMock;
    late StateCollector<AsyncValue<DogInfo>> stateCollector;

    setUp(() {
      getSpecificDogInfoUseCaseMock = MockGetSpecificDogInfo();
      getRandomDogInfoUseCaseMock = MockGetRandomDogInfo();
      container = ProviderContainer(overrides: [
        getSpecificDogInfoUseCaseProvider
            .overrideWithValue(getSpecificDogInfoUseCaseMock),
        getRandomDogInfoUseCaseProvider
            .overrideWithValue(getRandomDogInfoUseCaseMock),
      ]);

      stateCollector = StateCollector<AsyncValue<DogInfo>>();

      // When the test ends, dispose the container.
      addTearDown(container.dispose);
    });

    const String tBreedRandom = 'golden_retriever';
    const String tBreedSpecific = 'afghan_hound';

    const tDogInfoRandom = DogInfo(
      breed: tBreedRandom,
      description: 'The Golden Retriever is a large-sized breed '
          'of dog bred as gun dogs to retrieve shot waterfowl'
          ' such as ducks and upland game birds during hunting and '
          'shooting parties, and were named retriever because of their '
          'ability to retrieve shot game undamaged.',
      imageUrl:
          'https://images.dog.ceo/breeds/retriever-golden/n02099601_100.jpg',
    );

    const tDogInfoSpecific = DogInfo(
      breed: tBreedSpecific,
      description: 'The Afghan Hound is a hound that is distinguished by its'
          ' thick, fine, silky coat and its tail with a ring curl at the end. '
          'The breed is selectively bred for its unique features in the cold'
          ' mountains of Afghanistan.',
      imageUrl: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
    );

    void startListenForStateChanges(
      ProviderContainer container,
      StateCollector<AsyncValue<DogInfo>> stateCollector,
    ) {
      container.listen(
        dogInfoNotifierProvider,
        (_, state) => stateCollector.collect(state),
        fireImmediately: true,
      );
    }

    group('build', () {
      test('should return a DogInfo when getRandomDogInfoUseCase is successful',
          () async {
        // arrange
        when(getRandomDogInfoUseCaseMock(NoParams()))
            .thenAnswer((_) async => tDogInfoRandom);

        startListenForStateChanges(container, stateCollector);
        // act
        await container.read(dogInfoNotifierProvider.future);
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          equals(const AsyncData(tDogInfoRandom)),
        ]);
        verify(getRandomDogInfoUseCaseMock(NoParams())).called(1);
      });

      test(
          'should return AsyncError when getRandomDogInfoUseCase is unsuccessful',
          () async {
        // arrange
        when(getRandomDogInfoUseCaseMock(NoParams())).thenThrow(Exception());
        startListenForStateChanges(container, stateCollector);
        // act
        try {
          await container.read(dogInfoNotifierProvider.future);
        } catch (_) {}
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          isA<AsyncError<DogInfo>>(),
        ]);
      });
    });

    group('getSpecificDogInfo', () {
      const tParams = Params(breed: tBreedSpecific);

      test(
          'should return a DogInfo when getSpecificDogInfoUseCase is successful',
          () async {
        // arrange
        when(getSpecificDogInfoUseCaseMock(tParams))
            .thenAnswer((_) async => tDogInfoSpecific);

        startListenForStateChanges(container, stateCollector);
        // act
        await container.read(dogInfoNotifierProvider.future);
        await container
            .read(dogInfoNotifierProvider.notifier)
            .getSpecificDogInfo(tBreedSpecific);
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          equals(const AsyncData(tDogInfoSpecific)),
        ]);
        verify(getSpecificDogInfoUseCaseMock(tParams)).called(1);
      });

      test(
          'should return AsyncError when getSpecificDogInfoUseCase is unsuccessful',
          () async {
        // arrange
        when(getSpecificDogInfoUseCaseMock(tParams)).thenThrow(Exception());

        startListenForStateChanges(container, stateCollector);
        // act
        await container.read(dogInfoNotifierProvider.future);
        try {
          await container
              .read(dogInfoNotifierProvider.notifier)
              .getSpecificDogInfo(tBreedSpecific);
        } catch (_) {}
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          isA<AsyncError<DogInfo>>(),
        ]);
        verify(getSpecificDogInfoUseCaseMock(tParams)).called(1);
      });
    });

    group('getRandomDogInfo', () {
      test('should return a DogInfo when getRandomDogInfoUseCase is successful',
          () async {
        // arrange
        when(getRandomDogInfoUseCaseMock(NoParams()))
            .thenAnswer((_) async => tDogInfoRandom);

        startListenForStateChanges(container, stateCollector);
        // act
        await container.read(dogInfoNotifierProvider.future);
        await container
            .read(dogInfoNotifierProvider.notifier)
            .getRandomDogInfo();
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          equals(const AsyncData(tDogInfoRandom)),
        ]);
        verify(getRandomDogInfoUseCaseMock(NoParams())).called(2);
      });

      test(
          'should return AsyncError when getRandomDogInfoUseCase is unsuccessful',
          () async {
        // arrange
        when(getRandomDogInfoUseCaseMock(NoParams())).thenThrow(Exception());

        startListenForStateChanges(container, stateCollector);
        // act
        try {
          await container.read(dogInfoNotifierProvider.future);
        } catch (_) {}
        try {
          await container
              .read(dogInfoNotifierProvider.notifier)
              .getRandomDogInfo();
        } catch (_) {}
        // assert
        stateCollector.assertStates([
          isA<AsyncLoading<DogInfo>>(),
          isA<AsyncError<DogInfo>>(),
        ]);
        verify(getRandomDogInfoUseCaseMock(NoParams())).called(2);
      });
    });
  });
}
