import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode, WidgetsBinding;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:nosql_dart/nosql_dart.dart';

import '../extensions/thememode_extension.dart';

part 'ui_thememode_state.dart';

abstract class UIThemeModeAbstract {
  static const String databaseName = 'icfy_uithememode_database_v1r829464';
  static const String containerName = 'icfy_uithememode_container_v1r816447';
  static const String keyName = 'themeMode';
  void setUp();
  void setToDarkMode();
  void setToLightMode();
  void setToSystemMode();
  Brightness get brightness;
}

class UIThemeModeCubit<CONTAINER> extends Cubit<UIThemeModeState>
    implements UIThemeModeAbstract {
  static UIThemeModeCubit? _singleton;
  static ThemeMode _initialThemeMode = ThemeMode.dark;

  static UIThemeModeCubit volatile({
    ThemeMode initialThemeMode = ThemeMode.dark,
  }) {
    if (_singleton == null) {
      debugPrint('🧨🧨🧨🧨 VOLATILE DATABASE 🧨🧨🧨🧨');
      _initialThemeMode = initialThemeMode;
      _singleton = UIThemeModeCubit._(
        noSqlProvider: NoSqlHiveTemp(),
        initialThemeMode: _initialThemeMode,
      );
    }
    return _singleton!;
  }

  static UIThemeModeCubit persisted({
    ThemeMode initialThemeMode = ThemeMode.dark,
  }) {
    if (_singleton == null) {
      debugPrint('🙏🏽🙏🏽🙏🏽 PERSITED DATABASE 🙏🏽🙏🏽');
      _initialThemeMode = initialThemeMode;
      _singleton = UIThemeModeCubit._(
        noSqlProvider: NoSqlHive(),
        initialThemeMode: _initialThemeMode,
      );
    }
    return _singleton!;
  }

  // Private Constructor
  UIThemeModeCubit._(
      {required NoSqlAbstract noSqlProvider,
      required ThemeMode initialThemeMode})
      : _noSqlProvider = noSqlProvider,
        super(CubitInitial(initialThemeMode));

  //💠💠💠💠 Class
  UIThemeModeCubit({
    required NoSqlAbstract noSqlProvider,
    required ThemeMode initialThemeMode,
  })  : _noSqlProvider = noSqlProvider,
        super(CubitInitial(initialThemeMode));

  final NoSqlAbstract _noSqlProvider;
  CONTAINER? _themeContainer;

  @override
  FutureOr<void> setUp() async {
    if (state is! CubitInitial) return;
    emit(CubitConnectNoSql(state.themeMode));
    debugPrint('🔒🔒🔒🔒 SETUP RUN LOCK ENABLED 🔒🔒🔒🔒');
    await _noSqlProvider.init(databaseName: UIThemeModeAbstract.databaseName);
    await _setGlobalThemeContainer();
    ThemeMode themeModeFromNoSql = _getThemeModeFromNoSql();
    emit(CubitThemeSet(themeModeFromNoSql));
    debugPrint('🔓 SETUP COMPLETE 🔓');
  }

  Future<void> _setGlobalThemeContainer() async =>
      _themeContainer ??= await _noSqlProvider.openContainer<CONTAINER, String>(
        name: UIThemeModeAbstract.containerName,
      );

  ThemeMode _getThemeModeFromNoSql() {
    String themeModeString = _noSqlProvider.get<CONTAINER>(
      UIThemeModeAbstract.keyName,
      fromContainer: _themeContainer as CONTAINER,
      defaultValue: _initialThemeMode.name,
    );
    return ThemeModeExtension.from(string: themeModeString);
  }

  @override
  void setToDarkMode() => _setThemeMode(ThemeMode.dark);

  @override
  void setToLightMode() => _setThemeMode(ThemeMode.light);

  @override
  void setToSystemMode() => _setThemeMode(ThemeMode.system);

  void _setThemeMode(ThemeMode newThemeMode) async {
    debugPrint('** Setting ${state.themeMode} to: $newThemeMode **');
    if (state is! CubitThemeSet) {
      throw NoSqlError('🚫 Database not initialized 🚫');
    }
    if (newThemeMode == state.themeMode) return;
    _putThemeMode(newThemeMode, _themeContainer as CONTAINER);
    emit(CubitThemeSet(newThemeMode));
  }

  void _putThemeMode(
    ThemeMode themeMode,
    CONTAINER themeContainer,
  ) =>
      _noSqlProvider.put<CONTAINER, String>(
        UIThemeModeAbstract.keyName,
        themeMode.name,
        intoContainer: themeContainer,
      );

  @override
  Future<void> close() async {
    await _shutdownNoSql();
    super.close();
  }

  Future<void> _shutdownNoSql() async {
    if (state is! CubitThemeSet) return;
    await _noSqlProvider.close<CONTAINER>(
      container: _themeContainer as CONTAINER,
    );
    await _noSqlProvider.closeDatabase();
  }

  @override
  Brightness get brightness {
    switch (state.themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}
