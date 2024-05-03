import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_demo/screens/animated_selector.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

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
    final cubit = context.read<UIThemeModeCubit>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${cubit.brightness}'),
          const AnimatedSelector(choices: 3),
          SizedBox(
            width: 200,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.rainbow.image(),
            ),
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
