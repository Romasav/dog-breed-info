import '../../domain/entities/dog_info.dart';
import '../models/api_dog_info_model.dart';

class DogInfoConverter {
  static DogInfo fromApiModel(ApiDogInfoModel model) {
    return DogInfo(
      breed: model.name,
      description: model.description,
      imageUrl: model.imageUrl,
    );
  }
}
