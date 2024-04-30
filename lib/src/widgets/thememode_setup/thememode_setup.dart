import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cubit/ui_thememode_cubit.dart';
import '../splash_screen.dart';

part 'thememode_app_module.dart';
part 'material_router_widget.dart';

class ThemeModeSetup extends StatelessWidget {
  final Widget homeScreen;
  final Widget splashWidget;
  final Duration splashScreenDuration;
  const ThemeModeSetup({
    super.key,
    required this.homeScreen,
    this.splashWidget = const SizedBox(),
    this.splashScreenDuration = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: AppModule(
        homeScreen: homeScreen,
        splashWidget: splashWidget,
        splashScreenDuration: splashScreenDuration,
      ),
      child: const MaterialRouterWidget(),
    );
  }
}
