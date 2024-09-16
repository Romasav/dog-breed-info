// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_info_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dogInfoNotifierHash() => r'86ee646b0cd6be57ca8f477c27708ea12eeb6247';

/// See also [DogInfoNotifier].
@ProviderFor(DogInfoNotifier)
final dogInfoNotifierProvider =
    AutoDisposeAsyncNotifierProvider<DogInfoNotifier, DogInfo>.internal(
  DogInfoNotifier.new,
  name: r'dogInfoNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dogInfoNotifierHash,
  dependencies: <ProviderOrFamily>[
    getRandomDogInfoUseCaseProvider,
    getSpecificDogInfoUseCaseProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getRandomDogInfoUseCaseProvider,
    ...?getRandomDogInfoUseCaseProvider.allTransitiveDependencies,
    getSpecificDogInfoUseCaseProvider,
    ...?getSpecificDogInfoUseCaseProvider.allTransitiveDependencies
  },
);

typedef _$DogInfoNotifier = AutoDisposeAsyncNotifier<DogInfo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
