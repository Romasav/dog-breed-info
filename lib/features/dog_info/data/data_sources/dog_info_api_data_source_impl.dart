import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:test_project/features/dog_info/data/models/api_dog_info_model.dart';

import '../../../../core/exceptions/query_exeptions/no_match_found_exception.dart';
import '../../../../core/exceptions/server_exeptions/server_exeption.dart';
import 'dog_info_api_data_source.dart';

class DogInfoApiDataSourceImpl implements DogInfoApiDataSource {
  final http.Client client;

  DogInfoApiDataSourceImpl({required this.client});

  @override
  Future<ApiDogInfoModel> getSpecificDogInfo(String breed) async {
    final response = await client
        .get(Uri.parse('https://api.thedogapi.com/v1/breeds/search?q=$breed'));

    if (response.statusCode != 200) {
      throw ServerException(
          message:
              'Something went wrong while fetching dog info, status code: ${response.statusCode}');
    }

    final json = response.body;
    final List<dynamic> data = jsonDecode(json);

    if (data.isEmpty) {
      throw NoMatchFoundException('No match found for breed: $breed');
    }

    final dogInfoJson = data.first;
    final apiDogInfoModel = ApiDogInfoModel.fromJson(dogInfoJson);

    return apiDogInfoModel;
  }

  @override
  Future<ApiDogInfoModel> getRandomDogInfo() async {
    final response =
        await client.get(Uri.parse('https://api.thedogapi.com/v1/breeds'));

    if (response.statusCode != 200) {
      throw ServerException(
          message:
              'Something went wrong while fetching dog info, status code: ${response.statusCode}');
    }

    final json = response.body;
    final List<dynamic> data = jsonDecode(json);

    // Get a random breed
    final randomBreedIndex = Random().nextInt(data.length);
    final dogInfoJson = data[randomBreedIndex];

    final apiDogInfoModel = ApiDogInfoModel.fromJson(dogInfoJson);

    return apiDogInfoModel;
  }
}
