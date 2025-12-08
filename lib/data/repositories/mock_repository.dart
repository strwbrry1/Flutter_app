import 'package:flutter/material.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';

import '../../domain/models/card.dart';

class MockRepository extends ApiInterface {
  @override
  Future<List<CardData>> loadData({String? q, OnErrorCallback? onError}) async {
    return [
      CardData(
        "text",
        description: "hello",
        icon: Icons.skateboarding_outlined,
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg/330px-Manul_Timofey_in_April_2025_%281%2C_cropped%29.jpg',
      ),
      CardData(
        "test",
        description: "world",
        icon: Icons.wifi,
        imageUrl:
        'https://static.mk.ru/upload/entities/2024/09/27/06/articles/facebookPicture/1d/39/cc/b7/8e98fb7312647c5aaf958cae41c94691.jpg',
      ),
      CardData(
        "something",
        description: "send help",
        icon: Icons.sos,
        imageUrl:
        'https://cs9.pikabu.ru/post_img/2017/08/27/4/og_og_1503809823210718041.jpg',
      ),
    ];
  }
}