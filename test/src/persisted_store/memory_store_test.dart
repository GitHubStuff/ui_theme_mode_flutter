import 'package:flutter_test/flutter_test.dart';
import 'package:nosql_dart/nosql_dart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Memory Store', () {
    test('init', () {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.isUnavailable, false);
      expect(memoryStore.dbName, 'test');
    });

    test('close', () {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.dbName, 'test');
      expect(memoryStore.isUnavailable, false);
      memoryStore.close();
      expect(memoryStore.isUnavailable, true);
    });
    test('double close', () async {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.dbName, 'test');
      expect(memoryStore.isUnavailable, false);
      await memoryStore.close();

      expect(memoryStore.close(), throwsA(isA<OnDeviceException>()));
    });

    test('deleteFromDisk', () {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.dbName, 'test');
      expect(memoryStore.isUnavailable, false);
      memoryStore.deleteFromDisk();
      expect(memoryStore.isUnavailable, true);
    });

    test('double deleteFromDisk', () async {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.dbName, 'test');
      expect(memoryStore.isUnavailable, false);
      await memoryStore.deleteFromDisk();
      expect(memoryStore.isUnavailable, true);
      expect(memoryStore.deleteFromDisk(), throwsA(isA<OnDeviceException>()));

      // expect(memoryStore.deleteFromDisk(),
      //     throwsA(isA<PersistedStoreException>()));
    });

    test('put/get', () async {
      final MemoryStore memoryStore = MemoryStore(dbName: 'test');
      expect(memoryStore.dbName, 'test');
      expect(memoryStore.isUnavailable, false);
      memoryStore.put('duck', 'quack');
      expect(memoryStore.get('duck'), 'quack');
      expect(memoryStore.get('pet', defaultValue: 'dog'), isNot('cat'));
    });
  });
}
