class PartyModel {
  final String id;
  final String name;

  PartyModel({required this.id, required this.name});

  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
      id: json["_id"],
      name: json["name"],
    );
  }
}