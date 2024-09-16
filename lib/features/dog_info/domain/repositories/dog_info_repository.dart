import '../entities/dog_info.dart';

abstract class DogInfoRepository {

  Future<DogInfo> getSpecificDogInfo(String breed);

  Future<DogInfo> getRandomDogInfo();
}