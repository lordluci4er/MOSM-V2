class MedicineModel {
  final String id;
  final String name;

  MedicineModel({required this.id, required this.name});

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json["_id"],
      name: json["name"],
    );
  }
}