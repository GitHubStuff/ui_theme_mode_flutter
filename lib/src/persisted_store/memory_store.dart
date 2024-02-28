import 'on_device_store.dart';

class MemoryStore extends OnDeviceStore {
  final Map<dynamic, dynamic> _records = {};
  final String dbName;
  bool _isAvailable = true;

  MemoryStore({required this.dbName});

  @override
  Future<void> close() async {
    _checkAvailability();
    _isAvailable = false;
  }

  @override
  Future<void> deleteFromDisk() async {
    _checkAvailability();
    _records.clear();
    _isAvailable = false;
  }

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    _checkAvailability();
    return _records[key] ?? defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    _checkAvailability();
    _records[key] = value;
  }

  void _checkAvailability() {
    if (!_isAvailable) {
      throw const OnDeviceException(
          message: 'Operation attempted on an unavailable store');
    }
  }

  @override
  String toString() {
    return 'MemoryStore{dbName: $dbName, records: ${_records.length}, isAvailable: $_isAvailable}';
  }

  @override
  String get tag => dbName;

  @override
  bool get isUnavailable => !_isAvailable;
}
