import 'package:dio/dio.dart';
import 'package:flutter_app/data/dto/movies_dto.dart';
import 'package:flutter_app/data/mappers/movie_data_dto_to_model.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/card.dart';

class MovieRepository extends ApiInterface {
  static final Dio _dio = Dio()..interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
  ));

  static const String _baseUrl = 'https://api.imdbapi.dev';

  @override
  Future<List<CardData>?> loadData({String? q, OnErrorCallback? onError}) async {
    try {
      String url = '';
      if (q == null){
        url = '$_baseUrl/titles';
      }
      else {
        url = '$_baseUrl/search/titles?query=$q&limit=25';
      }
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(url);

      final MoviesDto dto = MoviesDto.fromJson(response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.titles?.map((e) => e.toDomain()).toList();
      final List<CardData>? trimmed = data?.sublist(0, 20);
      return trimmed;
    } on DioException catch(e) {
      onError?.call(e.response?.statusMessage);
      return null;
    }
  }
}