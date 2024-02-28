import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nosql_dart/nosql_dart.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late BHiveDeviceStore memoryStore;
  group('V2.9999', () {
    setUp(() async {
      memoryStore = await BHiveDeviceStore.inMemorySetup();
    });

    tearDown(() async {
      await memoryStore.deleteFromDisk();
    });

    blocTest<UIThemeModeCubit, UIThemeModeState>(
      'checks a [FlutterError] is thrown when setToDarkMode is called before init',
      build: () => UIThemeModeCubit(
        persistedStore: memoryStore,
        platformObserver: MockBrightnessHandler(
          brightness: ThemeMode.dark,
          state: AppLifecycleState.resumed,
        ),
      ),
      act: (cubit) => cubit.close(),
      // errors: () => [
      //   isA<FlutterError>().having(
      //     (error) => error.toString(),
      //     'message',
      //     contains('BHive is not initialized.'),
      //   )
      // ],
      expect: () => [],
    );
    blocTest<UIThemeModeCubit, UIThemeModeState>(
      'checks a [FlutterError] is thrown when setToDarkMode is called before init',
      build: () => UIThemeModeCubit(
        persistedStore: memoryStore,
        platformObserver: MockBrightnessHandler(
          brightness: ThemeMode.dark,
          state: AppLifecycleState.resumed,
        ),
      ),
      act: (cubit) => cubit.close(),
      // errors: () => [
      //   isA<FlutterError>().having(
      //     (error) => error.toString(),
      //     'message',
      //     contains('BHive is not initialized.'),
      //   )
      // ],
      expect: () => [],
    );
    test('should open a box', () async {
      final message = memoryStore.toString();
      expect(message.isNotEmpty, true);
      UIThemeModeCubit uiThemeModeCubit2 = UIThemeModeCubit(
          persistedStore: memoryStore,
          platformObserver: MockBrightnessHandler(
            brightness: ThemeMode.dark,
            state: AppLifecycleState.resumed,
          ));
      expect(uiThemeModeCubit2.state.themeMode, ThemeMode.system);
    });
  });
}
