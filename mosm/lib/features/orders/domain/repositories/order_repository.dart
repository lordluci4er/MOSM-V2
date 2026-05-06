abstract class OrderRepository {
  Future<void> createOrder(String partyId, List<String> medicines);
}