class UserModel {
  final String id;
  final String shopName;

  UserModel({required this.id, required this.shopName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      shopName: json["shopName"],
    );
  }
}