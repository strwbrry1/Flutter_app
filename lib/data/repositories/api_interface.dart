import 'package:flutter_app/domain/models/card.dart';
typedef OnErrorCallback = void Function(String? error);
abstract class ApiInterface {
  Future<List<CardData>?> loadData({String? q, OnErrorCallback? onError});
}