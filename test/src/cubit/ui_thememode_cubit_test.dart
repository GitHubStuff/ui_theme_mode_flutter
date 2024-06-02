import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nosql_dart/nosql_dart.dart';

import 'package:ui_theme_mode_flutter/src/cubit/ui_thememode_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UIThemeModeCubit tests:', () {
    late NoSqlAbstract noSqlProvider;

    setUp(() {
      noSqlProvider = NoSqlHiveTemp();
    });
    tearDown(() async {
      try {
        //await uiThemeModeCubit.close();
      } catch (_) {}
    });

    blocTest<UIThemeModeCubit<Box<String>>, UIThemeModeState>(
        'Initial state is UIThemeModeInitial (aka dark)',
        build: () {
          debugPrint(
              'Starting: Initial state is UIThemeModeInitial (aka dark)');
          return UIThemeModeCubit<Box<String>>(
            noSqlProvider: noSqlProvider,
            initialThemeMode: ThemeMode.dark,
          );
        },
        act: (cubit) async => await cubit.restore(),
        expect: () => <UIThemeModeState>[
              const CubitWaitingToConnectMySql(ThemeMode.dark),
              const CubitThemeSet(ThemeMode.dark),
            ]);
    blocTest<UIThemeModeCubit<Box<String>>, UIThemeModeState>(
        'Set to ThemeMode.system',
        build: () {
          debugPrint('Starting: Set to ThemeMode.system');
          return UIThemeModeCubit<Box<String>>(
            noSqlProvider: noSqlProvider,
            initialThemeMode: ThemeMode.light,
          );
        },
        act: (cubit) async {
          await cubit.restore();
          cubit.setToSystemMode();
        },
        expect: () => <UIThemeModeState>[
              const CubitWaitingToConnectMySql(ThemeMode.light),
              const CubitThemeSet(ThemeMode.light),
              const CubitThemeSet(ThemeMode.system),
            ]);
    blocTest<UIThemeModeCubit<Box<String>>, UIThemeModeState>(
        'Set to ThemeMode.light',
        build: () {
          return UIThemeModeCubit<Box<String>>(
            noSqlProvider: noSqlProvider,
            initialThemeMode: ThemeMode.dark,
          );
        },
        act: (cubit) async {
          await cubit.restore();
          cubit.setToSystemMode();
        },
        expect: () => <UIThemeModeState>[
              const CubitWaitingToConnectMySql(ThemeMode.dark),
              const CubitThemeSet(ThemeMode.dark),
              const CubitThemeSet(ThemeMode.system),
            ]);
  });
}
