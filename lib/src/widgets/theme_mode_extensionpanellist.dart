import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

part 'theme_mode_extensionpanel.dart';

class ThemeModeExpansionPanelList extends StatelessWidget {
  const ThemeModeExpansionPanelList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _ExpansionCubit(),
      child: BlocBuilder<_ExpansionCubit, bool>(builder: (context, state) {
        return ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            context.read<_ExpansionCubit>().setExpansion(state);
          },
          children: [
            _themeExpansionPanel(context),
          ],
        );
      }),
    );
  }
}
