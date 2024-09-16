// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_specific_dog_info_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSpecificDogInfoUseCaseHash() =>
    r'13691401d9f40419e705f1d72daebd42d3478ab2';

/// See also [getSpecificDogInfoUseCase].
@ProviderFor(getSpecificDogInfoUseCase)
final getSpecificDogInfoUseCaseProvider =
    AutoDisposeProvider<UseCase<DogInfo, Params>>.internal(
  getSpecificDogInfoUseCase,
  name: r'getSpecificDogInfoUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSpecificDogInfoUseCaseHash,
  dependencies: <ProviderOrFamily>[dogInfoRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    dogInfoRepositoryProvider,
    ...?dogInfoRepositoryProvider.allTransitiveDependencies
  },
);

typedef GetSpecificDogInfoUseCaseRef
    = AutoDisposeProviderRef<UseCase<DogInfo, Params>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
