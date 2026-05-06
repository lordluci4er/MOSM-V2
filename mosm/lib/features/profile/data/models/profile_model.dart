class ProfileModel {
  final String shopName;
  final String phone;
  final String address;

  ProfileModel({
    required this.shopName,
    required this.phone,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      shopName: json["shopName"],
      phone: json["phone"],
      address: json["address"],
    );
  }
}