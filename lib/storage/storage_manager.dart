import 'package:flutter/foundation.dart';
import 'package:recipes/objectbox.g.dart';

/// This service handles local storage CRUD operations with ObjectBox.
/// The service uses ObjectBox [Store] and generic [Box<T>] operations.
///
/// Notes / assumptions:
/// - You must run the objectbox code generator (build_runner) so
///   `lib/objectbox.g.dart` is available. Typical command:
///     flutter pub run build_runner build --delete-conflicting-outputs
/// - ObjectBox uses integer IDs. The public API here accepts string ids
///   (keeps original signature) and will attempt to parse them to int.
class StorageManager {

  late final Store _store;
  bool _initialized = false;

  /// Initialize the ObjectBox store. Safe to call multiple times.
  Future<void> init([String? path]) async {
    if (_initialized) return;
    _store = await openStore(directory: path);
    _initialized = true;

    if (kDebugMode) {
      print('✅ StorageService initialized with ObjectBox!');
      print('🚧 $path');
      print('--------------------');
    }

  }

  /// Close the store when no longer needed.
  void close() {
    if (!_initialized) return;
    _store.close();
    _initialized = false;
  }

  Box<T> _boxFor<T>() {
    if (!_initialized) {
      throw StateError('❓ StorageService not initialized. Call init() first.');
    }
    return _store.box<T>();
  }

  /// Create (insert) an entity. Returns true on success.
  Future<bool> create<T>(T data) async {
    try {
      final box = _boxFor<T>();
      // put returns the id (int). We don't need it here.
      box.put(data);
      return true;
    } catch (e) {
      // optionally log the error
      return false;
    }
  }

  /// Read all objects of type T.
  Future<List<T>> readAll<T>() async {
    try {
      final box = _boxFor<T>();
      return box.getAll();
    } catch (e) {
      return <T>[];
    }
  }


  Stream<List<T>> getAllStreamData<T>() {
    try {
      final box = _boxFor<T>();
      return box
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find());

    } catch (e) {
      return const Stream.empty();
    }
  }

  /// Read a single object by its string id (parsed as int).
  Future<T?> read<T>(String id) async {
    try {
      final intId = int.tryParse(id);
      if (intId == null) return null;
      final box = _boxFor<T>();
      return box.get(intId);
    } catch (e) {
      return null;
    }
  }

  /// Update an entity. For ObjectBox this is the same as put().
  Future<bool> update<T>(T data) async {
    try {
      final box = _boxFor<T>();
      box.put(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Delete an entity by its string id (parsed as int).
  Future<bool> delete<T>(int id) async {
    try {
      final box = _boxFor<T>();
      return box.remove(id);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
