class OrderModel {
  final String id;
  final String medicineName;
  final String status;

  OrderModel({
    required this.id,
    required this.medicineName,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"],
      medicineName: json["medicineName"],
      status: json["status"],
    );
  }
}