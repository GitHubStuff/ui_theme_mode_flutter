import 'package:flutter/material.dart';

abstract class UIThemeModeAbstract {
  static const String databaseName = 'icfy_uithememode_database_v1r829464';
  static const String containerName = 'icfy_uithememode_container_v1r816447';
  static const String keyName = 'themeMode';
  void restore();
  void setToDarkMode();
  void setToLightMode();
  void setToSystemMode();
  Brightness get brightness;
}
