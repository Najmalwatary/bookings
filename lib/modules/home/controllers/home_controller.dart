import 'package:get/get.dart';
import 'package:flutter/material.dart'; // سنحتاج هذا للـ PageController
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  // --- بداية التغييرات ---
  // تم استبدال CarouselController بـ PageController الرسمي من فلاتر
  final PageController pageController = PageController();

  final _currentCarouselIndex = 0.obs;
  int get currentCarouselIndex => _currentCarouselIndex.value;

  // هذه الدالة ستقوم بتحديث رقم الصفحة الحالية
  void onPageChanged(int index) {
    _currentCarouselIndex.value = index;
  }
  // --- نهاية التغييرات ---

  final List<String> carouselImages = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];
  // ✅✅✅ القائمة النهائية والمصححة ✅✅✅
  final List<Map<String, dynamic>> services = [
    {
      'id': 1, // ✅ إضافة ID لكل خدمة
      'title': 'flight_booking',
      'description': 'book_flight_tickets_best_price',
      'icon': 'flight_takeoff',
      'route': AppRoutes.providers,
      "service_type": "حجز طيران",
    },
    {
      'id': 5, // ✅ إضافة ID لكل خدمة
      'title': 'land_transport',
      'description': 'land_visa_best_agencies',
      'icon': 'directions_bus',
      'route': AppRoutes.providers,
      "service_type": "نقل بري",
    },
    {
      'id': 2, // ✅ إضافة ID لكل خدمة
      'title': 'hotel_booking',
      'description': 'hotel_visa_best_agencies',
      'icon': 'hotel',
      'route': AppRoutes.providers,
      "service_type": "حجز فنادق",
    },
    {
      'id': 3, // ✅ إضافة ID لكل خدمة
      'title': 'umrah_visa',
      'description': 'umrah_visa_best_agencies',
      'icon': 'mosque',
      'route': AppRoutes.providers,
      "service_type": "تأشيرة عمرة",
    },
    {
      'id': 4, // ✅ إضافة ID لكل خدمة
      'title': 'hajj_visa',
      'description': 'hajj_visa_best_agencies',
      'icon': 'mosque',
      'route': AppRoutes.providers,
      "service_type": "تأشيرة حج",
    },
  ];

  void navigateToService(Map<String, dynamic> service) {
    // final String route = service['route'];
    // final String serviceTypeInArabic = service['service_type'];

    Get.toNamed(service['route'], arguments: service);
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.SETTINGS);
  }

  void logout() {
    Get.offAllNamed(AppRoutes.LOGIN);
    Get.snackbar(
      'تسجيل الخروج',
      'تم تسجيل الخروج بنجاح',
      snackPosition: SnackPosition.TOP,
    );
  }

  // لا تنسَ التخلص من الـ controller عند إغلاق الصفحة
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
