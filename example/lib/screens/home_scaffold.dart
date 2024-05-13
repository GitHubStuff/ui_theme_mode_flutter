import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';
import 'package:ui_extensions_flutter/ui_extensions_flutter.dart';

import '../gen/assets.gen.dart';

class HomeScaffold extends StatelessWidget {
  static const route = '/HomeScaffold';

  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    final cubit = context.watch<UIThemeModeCubit>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${cubit.brightness}'),
          //const RingAndCircleWidget(diameter: 25),

          //const AnimatedSelector(),
          SizedBox(
            width: 150,
            height: 150,
            child: Assets.images.rainbow.image().withPaddingAll(8.0),
          ),
          ElevatedButton(
              onPressed: () {
                cubit.setToDarkMode();
              },
              child: const Text('Dark')),
          ElevatedButton(
              onPressed: () {
                cubit.setToLightMode();
              },
              child: const Text('Light')),
          ElevatedButton(
              onPressed: () {
                cubit.setToSystemMode();
              },
              child: const Text('Device')),
          //const ThemeModeExpansionPanelList(),
        ],
      ),
    );
  }
}
