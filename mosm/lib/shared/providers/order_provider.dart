import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';

final orderProvider =
    StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier();
});

class OrderState {
  final List<dynamic> orders;
  final bool isLoading;

  OrderState({
    this.orders = const [],
    this.isLoading = false,
  });

  OrderState copyWith({
    List<dynamic>? orders,
    bool? isLoading,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState());

  final repo = OrderRepositoryImpl();
  final auth = AuthService();

  /// 📋 Fetch Orders
  Future<void> fetchOrders(String partyId) async {
    state = state.copyWith(isLoading: true);

    final token = await auth.getToken();
    final data = await repo.getOrders(token, partyId);

    state = state.copyWith(
      orders: data,
      isLoading: false,
    );
  }

  /// ➕ Create Order
  Future<void> createOrder(
      String partyId, List<String> medicines) async {
    state = state.copyWith(isLoading: true);

    final token = await auth.getToken();

    await repo.createOrder(token, partyId, medicines);

    state = state.copyWith(isLoading: false);
  }

  /// ✅ Mark Received
  Future<void> markReceived(String id, String partyId) async {
    final token = await auth.getToken();

    await repo.markReceived(token, id);

    await fetchOrders(partyId);
  }

  /// ❌ Mark Returned
  Future<void> markReturned(String id, String partyId) async {
    final token = await auth.getToken();

    await repo.markReturned(token, id);

    await fetchOrders(partyId);
  }
}