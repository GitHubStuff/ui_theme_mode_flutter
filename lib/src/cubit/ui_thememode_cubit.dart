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

  static UIThemeModeCubit volatile({
    ThemeMode initialThemeMode = ThemeMode.dark,
  }) {
    _singleton ??= UIThemeModeCubit._(
      noSqlProvider: NoSqlHiveTemp(),
      initialThemeMode: initialThemeMode,
    );
    return _singleton!;
  }

  static UIThemeModeCubit persisted({
    ThemeMode initialThemeMode = ThemeMode.dark,
  }) {
    _singleton ??= UIThemeModeCubit._(
      noSqlProvider: NoSqlHive(),
      initialThemeMode: initialThemeMode,
    );
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
    emit(CubitWaitingToConnectMySql(state.themeMode));
    await _noSqlProvider.init(databaseName: UIThemeModeAbstract.databaseName);
    await _setGlobalThemeContainer();
    ThemeMode themeModeFromNoSql = _getThemeModeFromNoSql();
    _didSaveThemModeToNoSql(themeModeFromNoSql);
    emit(CubitThemeSet(themeModeFromNoSql));
  }

  Future<void> _setGlobalThemeContainer() async =>
      _themeContainer ??= await _noSqlProvider.openContainer<CONTAINER, String>(
        name: UIThemeModeAbstract.containerName,
      );

  ThemeMode _getThemeModeFromNoSql() {
    String themeModeString = _noSqlProvider.get<CONTAINER>(
      UIThemeModeAbstract.keyName,
      fromContainer: _themeContainer as CONTAINER,
      defaultValue: state.themeMode.name,
    );
    return ThemeModeExtension.from(string: themeModeString);
  }

  bool _didSaveThemModeToNoSql(ThemeMode newThemeMode) {
    if (newThemeMode == state.themeMode) return false;
    if (state is! CubitThemeSet && state is! CubitWaitingToConnectMySql) {
      throw NoSqlError('🚫 Database not initialized 🚫');
    }
    _noSqlProvider.put<CONTAINER, String>(
      UIThemeModeAbstract.keyName,
      newThemeMode.name,
      intoContainer: _themeContainer as CONTAINER,
    );
    return true;
  }

  @override
  void setToDarkMode() {
    if (_didSaveThemModeToNoSql(ThemeMode.dark)) {
      emit(const CubitThemeSet(ThemeMode.dark));
    }
  }

  @override
  void setToLightMode() {
    if (_didSaveThemModeToNoSql(ThemeMode.light)) {
      emit(const CubitThemeSet(ThemeMode.light));
    }
  }

  @override
  void setToSystemMode() {
    if (_didSaveThemModeToNoSql(ThemeMode.system)) {
      emit(const CubitThemeSet(ThemeMode.system));
    }
  }

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
