// lib/data/models/provider_model.dart

class ProviderModel {
  final int id;
  final String name;
  final String? city;
  final String type;
  final String? image;
  final String? address;
  final String? phone;

  ProviderModel({
    required this.id,
    required this.name,
    this.city,
    required this.type,
    this.image,
    this.address,
    this.phone,
  });

  // ✅ هذا هو "المترجم" الذي يقرأ JSON القادم من PHP
  // الأسماء هنا ('provider_id', 'service_name') تطابق تماماً ما يرسله PHP
  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: int.parse(json['provider_id'].toString()),
      name: json['provider_name'] ?? 'اسم غير متوفر',
      city: json['city'],
      type: json['service_name'] ?? 'نوع غير محدد', // يقرأ اسم الخدمة
      image: json['provider_image'],
      address: json['location'],
      phone: json['provider_phone'],
    );
  }
}
