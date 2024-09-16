import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_project/core/exceptions/query_exeptions/no_match_found_exception.dart';
import 'package:test_project/core/exceptions/server_exeptions/server_exeption.dart';
import 'package:test_project/features/dog_info/data/data_sources/dog_info_api_data_source_impl.dart';
import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';

import '../../../../fixtures/fixture_loader.dart';
import 'dog_info_api_data_sources_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('DogInfoApiDataSourcesImpl', () {
    late MockClient mockHttpClient;
    late DogInfoApiDataSourceImpl dataSource;

    setUp(() {
      mockHttpClient = MockClient();
      dataSource = DogInfoApiDataSourceImpl(client: mockHttpClient);
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

    final tBreed = tApiDogInfoModel.name;

    group('getSpecificDogInfo', () {
      test('should return a DogInfoModel when the response code is 200',
          () async {
        // arrange
        final tDogInfoModelJsonString =
            loadJsonFixture('api_dog_info_success.json');
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(tDogInfoModelJsonString, 200));
        // act
        final result = await dataSource.getSpecificDogInfo(tBreed);
        // assert
        expect(result, tApiDogInfoModel);
        verify(mockHttpClient.get(any)).called(1);
      });

      test(
          'should throw a NoMatchFoundException when the response body is empty',
          () async {
        // arrange
        final tDogInfoModelJsonString =
            loadJsonFixture('api_dog_info_empty.json');
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(tDogInfoModelJsonString, 200));
        // act
        final call = dataSource.getSpecificDogInfo;
        // assert
        expect(() => call(tBreed), throwsA(isA<NoMatchFoundException>()));
        verify(mockHttpClient.get(any)).called(1);
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(any))
            .thenAnswer((_) async => http.Response('', 404));
        // act
        final call = dataSource.getSpecificDogInfo;
        // assert
        expect(() => call(tBreed), throwsA(isA<ServerException>()));
        verify(mockHttpClient.get(any)).called(1);
      });
    });

    group('getRandomDogInfo', () {
      test('should return a DogInfoModel when the response code is 200',
          () async {
        // arrange
        final tDogInfoModelJsonString =
            loadJsonFixture('api_dog_info_success.json');
        when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(tDogInfoModelJsonString, 200));
        // act
        final result = await dataSource.getRandomDogInfo();
        // assert
        expect(result, tApiDogInfoModel);
        verify(mockHttpClient.get(any)).called(1);
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(any))
            .thenAnswer((_) async => http.Response('', 404));
        // act
        final call = dataSource.getRandomDogInfo;
        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
        verify(mockHttpClient.get(any)).called(1);
      });
    });
  });
}
