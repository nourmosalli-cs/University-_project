class Bill {
  final int id;
  final String name;
  final String? description;
  final double total;
  String? imageUrl;
  final int? categoryId;
  final bool isRepeated;
  final int? repeated;
  final String currency;
  final int? groupId;

  Bill({
    required this.id,
    required this.name,
    required this.description,
    required this.total,
    required this.imageUrl,
    required this.categoryId,
    required this.isRepeated,
    required this.repeated,
    required this.currency,
    required this.groupId,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      total: double.parse(json['total'].toString()),
      imageUrl: json["image_url"],
      categoryId: json['categoryId'],
      isRepeated: json['isRepeated'],
      repeated: json['repeated'],
      currency: json['currency'],
      groupId: json['groupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
