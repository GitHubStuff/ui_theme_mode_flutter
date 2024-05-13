import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cubit/ui_thememode_cubit.dart';
import '../splash_screen.dart';

part 'thememode_app_module.dart';
part 'material_router_widget.dart';

class ThemeModeSetup extends StatelessWidget {
  final Widget initialScreen;
  final Widget splashWidget;
  final Duration splashScreenDuration;
  final ThemeData? darkTheme;
  final ThemeData? lightTheme;
  final Iterable<ThemeExtension<dynamic>> themeExtensions;
  final List<BlocProvider> blocProviders;

  //MARK: Constructor
  const ThemeModeSetup({
    super.key,
    required this.initialScreen,
    this.splashWidget = const SizedBox(),
    this.splashScreenDuration = Duration.zero,
    this.darkTheme,
    this.lightTheme,
    this.themeExtensions = const [],
    this.blocProviders = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: ThemeAppModule(
        homeScreen: initialScreen,
        splashWidget: splashWidget,
        splashScreenDuration: splashScreenDuration,
      ),
      child: MaterialRouterWidget(
        darkTheme: (darkTheme ?? ThemeData.dark())
            .copyWith(extensions: themeExtensions),
        lightTheme: (lightTheme ?? ThemeData.light())
            .copyWith(extensions: themeExtensions),
        blocProviders: blocProviders,
      ),
    );
  }
}
