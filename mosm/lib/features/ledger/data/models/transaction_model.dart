class TransactionModel {
  final String id;
  final String type;
  final double amount;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["_id"],
      type: json["type"],
      amount: (json["amount"] as num).toDouble(),
    );
  }
}