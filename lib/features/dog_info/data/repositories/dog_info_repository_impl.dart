import 'package:test_project/features/dog_info/domain/entities/dog_info.dart';

import '../../domain/repositories/dog_info_repository.dart';
import '../data_sources/dog_info_api_data_source.dart';
import '../models/api_dog_info_model.dart';
import '../utilities/dog_info_converter.dart';

class DogInfoRepositoryImpl implements DogInfoRepository {
  final DogInfoApiDataSource remoteDataSource;

  DogInfoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DogInfo> getRandomDogInfo() async {
    try {
      ApiDogInfoModel apiDogInfoModel =
          await remoteDataSource.getRandomDogInfo();
      DogInfo dogInfo = DogInfoConverter.fromApiModel(apiDogInfoModel);
      return dogInfo;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DogInfo> getSpecificDogInfo(String breed) async {
    try {
      ApiDogInfoModel apiDogInfoModel =
          await remoteDataSource.getSpecificDogInfo(breed);
      DogInfo dogInfo = DogInfoConverter.fromApiModel(apiDogInfoModel);
      return dogInfo;
    } catch (e) {
      rethrow;
    }
  }
}
