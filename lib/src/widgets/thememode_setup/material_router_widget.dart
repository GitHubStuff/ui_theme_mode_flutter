part of 'thememode_setup.dart';

/// The main widget of the application.
class MaterialRouterWidget extends StatelessWidget {
  final ThemeData? darkTheme;
  final ThemeData? lightTheme;
  final List<BlocProvider> blocProviders;

  const MaterialRouterWidget({
    super.key,
    required this.darkTheme,
    required this.lightTheme,
    this.blocProviders = const [],
  });

  // Build the widget tree for MyApp.
  @override
  Widget build(BuildContext context) {
    // Get the UIThemeModeCubit from the dependency injection container.
    UIThemeModeCubit cubit = Modular.get<UIThemeModeCubit>()..setUp();
    debugPrint('🔀 Inside MyApp state: ${cubit.state}');
    // Use a BlocBuilder to rebuild the MaterialApp when the UIThemeModeState changes.
    return BlocBuilder<UIThemeModeCubit, UIThemeModeState>(
      bloc: cubit,
      builder: (context, state) {
        // Return a MaterialApp with a router.
        debugPrint('🔀✅ Inside MyApp state: ${cubit.state}');
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: cubit.state.themeMode,
          localizationsDelegates: const [],
          // Use a BlocProvider to provide the UIThemeModeCubit to the widget tree.
          builder: (context, routerBuilder) => MultiBlocProvider(
            providers: [
              BlocProvider<UIThemeModeCubit>(create: (_) => cubit),
              ...blocProviders,
            ],
            child: routerBuilder!,
          ),
        );
      },
    );
  }
}
