import 'package:flutter/foundation.dart';

// Global variable to control stack trace logging, consider encapsulating this within a more appropriate configuration class if applicable.
bool doStackTrace = false;

/// An exception thrown when the PersistedStore is unavailable.
@immutable
class OnDeviceException implements Exception {
  final String message;
  const OnDeviceException({this.message = 'PersistedStore is not available.'});

  @override
  String toString() => 'OnDeviceException: $message';
}

/// Defines the contract for a persisted storage solution.
/// This abstract class outlines the methods that any implementing persisted store must provide.
abstract class OnDeviceStore {
  /// Indicates whether the store is currently unavailable.
  bool get isUnavailable;

  /// Retrieves a value from the store using a [key]. If the key does not exist, [defaultValue] is returned.
  dynamic get(dynamic key, {dynamic defaultValue});

  /// Closes the store and releases any resources associated with it.
  Future<void> close();

  /// Deletes the store from disk, removing all persisted data.
  Future<void> deleteFromDisk();

  /// Inserts or updates a [value] in the store associated with [key].
  Future<void> put(dynamic key, dynamic value);

  /// A unique identifier for the store instance.
  String get tag;
}
