import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/presentation/like_bloc/like_event.dart';
import 'package:flutter_app/presentation/like_bloc/like_state.dart';

import '../../data/repositories/like_repository.dart';


class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeRepository repository;

  LikeBloc(this.repository)
      : super(const LikeState(likedIds: [])) {
    on<LoadLikesEvent>(_onLoadLikes);
    on<ChangeLikeEvent>(_onChangeLike);
  }

  Future<void> _onLoadLikes(
      LoadLikesEvent event,
      Emitter<LikeState> emit,
      ) async {
    final data = await repository.loadLikes();
    emit(state.copyWith(likedIds: data));
  }

  Future<void> _onChangeLike(
      ChangeLikeEvent event,
      Emitter<LikeState> emit,
      ) async {
    await repository.toggleLike(event.id);
    final data = await repository.loadLikes();
    emit(state.copyWith(likedIds: data));
  }
}
