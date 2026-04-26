/// Interface for cache storage
abstract class ICacheStorage {
  /// Insert or Update if the id exists to cache
  Future<void> upsert<T>({required String key, required T data});

  /// Read data from cache
  Future<T?> read<T>({required String key});

  /// Delete data from cache
  Future<bool> delete({required String key});
}
