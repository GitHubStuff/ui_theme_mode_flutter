import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('⛳️ example001', () async {
    debugPrint('Starting 001');
    final experimental = Experimental();
    final result = experimental.exampleAsync();
    await Future.delayed(const Duration(seconds: 2)); //CAREFUL
    expect(result, isA<Future<int>>());
    debugPrint('🏁 Finish 001');
  });
  test('example002', () {
    final experimental = Experimental();
    final result = experimental.exampleNotAsync();
    Future.delayed(const Duration(seconds: 2));
    expect(result, 1);
  });
  test('example003', () async {
    final experimental = Experimental();
    final result = await experimental.exampleAsync();
    await Future.delayed(const Duration(seconds: 2));
    expect(result, 1);
  });
}

class Experimental {
  FutureOr<int> exampleAsync() async {
    await pause(const Duration(seconds: 1));
    await pause(const Duration(milliseconds: 500));
    return Future.value(1);
  }

  FutureOr<int> exampleNotAsync() {
    pause(const Duration(seconds: 1));
    return 1;
  }

  FutureOr<void> pause(Duration duration) async {
    // debugPrint('🛑pausing for $duration - ${DateTime.now().toLocal()}');
    // await Future.delayed(duration);
    // debugPrint('✅ paused for $duration - ${DateTime.now().toLocal()}');
  }
}
