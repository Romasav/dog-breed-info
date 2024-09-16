import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/dog_info.dart';
import '../repositories/dog_info_repository.dart';

class GetSpecificDogInfo extends UseCase<DogInfo, Params> {
  final DogInfoRepository repository;

  GetSpecificDogInfo(this.repository);

  @override
  Future<DogInfo> call(Params params) async {
    return repository.getSpecificDogInfo(params.breed);
  }
}

class Params extends Equatable {
  final String breed;

  const Params({required this.breed});

  @override
  List<Object?> get props => [breed];
}
