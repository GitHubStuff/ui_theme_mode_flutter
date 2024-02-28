// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    //TODO: Replace with your own code
    // ignore: non_constant_identifier_names
    final PackageTemplate ui_theme_mode_flutter = PackageTemplate();
    debugPrint('$ui_theme_mode_flutter');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Assets.images.rainbow.image(),
            ),
          ),
        ],
      ),
    );
  }
}
