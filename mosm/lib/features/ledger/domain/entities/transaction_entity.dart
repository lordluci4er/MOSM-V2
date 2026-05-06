class TransactionEntity {
  final String id;
  final String type; // bill / payment
  final double amount;
  final String note;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.note,
  });
}