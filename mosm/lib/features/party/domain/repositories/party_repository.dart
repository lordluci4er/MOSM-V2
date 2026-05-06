abstract class PartyRepository {
  Future<void> addParty(String name);
  Future<List<dynamic>> getParties();
}