class GroupType {
  final int id;
  final String name;
  final String ownerId;

  GroupType({
    required this.id,
    required this.name,
    required this.ownerId,
  });

  factory GroupType.fromJson(Map<String, dynamic> json) {
    return GroupType(
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
