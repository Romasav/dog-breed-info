import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_project/core/usecases/usecase.dart';

import '../../data/providers/dog_info_repository.dart';
import '../entities/dog_info.dart';
import '../usecases/get_random_dog_info.dart';

part 'get_random_dog_info_usecase.g.dart';

@Riverpod(dependencies: [dogInfoRepository])
UseCase<DogInfo, NoParams> getRandomDogInfoUseCase(
  GetRandomDogInfoUseCaseRef ref,
) {
  final dogInfoRepository = ref.watch(dogInfoRepositoryProvider);
  return GetRandomDogInfo(dogInfoRepository);
}
