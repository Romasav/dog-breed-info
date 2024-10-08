// Mocks generated by Mockito 5.4.4 from annotations
// in test_project/test/features/dog_info/presentation/providers/dog_info_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:test_project/core/usecases/usecase.dart' as _i7;
import 'package:test_project/features/dog_info/domain/entities/dog_info.dart'
    as _i3;
import 'package:test_project/features/dog_info/domain/repositories/dog_info_repository.dart'
    as _i2;
import 'package:test_project/features/dog_info/domain/usecases/get_random_dog_info.dart'
    as _i6;
import 'package:test_project/features/dog_info/domain/usecases/get_specific_dog_info.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDogInfoRepository_0 extends _i1.SmartFake
    implements _i2.DogInfoRepository {
  _FakeDogInfoRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDogInfo_1 extends _i1.SmartFake implements _i3.DogInfo {
  _FakeDogInfo_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetSpecificDogInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSpecificDogInfo extends _i1.Mock
    implements _i4.GetSpecificDogInfo {
  @override
  _i2.DogInfoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDogInfoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeDogInfoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DogInfoRepository);

  @override
  _i5.Future<_i3.DogInfo> call(_i4.Params? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.DogInfo>.value(_FakeDogInfo_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub: _i5.Future<_i3.DogInfo>.value(_FakeDogInfo_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.DogInfo>);
}

/// A class which mocks [GetRandomDogInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRandomDogInfo extends _i1.Mock implements _i6.GetRandomDogInfo {
  @override
  _i2.DogInfoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeDogInfoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeDogInfoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.DogInfoRepository);

  @override
  _i5.Future<_i3.DogInfo> call(_i7.NoParams? params) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.DogInfo>.value(_FakeDogInfo_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub: _i5.Future<_i3.DogInfo>.value(_FakeDogInfo_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.DogInfo>);
}
