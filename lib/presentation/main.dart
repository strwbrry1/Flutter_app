import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/locale/l10n/app_locale.dart';
import 'package:flutter_app/data/repositories/like_repository.dart';
import 'package:flutter_app/data/repositories/movie_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_app/presentation/like_bloc/like_event.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (_) => MovieRepository(),
        ),
        RepositoryProvider<LikeRepository>(
          create: (_) => LikeRepository()
        )
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LocaleBloc>(
                lazy: false,
                create: (_) => LocaleBloc(Locale(Platform.localeName)),
              ),
              BlocProvider<HomeBloc>(
                lazy: false,
                create: (context) =>
                    HomeBloc(context.read<MovieRepository>()),
              ),
              BlocProvider<LikeBloc>(
                lazy: false,
                create: (_) => LikeBloc(context.read<LikeRepository>())..add(const LoadLikesEvent()),
              ),
            ],
            child: BlocBuilder<LocaleBloc, LocaleState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  locale: state.currentLocale,
                  localizationsDelegates: AppLocale.localizationsDelegates,
                  supportedLocales: AppLocale.supportedLocales,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.accents.first,
                    ),
                  ),
                  home: const MyHomePage(),
                );
              },
            ),
          );
        }
      ),
    );
  }
}
