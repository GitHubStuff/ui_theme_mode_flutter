import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:nosql_dart/nosql_dart.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';
import '../extensions/thememode_extension.dart' show ThemeModeExtension;

part 'ui_thememode_state.dart';

abstract class UIThemeModeAbstract {
  static const String databaseName = 'icfy_uithememode_database_v1r829464';
  static const String containerName = 'icfy_uithememode_container_v1r829444';
  static const String keyName = 'themeMode';
  Future<void> setUp();
  Future<void> setThemeMode(ThemeMode themeMode);
}

class UIThemeModeCubit<CONTAINER> extends Cubit<UIThemeModeState>
    implements UIThemeModeAbstract {
  // Constructor
  UIThemeModeCubit({required NoSqlAbstract noSqlProvider})
      : _noSqlProvider = noSqlProvider,
        super(const UIThemeModeInitial());

  final NoSqlAbstract _noSqlProvider;

  @override
  Future<void> setUp() async {
    await _init();
    await _openContainer();
    ThemeMode themeMode = await _getThemeMode();
    emit(UIThemeModeSet(ThemeModeExtension.from(string: themeMode.name)));
  }

  Future<void> _init() async =>
      await _noSqlProvider.init(databaseName: UIThemeModeAbstract.databaseName);

  Future<CONTAINER> _openContainer() async {
    return await _noSqlProvider.openContainer<CONTAINER, String>(
      name: UIThemeModeAbstract.containerName,
    );
  }

  Future<ThemeMode> _getThemeMode() async {
    final themeContainer = await _openContainer();
    String themeModeString = _noSqlProvider.get<CONTAINER>(
      UIThemeModeAbstract.keyName,
      fromContainer: themeContainer,
      defaultValue: ThemeMode.system.name,
    );
    return ThemeModeExtension.from(string: themeModeString);
  }

  @override
  Future<void> close() async {
    await _shutdown();
    super.close();
  }

  Future<void> _shutdown() async {
    final themeContainer = await _openContainer();
    await _putThemeMode(state.themeMode, themeContainer);
    await _noSqlProvider.close<CONTAINER>(container: themeContainer);
    await _noSqlProvider.closeDatabase();
  }

  Future<void> _putThemeMode(
    ThemeMode themeMode,
    CONTAINER themeContainer,
  ) async =>
      await _noSqlProvider.put<CONTAINER, String>(
        UIThemeModeAbstract.keyName,
        themeMode.name,
        intoContainer: themeContainer,
      );

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    emit(UIThemeModeSet(themeMode));
    final themeContainer = await _openContainer();
    return _putThemeMode(themeMode, themeContainer);
  }
}
