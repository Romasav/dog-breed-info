import '../../../../core/usecases/usecase.dart';
import '../entities/dog_info.dart';
import '../repositories/dog_info_repository.dart';

class GetRandomDogInfo extends UseCase<DogInfo, NoParams> {
  final DogInfoRepository repository;

  GetRandomDogInfo(this.repository);

  @override
  Future<DogInfo> call(NoParams params) async {
    return await repository.getRandomDogInfo();
  }
}