import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nosql_dart/nosql_dart.dart';

import 'package:ui_theme_mode_flutter/src/cubit/ui_thememode_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UIThemeModeCubit tests:', () {
    late UIThemeModeCubit<Box<String>> uiThemeModeCubit;
    late NoSqlAbstract noSqlProvider;

    setUp(() {
      noSqlProvider = NoSqlHiveTemp();
    });
    tearDown(() async {
      try {
        await uiThemeModeCubit.close();
      } catch (_) {}
    });

    blocTest<UIThemeModeCubit<Box<String>>, UIThemeModeState>(
        'Initial state is UIThemeModeInitial',
        build: () {
          uiThemeModeCubit =
              UIThemeModeCubit<Box<String>>(noSqlProvider: noSqlProvider);
          return uiThemeModeCubit;
        },
        act: (cubit) => cubit.setUp(),
        expect: () => const <UIThemeModeState>[
              UIThemeModeSet(ThemeMode.system),
            ]);
    blocTest<UIThemeModeCubit<Box<String>>, UIThemeModeState>('Set Theme Mode',
        build: () {
          uiThemeModeCubit =
              UIThemeModeCubit<Box<String>>(noSqlProvider: noSqlProvider);
          return uiThemeModeCubit;
        },
        act: (cubit) async {
          await cubit.setUp();
          await cubit.setThemeMode(ThemeMode.dark);
        },
        expect: () => const <UIThemeModeState>[
              UIThemeModeSet(ThemeMode.system),
              UIThemeModeSet(ThemeMode.dark),
            ]);
  });
}
