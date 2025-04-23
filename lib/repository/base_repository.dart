abstract class BaseRepository<T> {
  Future<T> add(T item);
  Future<List<T>> getAll();
  Future<void> remove(String id);
  Future<void> update(T item);
}
