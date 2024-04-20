import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nosql_dart/nosql_dart.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  group('UIThemeModeCubit', () {
    late OnDeviceStore setToAppLight;
    late OnDeviceStore setToSystemDar;
    late OnDeviceStore systemModeLight;
    late OnDeviceStore modeFetch;

    blocTest<UIThemeModeCubit, UIThemeModeState>(
      'set to AppLight',
      setUp: () async => setToAppLight = await BHiveDeviceStore.inMemorySetup(),
      build: () => UIThemeModeCubit(
        persistedStore: setToAppLight,
        platformObserver: MockBrightnessHandler(
            brightness: ThemeMode.dark, state: AppLifecycleState.hidden),
      ),
      tearDown: () async => await setToAppLight.deleteFromDisk(),
      act: (cubitA) => cubitA.setToLightMode(),
      expect: () => [const UIThemeModeNewState(ThemeMode.light)],
    );

    blocTest<UIThemeModeCubit, UIThemeModeState>(
      '🩷set to system when themeMode is dark',
      setUp: () async =>
          setToSystemDar = await BHiveDeviceStore.inMemorySetup(),
      build: () => UIThemeModeCubit(
        persistedStore: setToSystemDar,
        platformObserver: MockBrightnessHandler(
          brightness: ThemeMode.dark,
          state: AppLifecycleState.resumed,
        ),
      ),
      tearDown: () async => await setToSystemDar.deleteFromDisk(),
      act: (cubitB) {
        cubitB.setToLightMode();
        Future.delayed(const Duration(microseconds: 1000));
        cubitB.setToDeviceMode();
      },
      expect: () => [
        const UIThemeModeNewState(ThemeMode.light),
        const UIThemeModeNewState(ThemeMode.system)
      ],
    );

    blocTest<UIThemeModeCubit, UIThemeModeState>(
      'Set to systemModeLight',
      setUp: () async => modeFetch = await BHiveDeviceStore.inMemorySetup(),
      build: () => UIThemeModeCubit(
        persistedStore: modeFetch,
        platformObserver: MockBrightnessHandler(
          brightness: ThemeMode.dark,
          state: AppLifecycleState.resumed,
        ),
      ),
      tearDown: () => modeFetch.deleteFromDisk(),
      act: (cubitC) {
        cubitC.setToDarkMode();
        Future.delayed(const Duration(microseconds: 100));
        cubitC.setToDeviceMode();
      },
      expect: () => [
        const UIThemeModeNewState(ThemeMode.dark),
        const UIThemeModeNewState(ThemeMode.system)
      ],
    );

    blocTest<UIThemeModeCubit, UIThemeModeState>(
      'Mode Fetch',
      setUp: () async =>
          systemModeLight = await BHiveDeviceStore.inMemorySetup(),
      build: () => UIThemeModeCubit(
        persistedStore: systemModeLight,
        platformObserver: MockBrightnessHandler(
          brightness: ThemeMode.light,
          state: AppLifecycleState.resumed,
        ),
      ),
      tearDown: () => systemModeLight.deleteFromDisk(),
      act: (cubit) {
        cubit.setToDarkMode();
        expect(cubit.themeMode, ThemeMode.dark);
        cubit.setToLightMode();
        expect(cubit.themeMode, ThemeMode.light);
      },
      expect: () => [
        const UIThemeModeNewState(ThemeMode.dark),
        const UIThemeModeNewState(ThemeMode.light),
      ],
    );
  });
}
