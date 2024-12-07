class BillCategory {
  final int id;
  final String name;
  final String ownerId;

  BillCategory({
    required this.id,
    required this.name,
    required this.ownerId,
  });

  factory BillCategory.fromJson(Map<String, dynamic> json) {
    return BillCategory(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      ownerId: json['owner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
