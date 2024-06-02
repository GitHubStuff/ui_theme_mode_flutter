part of 'thememode_setup.dart';

enum ModuleBindEnum {
  instance,
  lazySingleton,
  singleton,
}

class ModularBind<T> {
  final T module;
  final ModuleBindEnum bind;

  const ModularBind({
    required this.bind,
    required this.module,
  });

  factory ModularBind.instance({required String route, required T module}) =>
      ModularBind<T>(
        bind: ModuleBindEnum.instance,
        module: module,
      );
  factory ModularBind.lazySingleton(
          {required String route, required T module}) =>
      ModularBind<T>(
        bind: ModuleBindEnum.instance,
        module: module,
      );

  factory ModularBind.singleton({required String route, required T module}) =>
      ModularBind<T>(
        bind: ModuleBindEnum.singleton,
        module: module,
      );
}
