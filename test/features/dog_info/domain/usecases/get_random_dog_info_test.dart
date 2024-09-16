import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_project/core/usecases/usecase.dart';
import 'package:test_project/features/dog_info/domain/entities/dog_info.dart';
import 'package:test_project/features/dog_info/domain/repositories/dog_info_repository.dart';
import 'package:test_project/features/dog_info/domain/usecases/get_random_dog_info.dart';

@GenerateNiceMocks([MockSpec<DogInfoRepository>()])
import 'get_random_dog_info_test.mocks.dart';

void main() {
  DogInfoRepository mockDogInfoRepository = MockDogInfoRepository();
  GetRandomDogInfo getRandomDogInfo = GetRandomDogInfo(mockDogInfoRepository);

  const tDogInfo = DogInfo(
    breed: 'golden_retriever',
    description: 'The Golden Retriever is a large-sized breed '
        'of dog bred as gun dogs to retrieve shot waterfowl'
        ' such as ducks and upland game birds during hunting and '
        'shooting parties, and were named retriever because of their '
        'ability to retrieve shot game undamaged.',
    imageUrl: 'https://images.dog.ceo/breeds/retriever-golden/n02099601_100.jpg',
  );

  test('should return DogInfo for a random breed', () async {
    // arrange
    when(mockDogInfoRepository.getRandomDogInfo()).thenAnswer((_) async => tDogInfo);
    // act
    DogInfo result = await getRandomDogInfo(NoParams());
    // assert
    expect(result, tDogInfo);
    verify(mockDogInfoRepository.getRandomDogInfo());
    verifyNoMoreInteractions(mockDogInfoRepository);
  });

}