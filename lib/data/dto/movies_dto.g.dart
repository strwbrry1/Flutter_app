// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesDto _$MoviesDtoFromJson(Map<String, dynamic> json) => MoviesDto(
  (json['titles'] as List<dynamic>?)
      ?.map((e) => MovieDataDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

MovieDataDto _$MovieDataDtoFromJson(Map<String, dynamic> json) => MovieDataDto(
  id: json['id'] as String?,
  type: json['type'] as String?,
  primaryTitle: json['primaryTitle'] as String?,
  startYear: json['startYear'] as int?,
  plot: json['plot'] as String?,
  imageData: json['primaryImage'] == null
      ? null
      : MovieImageDto.fromJson(json['primaryImage'] as Map<String, dynamic>),
);

MovieImageDto _$MovieImageDtoFromJson(Map<String, dynamic> json) =>
    MovieImageDto(
      json['url'] as String,
      (json['width'] as num).toInt(),
      (json['height'] as num).toInt(),
    );
