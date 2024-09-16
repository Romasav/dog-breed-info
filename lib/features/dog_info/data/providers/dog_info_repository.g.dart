// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_info_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dogInfoRepositoryHash() => r'd16bfc798751801f3bee300b279a2187c4f932d2';

/// See also [dogInfoRepository].
@ProviderFor(dogInfoRepository)
final dogInfoRepositoryProvider =
    AutoDisposeProvider<DogInfoRepository>.internal(
  dogInfoRepository,
  name: r'dogInfoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dogInfoRepositoryHash,
  dependencies: <ProviderOrFamily>[dogInfoApiDataSourceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    dogInfoApiDataSourceProvider,
    ...?dogInfoApiDataSourceProvider.allTransitiveDependencies
  },
);

typedef DogInfoRepositoryRef = AutoDisposeProviderRef<DogInfoRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
