import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class UmrahHajjVisaController extends GetxController {
  final _selectedService = ''.obs;
  
  String get selectedService => _selectedService.value;
  
  // Sample offices data
  final List<Map<String, dynamic>> offices = [
    {
      'id': '1',
      'name': 'مكتب الحرمين للعمرة والحج',
      'image': 'assets/images/office1.jpg',
      'rating': 4.8,
      'reviews': 150,
      'description': 'مكتب متخصص في خدمات العمرة والحج مع خبرة أكثر من 20 عاماً',
      'services': ['عمرة', 'حج', 'تأشيرات'],
      'price': 2500.0,
    },
    {
      'id': '2',
      'name': 'مؤسسة الأنوار للحج والعمرة',
      'image': 'assets/images/office2.jpg',
      'rating': 4.6,
      'reviews': 120,
      'description': 'نقدم أفضل الخدمات للحجاج والمعتمرين بأسعار تنافسية',
      'services': ['عمرة', 'حج'],
      'price': 2200.0,
    },
    {
      'id': '3',
      'name': 'شركة البركة للسياحة الدينية',
      'image': 'assets/images/office3.jpg',
      'rating': 4.9,
      'reviews': 200,
      'description': 'رحلات مميزة للحج والعمرة مع أفضل الخدمات والإقامة',
      'services': ['عمرة', 'حج', 'زيارات دينية'],
      'price': 2800.0,
    },
    {
      'id': '4',
      'name': 'مكتب الهدى للحج والعمرة',
      'image': 'assets/images/office4.jpg',
      'rating': 4.5,
      'reviews': 95,
      'description': 'خدمات شاملة للحج والعمرة مع مرشدين متخصصين',
      'services': ['عمرة', 'حج'],
      'price': 2100.0,
    },
    {
      'id': '5',
      'name': 'مؤسسة النور للسفر والسياحة',
      'image': 'assets/images/office5.jpg',
      'rating': 4.7,
      'reviews': 180,
      'description': 'تنظيم رحلات الحج والعمرة بأعلى معايير الجودة والراحة',
      'services': ['عمرة', 'حج', 'تأشيرات', 'حجز فنادق'],
      'price': 2600.0,
    },
  ];
  
  void selectService(String service) {
    _selectedService.value = service;
    Get.toNamed(AppRoutes.UMRAH_HAJJ_OFFICES, arguments: {'service': service});
  }
  
  void selectOffice(Map<String, dynamic> office) {
    Get.toNamed(AppRoutes.UMRAH_HAJJ_DETAILS, arguments: {
      'office': office,
      'service': _selectedService.value,
    });
  }
}

