import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import 'on_device_store.dart';

const String _subDir = 'hive';
const String _boxName = 'com_icodeforyou_1e1e40en86g61m49ae0d12b26r373663';

enum BHiveStoreEnum {
  inMemory(true),
  onDevice(false);

  final bool isMemory;

  const BHiveStoreEnum(this.isMemory);
}

class BHiveDeviceStore extends OnDeviceStore {
  Directory? _tempDir;
  late final Box _box;
  late final BHiveStoreEnum _store;
  @override
  final String tag;

  BHiveDeviceStore._internal(
    this._box,
    this._store, {
    Directory? tempDir,
    required this.tag,
  }) : _tempDir = tempDir;

  static Future<BHiveDeviceStore> inMemorySetup({
    String hiveBox = _boxName,
  }) async {
    assert(hiveBox.isNotEmpty, 'hiveBox cannot be empty');
    Directory tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    Box box = await Hive.openBox<int>(hiveBox);
    return BHiveDeviceStore._internal(
      box,
      BHiveStoreEnum.inMemory,
      tempDir: tempDir,
      tag: tempDir.path.split('/').last,
    );
  }

  static Future<BHiveDeviceStore> onDeviceSetUp(
      {String? hiveDir, String hiveBox = _boxName}) async {
    await Hive.initFlutter(hiveDir ?? _subDir);
    Box box = await Hive.openBox<int>(hiveBox);
    return BHiveDeviceStore._internal(
      box,
      BHiveStoreEnum.onDevice,
      tag: hiveDir ?? _subDir,
    );
  }

  @override
  Future<void> close() async {
    if (_box.isOpen) {
      await _box.close();
      if (_store.isMemory) {
        _tempDir?.deleteSync(recursive: true);
        _tempDir = null;
      }
    }
  }

  @override
  Future<void> deleteFromDisk() async {
    if (!_store.isMemory && _box.isOpen) await _box.deleteFromDisk();
  }

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  @override
  Future<void> put(dynamic key, dynamic value) async =>
      await _box.put(key, value);

  @override
  String toString() =>
      'BHiveDeviceStore{box: $_box, dir: $_tempDir, store: $_store}';

  bool get unAvailable => _tempDir == null || !_box.isOpen;

  @override
  bool get isUnavailable => _tempDir == null || !_box.isOpen;
}
