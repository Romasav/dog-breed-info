import 'package:equatable/equatable.dart';
import 'package:test_project/core/exceptions/json_exceptions/json_type_mismatch_exception.dart';

import '../../../../core/exceptions/json_exceptions/json_missing_field_exception.dart';

class ApiDogInfoModel extends Equatable {
  final String name;
  final String? bredFor;
  final String breedGroup;
  final String lifeSpan;
  final String temperament;
  final String? origin;
  final String referenceImageId;
  final String heightInCm;
  final String heightInInch;
  final String weightInKg;
  final String weightInLb;

  const ApiDogInfoModel({
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.referenceImageId,
    required this.heightInCm,
    required this.heightInInch,
    required this.weightInKg,
    required this.weightInLb,
  });

  @override
  List<Object?> get props => [
        name,
        bredFor,
        breedGroup,
        lifeSpan,
        temperament,
        origin,
        referenceImageId,
        heightInCm,
        heightInInch,
        weightInKg,
        weightInLb,
      ];

  factory ApiDogInfoModel.fromJson(Map<String, dynamic> json) {
    // Check for missing fields and throw JsonMissingFieldException
    void checkFieldPresence(Map<String, dynamic> json, String field) {
      if (!json.containsKey(field)) {
        throw JsonMissingFieldException(field);
      }
    }

    // Check for field type and throw JsonTypeMismatchException
    void checkFieldType<T>(Map<String, dynamic> json, String field) {
      if (json[field] is! T) {
        throw JsonTypeMismatchException(field, T.toString(), json[field]);
      }
    }

    // Validate field
    void validateField<T>(Map<String, dynamic> json, String field) {
      checkFieldPresence(json, field);
      checkFieldType<T>(json, field);
    }

    validateField<String>(json, 'name');
    if (json.containsKey('bred_for')) {
      validateField<String>(json, 'bred_for');
    }
    validateField<String>(json, 'breed_group');
    validateField<String>(json, 'life_span');
    validateField<String>(json, 'temperament');
    if (json.containsKey('origin')) {
      validateField<String>(json, 'origin');
    }
    validateField<Map<String, dynamic>>(json, 'height');
    validateField<Map<String, dynamic>>(json, 'weight');
    validateField<String>(json['height'], 'metric');
    validateField<String>(json['height'], 'imperial');
    validateField<String>(json['weight'], 'metric');
    validateField<String>(json['weight'], 'imperial');
    validateField<String>(json, 'reference_image_id');

    return ApiDogInfoModel(
      name: json['name'] as String,
      bredFor: json['bred_for'] as String?,
      breedGroup: json['breed_group'] as String,
      lifeSpan: json['life_span'] as String,
      temperament: json['temperament'] as String,
      origin: json['origin'] as String?,
      referenceImageId: json['reference_image_id'] as String,
      heightInCm: json['height']['metric'] as String,
      heightInInch: json['height']['imperial'] as String,
      weightInKg: json['weight']['metric'] as String,
      weightInLb: json['weight']['imperial'] as String,
    );
  }

  String get description {
    return 'Name: $name\n'
        'Bred for: ${bredFor ?? "Unknown"}\n'
        'Breed group: $breedGroup\n'
        'Life span: $lifeSpan\n'
        'Temperament: $temperament\n'
        '${origin != null ? "Origin: $origin\n" : ""}'
        'Height: $heightInCm cm ($heightInInch inches)\n'
        'Weight: $weightInKg kg ($weightInLb lb)';
  }

  String get imageUrl {
    return 'https://cdn2.thedogapi.com/images/$referenceImageId.jpg';
  }
}
