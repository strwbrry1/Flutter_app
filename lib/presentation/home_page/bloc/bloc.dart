import 'package:flutter_app/data/repositories/movie_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(isLoading: true));

    final data = await repository.loadData(q: event.search);

    emitter(state.copyWith(isLoading: false, data: data ?? []));
  }
}
