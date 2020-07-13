import 'package:aset_ku/core/repository/result.dart';

abstract class BaseRepository<T> {
  Future<Result<List<T>>> getAll();

  Future<Result<T>> getByKey(dynamic key);

  Future<Result<bool>> deleteByKey(dynamic key);

  Future<Result<bool>> deleteAll();

  Future<Result<T>> edit(T instance);

  Future<Result<T>> add(T instance);
}
