// lib/data/models/user_model.dart
class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? 0,
      name: json['full_name'] ?? 'اسم غير متوفر',
      email: json['email'] ?? '',
    );
  }
}
