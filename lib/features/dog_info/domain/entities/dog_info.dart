import 'package:equatable/equatable.dart';

class DogInfo extends Equatable{
  final String breed;
  final String description;
  final String imageUrl;

  const DogInfo({
    required this.breed,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [breed, description, imageUrl];
}