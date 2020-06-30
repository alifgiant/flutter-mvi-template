abstract class BaseRepository<T> {
  Future<List<T>> getAll();

  Future<T> getByKey(dynamic key);

  Future<bool> deleteByKey(dynamic key);

  Future<bool> deleteAll();

  Future<T> edit(T instance);

  Future<T> add(T instance);
}
