import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/extensions/context_x.dart';
import 'package:flutter_app/components/utils/debounce.dart';
import 'package:flutter_app/data/repositories/movie_repository.dart';
import 'package:flutter_app/presentation/common/svg_objects.dart';
import 'package:flutter_app/presentation/details_page/details_page.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/card.dart';
import '../like_bloc/like_bloc.dart';
import '../like_bloc/like_event.dart';
import '../locale_bloc/locale_state.dart';
import 'bloc/state.dart';
part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: _Body()));
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final searchController = TextEditingController();
  late Future<List<CardData>?> data;

  final repo = MovieRepository();

  @override
  void initState() {
    SvgObjects.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    context.read<LikeBloc>().add(const LoadLikesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoSearchTextField(
                    placeholder: context.locale.search,
                    controller: searchController,
                    onChanged: (search) {
                      //setState(() {
                      Debounce.run(() => context.read<HomeBloc>().add(HomeLoadDataEvent(search: search)));
                      //});
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
                child: SizedBox.square(
                  dimension: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BlocBuilder<LocaleBloc, LocaleState>(
                      builder: (context, state) {
                        return state.currentLocale.languageCode == "ru"
                            ? const SvgRu()
                            : const SvgUs();
                      }
                    ),
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              final items = state.data ?? [];
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final data = state.data?[index];
                      return data != null
                          ? _Card.fromData(
                              data,
                              onLike: (title, isLiked) => _showSnackbar(context, title, isLiked),
                              onTap: () => _navToDetails(context, data),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailsPage(data)));
  }

  void _showSnackbar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$title ${isLiked ? context.locale.liked : context.locale.disliked}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  Future<void> _onRefresh() {
    context.read<HomeBloc>().add(HomeLoadDataEvent(search: searchController.text));
    return Future.value(null);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
