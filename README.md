# UIThemeMode

This package (with some mods to how ```main.dart``` is used), allows an app to listen {via [flutter_bloc](https://pub.dev/packages/flutter_bloc)} and change dark/light/system theme mode. The setting is persisted across app launch, using a NoSQL database, to persist the theme setting across app launches.

## SETUP

The ```main.dart```, at minium should look like:

```dart
import 'package:flutter/material.dart';
import 'package:ui_theme_mode_flutter/ui_theme_mode_flutter.dart';

import 'screens/home_scaffold.dart';

/// The main function of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(const ThemeModeSetup(initialScreen: HomeScaffold()));
}
```

where ```HomeScaffold``` is the first screen (after the splash ) to display.

There are several parameters for ```ThemeModeSetup```

- ```Widget initialScreen``` - *required* First screen displayed after SplashScreen
- ```Widget splashWidget``` - Content of the splash screen (default ```Box.zero()```)
- ```Duration splashScreenDuration``` - How long to display SplashScreen (default ```Duration.zero```)
- ```ThemeData? darkTheme``` - Dark Theme (default: ```ThemeData.dark()```)
- ```ThemeData? lightTheme``` - Light Theme (default: ```ThemeData.light()```)
- ```Iterable<ThemeExtension<dynamic>> themeExtensions``` - Custom Theme Extensions (default: ```[]```)
- ```List<BlocProvider> blocProviders``` - Used with [flutter_bloc](https://pub.dev/packages/flutter_bloc) to add providers available to the entire widget tree/app.

## Features

Remember Theme/Brightness between starts of the app. {Persisted using NoSQL store}

Redraws the widget tree when the Theme/Brightness is changed.

Allows setting the theme.

## Getting started

As noted above the, the /example directory show the changes and set-up needed.

The **main.dart**, the **app_module.dart** will need to modified.

*It is recommended to have **splash screen**, as NoSql-store can take a few frames to initialize. This is all done in the **/example**.*

### Installation

```yaml
dependencies:
  flutter_bloc: ^8.1.3 # Required to listen/make changes to theme
  flutter_modular: ^6.3.2 # Smart project structure with dependency injection and route management
  ui_theme_mode_flutter
    git: https://github.com/GitHubStuff/ui_theme_mode_flutter.git
```

### Usage

```dart
final cubit = context.read<UIThemeModeCubit>();

cubit.setToDarkMode();
cubit.setToLightMode();
cubit.setToSystemMode();
```

### Examples

The **```/example```** app shows how to use the package.

## Finally

Be kind to each other!
