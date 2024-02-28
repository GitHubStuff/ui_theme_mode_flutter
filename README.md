# SETUP

- A fair bit of setup is required to install this. The example shows the most basic of setups. To used this modifications to main.dart, app_module.dart, and home_scaffold.dart are needed.

- Apps will need to include: flutter_bloc and flutter_modular.

<!--
The comments below are from the Flutter/Dart package generation. Feel free to use or ignore
-->

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This framework will allow for the ThemeMode (dark, light, or system) to be persisted and provide notification when ThemeMode changes, as well as if the them is dark or light based on the platform brightness.

## Features

Remember Theme between starts of the app.

Redraws the widget tree when the theme is changed.

Allows setting the theme.

## Getting started

As noted above the, the /example directory show the changes and set-up needed.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
final cubit = context.read<UIThemeModeCubit>();

cubit.setToDarkMode();
cubit.setToLightMode();
cubit.setToSystemMode();
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
