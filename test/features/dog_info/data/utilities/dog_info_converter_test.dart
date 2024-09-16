import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';
import 'package:test_project/features/dog_info/data/utilities/dog_info_converter.dart';
import 'package:test_project/features/dog_info/domain/entities/dog_info.dart';

void main() {
  group('DogInfoConverter', () {
    test('should correctly convert ApiDogInfoModel to DogInfo', () {
      // arrange
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

      // act
      final result = DogInfoConverter.fromApiModel(tApiDogInfoModel);

      // assert
      expect(result, tDogInfo);
    });
  });
}
