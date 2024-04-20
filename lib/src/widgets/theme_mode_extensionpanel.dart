part of 'theme_mode_extensionpanellist.dart';

class _ExpansionCubit extends Cubit<bool> {
  _ExpansionCubit() : super(false);

  void setExpansion(bool isExpanded) => emit(!isExpanded);
}

ExpansionPanel _themeExpansionPanel(BuildContext context) => ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor: Colors.blue[700],
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(
              'Brightness - ${context.watch<UIThemeModeCubit>().themeMode.label}'),
        );
      },
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ThemeMode.values
            .map((option) =>
                buildRadioOption(option, context.watch<UIThemeModeCubit>()))
            .toList(),
      ),
      isExpanded: context.watch<_ExpansionCubit>().state,
    );

Widget buildRadioOption(ThemeMode option, UIThemeModeCubit cubit) {
  return InkWell(
    onTap: () {},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<ThemeMode>(
          value: option,
          groupValue: cubit.state.themeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) {
              cubit.themeMode = value;
            }
          },
        ),
        Text(option.label),
      ],
    ),
  );
}
