import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/dog_info_repository.dart';
import '../repositories/dog_info_repository_impl.dart';
import 'dog_info_api_data_source.dart';

part 'dog_info_repository.g.dart';

@Riverpod(dependencies: [dogInfoApiDataSource])
DogInfoRepository dogInfoRepository(DogInfoRepositoryRef ref) {
  final remoteDataSource = ref.watch(dogInfoApiDataSourceProvider);
  return DogInfoRepositoryImpl(remoteDataSource: remoteDataSource);
}
