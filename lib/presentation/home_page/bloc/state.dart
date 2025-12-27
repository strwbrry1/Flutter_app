import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/models/card.dart';

class HomeState extends Equatable {
  final List<CardData>? data;
  final bool isLoading;

  const HomeState({this.data = const [], this.isLoading = false});

  HomeState copyWith({List<CardData>? data, bool? isLoading, String? error}) =>
      HomeState(data: data ?? this.data, isLoading: isLoading ?? this.isLoading);

  @override
  List<Object?> get props => [data, isLoading];
}
