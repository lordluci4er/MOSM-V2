abstract class InboxRepository {
  Future<void> addMedicine(String name);
  Future<List<dynamic>> getMedicines();
}