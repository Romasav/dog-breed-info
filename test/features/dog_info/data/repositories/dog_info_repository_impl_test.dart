import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_project/core/exceptions/server_exeptions/server_exeption.dart';
import 'package:test_project/features/dog_info/data/data_sources/dog_info_api_data_source.dart';
import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';
import 'package:test_project/features/dog_info/data/repositories/dog_info_repository_impl.dart';
import 'package:test_project/features/dog_info/domain/entities/dog_info.dart';

import 'dog_info_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DogInfoApiDataSource>()])
void main() {
  group('DogInfoRepositoryImpl', () {
    late DogInfoApiDataSource remoteDataSource;
    late DogInfoRepositoryImpl repository;

    setUp(() {
      remoteDataSource = MockDogInfoApiDataSource();
      repository = DogInfoRepositoryImpl(remoteDataSource: remoteDataSource);
    });

    const tApiDogInfoModel = ApiDogInfoModel(
      name: "Afghan Hound",
      bredFor: "Coursing and hunting",
      breedGroup: "Hound",
      lifeSpan: "10 - 13 years",
      temperament: "Aloof, Clownish, Dignified, Independent, Happy",
      origin: "Afghanistan, Iran, Pakistan",
      referenceImageId: "hMyT4CDXR",
      heightInCm: "64 - 69",
      heightInInch: "25 - 27",
      weightInKg: "23 - 27",
      weightInLb: "50 - 60",
    );

    final tDogInfo = DogInfo(
      breed: tApiDogInfoModel.name,
      description: tApiDogInfoModel.description,
      imageUrl: tApiDogInfoModel.imageUrl,
    );

    final tBreed = tApiDogInfoModel.name;

    final serverException = ServerException(message: "Server Error");

    group('getSpecificDogInfo', () {
      test('should return a DogInfoModel', () async {
        // arrange
        when(remoteDataSource.getSpecificDogInfo(tBreed))
            .thenAnswer((_) async => tApiDogInfoModel);
        // act
        final result = await repository.getSpecificDogInfo(tBreed);
        // assert
        expect(result, tDogInfo);
        verify(remoteDataSource.getSpecificDogInfo(tBreed));
      });

      test(
          'should throw an exception when the call to the data source is unsuccessful',
          () async {
        // arrange
        when(remoteDataSource.getSpecificDogInfo(tBreed))
            .thenThrow(serverException);
        // act
        final call = repository.getSpecificDogInfo;
        // assert
        expect(() => call(tBreed), throwsA(serverException));
        verify(remoteDataSource.getSpecificDogInfo(tBreed));
      });
    });

    group('getRandomDogInfo', () {
      test('should return a DogInfoModel', () async {
        // arrange
        when(remoteDataSource.getRandomDogInfo())
            .thenAnswer((_) async => tApiDogInfoModel);
        // act
        final result = await repository.getRandomDogInfo();
        // assert
        expect(result, tDogInfo);
        verify(remoteDataSource.getRandomDogInfo());
      });

      test(
          'should throw an exception when the call to the data source is unsuccessful',
          () async {
        // arrange
        when(remoteDataSource.getRandomDogInfo()).thenThrow(serverException);
        // act
        final call = repository.getRandomDogInfo;
        // assert
        expect(() => call(), throwsA(serverException));
        verify(remoteDataSource.getRandomDogInfo());
      });
    });
  });
}
