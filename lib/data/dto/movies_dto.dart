import 'package:json_annotation/json_annotation.dart';

part 'movies_dto.g.dart';

@JsonSerializable(createToJson: false)
class MoviesDto {
  final List<MovieDataDto>? titles;

  const MoviesDto(this.titles);

  factory MoviesDto.fromJson(Map<String, dynamic> json) => _$MoviesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MovieDataDto {
  final String? id;
  final String? type;
  final String? primaryTitle;
  final int? startYear;
  final String? plot;
  @JsonKey(name: "primaryImage")
  final MovieImageDto? imageData;

  const MovieDataDto({this.id, this.type, this.primaryTitle, this.startYear, this.plot, this.imageData});
  factory MovieDataDto.fromJson(Map<String, dynamic> json) => _$MovieDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MovieImageDto {
  final String url;
  final int width;
  final int height;

  const MovieImageDto(this.url, this.width, this.height);
  factory MovieImageDto.fromJson(Map<String, dynamic> json) => _$MovieImageDtoFromJson(json);

}