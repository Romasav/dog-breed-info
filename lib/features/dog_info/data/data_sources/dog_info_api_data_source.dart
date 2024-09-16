import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';

abstract class DogInfoApiDataSource {
  Future<ApiDogInfoModel> getSpecificDogInfo(String breed);
  Future<ApiDogInfoModel> getRandomDogInfo();
}
