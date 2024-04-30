import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/ui_thememode_cubit.dart';

Brightness getPlatformBrightness() =>
    WidgetsBinding.instance.platformDispatcher.platformBrightness;

class LifecycleWatcherX extends StatefulWidget {
  final Widget child;

  const LifecycleWatcherX({
    super.key,
    required this.child,
  });

  @override
  State<LifecycleWatcherX> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcherX>
    with WidgetsBindingObserver {
  Brightness? lastBrightness;
  UIThemeModeCubit? cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    lastBrightness = getPlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Check the current brightness
      var currentBrightness = getPlatformBrightness();
      if (currentBrightness != lastBrightness) {
        // Brightness has changed
        debugPrint(
            'Brightness changed from $lastBrightness to $currentBrightness');
        lastBrightness = currentBrightness;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    cubit ??= context.read<UIThemeModeCubit>();
    return widget.child;
  }
}
