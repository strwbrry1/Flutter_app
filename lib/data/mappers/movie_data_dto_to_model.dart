import 'package:flutter_app/data/dto/movies_dto.dart';
import 'package:flutter_app/domain/models/card.dart';

String _placeholderImg = 'https://commons.wikimedia.org/wiki/File:A_Specimen_by_William_Caslon.jpg';

extension MovieDataDtoToModel on MovieDataDto {
  CardData toDomain() => CardData(
    primaryTitle!,
    description: startYear!.toString(),
    imageUrl: imageData?.url ?? _placeholderImg,
  );
}