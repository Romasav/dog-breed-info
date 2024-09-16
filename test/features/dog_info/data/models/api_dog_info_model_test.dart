import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/core/exceptions/json_exceptions/json_missing_field_exception.dart';
import 'package:test_project/core/exceptions/json_exceptions/json_type_mismatch_exception.dart';
import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';

import '../../../../fixtures/fixture_loader.dart';

void main() {
  String expectedLink(String referenceImageId) =>
      'https://cdn2.thedogapi.com/images/$referenceImageId.jpg';

  void testFromJson(String fileName, ApiDogInfoModel tApiDogInfoModel) {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final String jsonString = loadJsonFixture(fileName);
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      // act
      final result = ApiDogInfoModel.fromJson(jsonMap);
      // assert
      expect(result, tApiDogInfoModel);
    });
  }

  void testDescription(String description, ApiDogInfoModel tModel) {
    test('should return a valid description', () {
      // assert
      expect(description, contains(tModel.name));
      if (tModel.bredFor != null) {
        expect(description, contains(tModel.bredFor!));
      }
      expect(description, contains(tModel.breedGroup));
      expect(description, contains(tModel.lifeSpan));
      expect(description, contains(tModel.temperament));
      if (tModel.origin != null) {
        expect(description, contains(tModel.origin!));
      }
      expect(description, contains(tModel.heightInCm));
      expect(description, contains(tModel.heightInInch));
      expect(description, contains(tModel.weightInKg));
      expect(description, contains(tModel.weightInLb));
    });
  }

  void testImageUrl(ApiDogInfoModel model, String tImageUrl) {
    test('should return a valid image URL', () {
      // assert
      expect(model.imageUrl, tImageUrl);
    });
  }

  group('When success', () {
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

    final tImageUrl = expectedLink(tApiDogInfoModel.referenceImageId);

    testFromJson('dog_info_success.json', tApiDogInfoModel);

    testDescription(tApiDogInfoModel.description, tApiDogInfoModel);

    testImageUrl(tApiDogInfoModel, tImageUrl);
  });

  group('When success and missing origin + country code', () {
    const tApiDogInfoModel = ApiDogInfoModel(
      name: "Afghan Hound",
      bredFor: "Coursing and hunting",
      breedGroup: "Hound",
      lifeSpan: "10 - 13 years",
      temperament: "Aloof, Clownish, Dignified, Independent, Happy",
      origin: null,
      referenceImageId: "hMyT4CDXR",
      heightInCm: "64 - 69",
      heightInInch: "25 - 27",
      weightInKg: "23 - 27",
      weightInLb: "50 - 60",
    );

    final tImageUrl = expectedLink(tApiDogInfoModel.referenceImageId);

    testFromJson(
        'dog_info_success_missing_origin_country_code.json', tApiDogInfoModel);

    testDescription(tApiDogInfoModel.description, tApiDogInfoModel);

    testImageUrl(tApiDogInfoModel, tImageUrl);
  });

  group('When success and missing breedFor', () {
    const tApiDogInfoModel = ApiDogInfoModel(
      name: "Afghan Hound",
      bredFor: null,
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

    final tImageUrl = expectedLink(tApiDogInfoModel.referenceImageId);

    testFromJson('dog_info_success_missing_breedFor.json', tApiDogInfoModel);

    testDescription(tApiDogInfoModel.description, tApiDogInfoModel);

    testImageUrl(tApiDogInfoModel, tImageUrl);
  });

  group('When failed', () {
    Matcher throwsJsonMissingFieldException(String expectedField) {
      return throwsA(isA<JsonMissingFieldException>()
          .having((e) => e.fieldName, 'fieldName', equals(expectedField))
          .having((e) => e.message, 'message', contains(expectedField)));
    }

    Matcher throwsJsonTypeMismatchException(
        String expectedField, String expectedType, dynamic actualValue) {
      return throwsA(isA<JsonTypeMismatchException>()
          .having((e) => e.fieldName, 'fieldName', equals(expectedField))
          .having((e) => e.expectedType, 'expectedType', equals(expectedType))
          .having((e) => e.actualValue, 'actualValue', equals(actualValue))
          .having((e) => e.message, 'message', contains(expectedField))
          .having((e) => e.message, 'message', contains(expectedType))
          .having((e) => e.message, 'message',
              contains(actualValue.runtimeType.toString())));
    }

    test('should throw an exception when the JSON is missing a field', () {
      // arrange
      final String jsonString =
          loadJsonFixture('dog_info_error_missing_field.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      // act
      call() => ApiDogInfoModel.fromJson(jsonMap);
      // assert
      expect(call, throwsJsonMissingFieldException('name'));
    });

    test('should throw an exception when the JSON has a type mismatch', () {
      // arrange
      final String jsonString =
          loadJsonFixture('dog_info_error_type_mismatch.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      // act
      call() => ApiDogInfoModel.fromJson(jsonMap);
      // assert
      expect(call, throwsJsonTypeMismatchException('name', 'String', 123));
    });
  });
}
