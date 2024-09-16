// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_random_dog_info_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRandomDogInfoUseCaseHash() =>
    r'0c036bd9a176d40b19981b1acd94eca8148a8cc7';

/// See also [getRandomDogInfoUseCase].
@ProviderFor(getRandomDogInfoUseCase)
final getRandomDogInfoUseCaseProvider =
    AutoDisposeProvider<UseCase<DogInfo, NoParams>>.internal(
  getRandomDogInfoUseCase,
  name: r'getRandomDogInfoUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRandomDogInfoUseCaseHash,
  dependencies: <ProviderOrFamily>[dogInfoRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    dogInfoRepositoryProvider,
    ...?dogInfoRepositoryProvider.allTransitiveDependencies
  },
);

typedef GetRandomDogInfoUseCaseRef
    = AutoDisposeProviderRef<UseCase<DogInfo, NoParams>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
