import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_project/features/dog_info/domain/providers/get_random_dog_info_usecase.dart';
import 'package:test_project/features/dog_info/domain/usecases/get_specific_dog_info.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/dog_info.dart';
import '../../domain/providers/get_specific_dog_info_usecase.dart';

part 'dog_info_notifier.g.dart';

@Riverpod(dependencies: [getRandomDogInfoUseCase, getSpecificDogInfoUseCase])
class DogInfoNotifier extends _$DogInfoNotifier {
  @override
  Future<DogInfo> build() async {
    final getRandomDogInfo = ref.read(getRandomDogInfoUseCaseProvider);
    final noParams = NoParams();
    final randomDogInfo = await getRandomDogInfo(noParams);
    return randomDogInfo;
  }

  Future<void> getSpecificDogInfo(String breed) async {
    final params = Params(breed: breed);
    state = const AsyncLoading();
    try {
      final getSpecificDogInfo = ref.read(getSpecificDogInfoUseCaseProvider);
      final specificDogInfo = await getSpecificDogInfo(params);
      state = AsyncData(specificDogInfo);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  Future<void> getRandomDogInfo() async {
    state = const AsyncLoading();
    try {
      final getRandomDogInfo = ref.read(getRandomDogInfoUseCaseProvider);
      final randomDogInfo = await getRandomDogInfo(NoParams());
      state = AsyncData(randomDogInfo);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
