# SETUP

- A fair bit of setup is required to install this. The example shows the most basic of setups. To used this modifications to main.dart, app_module.dart, and home_scaffold.dart are needed.

- Apps will need to include: flutter_bloc and flutter_modular.

This framework will allow for the ThemeMode (dark, light, or system) to be persisted and provide notification when ThemeMode changes, as well as if the them is dark or light based on the platform brightness.

## Features

Remember Theme/Brightness between starts of the app.

Redraws the widget tree when the Theme/Brightness is changed.

Allows setting the theme.

## Getting started

As noted above the, the /example directory show the changes and set-up needed.

The **main.dart**, the **app_module.dart** will need to modified.

*It is recommended to have **splash screen**, as flutter_hive can take a few frames to initialize. This is all done in the **/example**.*

### Installation

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  flutter_modular: ^6.3.2 # Smart project structure with dependency injection and route management
  ui_theme_mode_flutter
    git: https://github.com/GitHubStuff/ui_theme_mode_flutter.git
```

### Setup

This is **main.dart** template with details on how to enable theme mode management

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nosql_dart/nosql_dart.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

import 'screens/app_module.dart';

/// Part of NoSQL database store.
late final OnDeviceStore onDeviceStore;

/// The main function of the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  onDeviceStore = await BHiveDeviceStore.onDeviceSetUp();
  runApp(ModularApp(
    module: AppModule(),
    child: const MyApp(),
  ));
}

/// The main widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Build the widget tree for MyApp.
  @override
  Widget build(BuildContext context) {
    // Get the UIThemeModeCubit from the dependency injection container.
    UIThemeModeCubit cubit = Modular.get<UIThemeModeCubit>();

    // Use a BlocBuilder to rebuild the MaterialApp when the UIThemeModeState changes.
    return BlocBuilder<UIThemeModeCubit, UIThemeModeState>(
      bloc: cubit,
      builder: (context, state) {
        // set brightness by the cubit for access anywhere in the widget tree
        cubit.setBrightness(context);
        // Return a MaterialApp with a router.
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: cubit.state.themeMode,
          localizationsDelegates: const [],
          // Use a BlocProvider to provide the UIThemeModeCubit to the widget tree.
          builder: (context, routerBuilder) => BlocProvider.value(
            value: cubit,
            child: routerBuilder!,
          ),
        );
      },
    );
  }
}
```

## Usage

```dart
final cubit = context.read<UIThemeModeCubit>();

cubit.setToDarkMode();
cubit.setToLightMode();
cubit.setToSystemMode();
```

## Finally

Be kind to each other.
