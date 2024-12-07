class Friends {
  final int id;
  final String? name;
  final String? email;
  final String? userId;
  final String? ownerId;
  final String? phone;

  Friends({
    required this.id,
    required this.name,
    this.email,
    this.userId,
    required this.ownerId,
    required this.phone,
  });

  factory Friends.fromJson(Map<String, dynamic> json) {
    return Friends(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userId: json['user_id'],
      ownerId: json['owner_id'],
      phone: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type_id': userId,
      'owner_id': ownerId,
      'phone': phone,
    };
  }
}
