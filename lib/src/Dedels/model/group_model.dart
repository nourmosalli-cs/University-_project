import 'package:expenses_graduation_project/src/Dedels/model/group_types_model.dart';

class Group {
  final int id;
  final String name;
  String? imageUrl;
  final int? typeId;
  final String ownerId;
  final GroupType? groupType;

  Group({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.typeId,
    required this.ownerId,
    required this.groupType,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      imageUrl: json["image_url"],
      typeId: json['type_id'],
      ownerId: json['owner_id'],
      groupType: json["group_types"] != null
          ? GroupType.fromJson(json["group_types"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
