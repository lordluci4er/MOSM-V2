abstract class LedgerRepository {
  Future<void> addBill(String partyId, double amount);
  Future<void> addPayment(String partyId, double amount);
}