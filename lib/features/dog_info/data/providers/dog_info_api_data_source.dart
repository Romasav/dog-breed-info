import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_sources/dog_info_api_data_source.dart';
import '../data_sources/dog_info_api_data_source_impl.dart';

part 'dog_info_api_data_source.g.dart';

@Riverpod(dependencies: [])
DogInfoApiDataSource dogInfoApiDataSource(
  DogInfoApiDataSourceRef ref,
) {
  return DogInfoApiDataSourceImpl(client: http.Client());
}
