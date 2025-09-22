// // ملف: lib/app/modules/data_entry/controllers/data_entry_controller.dart

// // import 'dart:convert';
// import 'package:booking_app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';
// import '../../auth/controllers/auth_controller.dart';

// class PassengerModel {
//   int id;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passportController = TextEditingController();
//   RxString passportImagePath = ''.obs;
//   PassengerModel({required this.id});
// }

// class DataEntryController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   // --- الخصائص والمتغيرات الأصلية (تم الحفاظ عليها) ---
//   final AuthController authController = Get.find<AuthController>();

//   late String serviceType;
//   late String officeName;
//   late int serviceId;
//   late int providerId;

//   final RxBool isProcessing = false.obs; // تم تغيير الاسم ليكون أوضح
//   final RxBool showFlightDetails = false.obs;
//   final RxBool showHotelDetails = false.obs;
//   final RxBool showLandTransportDetails = false.obs;
//   final RxList<PassengerModel> passengers = <PassengerModel>[].obs;
//   final TextEditingController travelDateController = TextEditingController();
//   final TextEditingController travelTimeController = TextEditingController();
//   final TextEditingController checkInDateController = TextEditingController();
//   final TextEditingController checkOutDateController = TextEditingController();
//   final TextEditingController guestsCountController = TextEditingController(
//     text: '1',
//   );
//   final TextEditingController roomsCountController = TextEditingController(
//     text: '1',
//   );
//   final List<String> cities = [
//     'صنعاء',
//     'عدن',
//     'تعز',
//     'الحديدة',
//     'إب',
//     'ذمار',
//     'المكلا',
//     'سيئون',
//     'مأرب',
//     'الرياض',
//     'جدة',
//     'الدمام',
//   ];
//   final RxnString fromCity = RxnString();
//   final RxnString toCity = RxnString();
//   final RxnString hotelCity = RxnString();
//   final List<String> seatClasses = [
//     'الدرجة السياحية',
//     'درجة رجال الأعمال',
//     'الدرجة الأولى',
//   ];
//   final RxString selectedSeatClass = 'الدرجة السياحية'.obs;
//   final List<String> vehicleTypes = ['حافلة عادية', 'حافلة VIP', 'سيارة خاصة'];
//   final RxString selectedVehicleType = 'حافلة عادية'.obs;
//   final List<String> roomTypes = ['غرفة عادية', 'غرفة VIP', 'جناح فندقي'];
//   final RxString selectedRoomType = 'غرفة عادية'.obs;

//   // --- منطقة التسعير الديناميكي ---
//   static const Map<String, double> umrahAndHajjPrices = {
//     'تأشيرة عمرة': 1200.0,
//     'تأشيرة حج': 1200.0,
//   };
//   static const Map<String, double> flightPrices = {
//     'الدرجة السياحية': 1000.0,
//     'درجة رجال الأعمال': 1500.0,
//     'الدرجة الأولى': 2000.0,
//   };
//   static const Map<String, double> transportPrices = {
//     'حافلة عادية': 200.0,
//     'حافلة VIP': 500.0,
//     'سيارة خاصة': 700.0,
//   };
//   static const Map<String, double> hotelPrices = {
//     'غرفة عادية': 50.0,
//     'غرفة VIP': 150.0,
//     'جناح فندقي': 250.0,
//   };
//   final RxDouble totalAmount = 0.0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final arguments = Get.arguments as Map<String, dynamic>;
//     serviceType = arguments['service_type'] ?? 'غير معروف';
//     officeName = arguments['office_name'] ?? 'تفاصيل الحجز';
//     serviceId = arguments['service_id'] ?? 0;
//     providerId = arguments['provider_id'] ?? 0;

//     if (serviceType == 'حجز طيران') {
//       showFlightDetails.value = true;
//     } else if (serviceType == 'حجز فنادق')
//       showHotelDetails.value = true;
//     else if (serviceType == 'نقل بري')
//       showLandTransportDetails.value = true;

//     addPassenger();

//     ever(passengers, (_) => calculateTotalAmount());
//     ever(selectedSeatClass, (_) => calculateTotalAmount());
//     ever(selectedVehicleType, (_) => calculateTotalAmount());
//     ever(selectedRoomType, (_) => calculateTotalAmount());

//     roomsCountController.addListener(calculateTotalAmount);
//     checkInDateController.addListener(calculateTotalAmount);
//     checkOutDateController.addListener(calculateTotalAmount);

//     calculateTotalAmount();
//   }

//   void calculateTotalAmount() {
//     double calculatedAmount = 0.0;
//     switch (serviceType) {
//       case 'حجز طيران':
//         calculatedAmount =
//             (flightPrices[selectedSeatClass.value] ?? 0.0) * passengers.length;
//         break;
//       case 'تأشيرة عمرة':
//       case 'تأشيرة حج':
//         calculatedAmount =
//             (umrahAndHajjPrices[serviceType] ?? 0.0) * passengers.length;
//         break;
//       case 'نقل بري':
//         calculatedAmount = transportPrices[selectedVehicleType.value] ?? 0.0;
//         break;
//       case 'حجز فنادق':
//         int rooms = int.tryParse(roomsCountController.text) ?? 1;
//         int days = _calculateDays();
//         calculatedAmount =
//             (hotelPrices[selectedRoomType.value] ?? 0.0) * rooms * days;
//         break;
//       default:
//         calculatedAmount = 0.0;
//     }
//     totalAmount.value = calculatedAmount;
//   }

//   int _calculateDays() {
//     try {
//       if (checkInDateController.text.isEmpty ||
//           checkOutDateController.text.isEmpty) {
//         return 1;
//       }
//       final format = DateFormat("yyyy-MM-dd");
//       final difference = format
//           .parse(checkOutDateController.text)
//           .difference(format.parse(checkInDateController.text))
//           .inDays;
//       return difference > 0 ? difference : 1;
//     } catch (e) {
//       return 1;
//     }
//   }

//   void addPassenger() => passengers.add(PassengerModel(id: passengers.length));
//   void removePassenger(PassengerModel p) {
//     if (passengers.length > 1) passengers.remove(p);
//   }

//   Future<void> pickImage(int passengerId) async {
//     final XFile? image = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (image != null) {
//       passengers
//               .firstWhere((p) => p.id == passengerId)
//               .passportImagePath
//               .value =
//           image.path;
//     }
//   }

//   // --- ✅✅✅ الدالة الصحيحة والنهائية للانتقال إلى الدفع ✅✅✅ ---
//   void goToPayment() {
//     // يمكنك إضافة التحقق من الحقول هنا قبل الانتقال
//     // if (formKey.currentState!.validate()) { ... }

//  final isFormValid = formKey.currentState!.validate();
//   if (!isFormValid) {
//     return; // إذا كانت البيانات غير صالحة، لا تكمل العملية
//   }

//   // 2. التحقق من رفع صورة الجواز لكل مسافر
//   for (var p in passengers) {
//     if (p.passportImagePath.value.isEmpty) {
//       // إظهار رسالة خطأ للمستخدم
//       Get.snackbar(
//         'خطأ في الإدخال',
//         'الرجاء رفع صورة جواز السفر للمسافر: ${p.nameController.text}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return; // لا تكمل العملية
//     }
//   }

//   // إذا كانت كل البيانات سليمة، استمر في عملية الانتقال للدفع
//   isProcessing.value = true;
//     // تمرير كل البيانات اللازمة لإنشاء الحجز والدفع في خطوة واحدة
//     Get.toNamed(
//       AppRoutes.PAYMENT,
//       arguments: {
//         // بيانات لـ process_payment.php
//         'user_id': authController.currentUser.value?.id ?? 0,
//         'service_id': serviceId,
//         'service_name': serviceType,
//         'passengers_count': passengers.length,
//         'passengers_names': passengers
//             .map((p) => p.nameController.text)
//             .where((name) => name.isNotEmpty)
//             .toList(),
//         'total_amount': totalAmount.value, // السعر الديناميكي
//         // بيانات تحتاجها شاشة الدفع نفسها
//         'provider_id': providerId, // لجلب حساب الشركة
//       },
//     );

//     isProcessing.value = false;
//   }

//   @override
//   void onClose() {
//     roomsCountController.removeListener(calculateTotalAmount);
//     checkInDateController.removeListener(calculateTotalAmount);
//     checkOutDateController.removeListener(calculateTotalAmount);
//     for (var p in passengers) {
//       p.nameController.dispose();
//       p.passportController.dispose();
//     }
//     travelDateController.dispose();
//     travelTimeController.dispose();
//     checkInDateController.dispose();
//     checkOutDateController.dispose();
//     guestsCountController.dispose();
//     roomsCountController.dispose();
//     super.onClose();
//   }
// }
// ملف: lib/app/modules/data_entry/controllers/data_entry_controller.dart (النسخة النهائية المصححة)

import 'package:booking_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../auth/controllers/auth_controller.dart';

class PassengerModel {
  int id;
  TextEditingController nameController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  RxString passportImagePath = ''.obs;
  PassengerModel({required this.id});
}

class DataEntryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  late String serviceType;
  late String officeName;
  late int serviceId;
  late int providerId;

  final RxBool isProcessing = false.obs;
  final RxBool showFlightDetails = false.obs;
  final RxBool showHotelDetails = false.obs;
  final RxBool showLandTransportDetails = false.obs;
  final RxList<PassengerModel> passengers = <PassengerModel>[].obs;
  final TextEditingController travelDateController = TextEditingController();
  final TextEditingController travelTimeController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();
  final TextEditingController guestsCountController =
      TextEditingController(text: '1');
  final TextEditingController roomsCountController =
      TextEditingController(text: '1');
  final List<String> cities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'إب',
    'ذمار',
    'المكلا',
    'سيئون',
    'مأرب',
    'الرياض',
    'جدة',
    'الدمام',
  ];
  final RxnString fromCity = RxnString();
  final RxnString toCity = RxnString();
  final RxnString hotelCity = RxnString();
  final List<String> seatClasses = [
    'الدرجة السياحية',
    'درجة رجال الأعمال',
    'الدرجة الأولى'
  ];
  final RxString selectedSeatClass = 'الدرجة السياحية'.obs;
  final List<String> vehicleTypes = ['حافلة عادية', 'حافلة VIP', 'سيارة خاصة'];
  final RxString selectedVehicleType = 'حافلة عادية'.obs;
  final List<String> roomTypes = ['غرفة عادية', 'غرفة VIP', 'جناح فندقي'];
  final RxString selectedRoomType = 'غرفة عادية'.obs;

  static const Map<String, double> umrahAndHajjPrices = {
    'تأشيرة عمرة': 1200.0,
    'تأشيرة حج': 1200.0
  };
  static const Map<String, double> flightPrices = {
    'الدرجة السياحية': 1000.0,
    'درجة رجال الأعمال': 1500.0,
    'الدرجة الأولى': 2000.0
  };
  static const Map<String, double> transportPrices = {
    'حافلة عادية': 200.0,
    'حافلة VIP': 500.0,
    'سيارة خاصة': 700.0
  };
  static const Map<String, double> hotelPrices = {
    'غرفة عادية': 50.0,
    'غرفة VIP': 150.0,
    'جناح فندقي': 250.0
  };
  final RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    serviceType = arguments['service_type'] ?? 'غير معروف';
    officeName = arguments['office_name'] ?? 'تفاصيل الحجز';
    serviceId = arguments['service_id'] ?? 0;
    providerId = arguments['provider_id'] ?? 0;

    if (serviceType == 'حجز طيران')
      showFlightDetails.value = true;
    else if (serviceType == 'حجز فنادق')
      showHotelDetails.value = true;
    else if (serviceType == 'نقل بري') showLandTransportDetails.value = true;

    addPassenger();

    ever(passengers, (_) => calculateTotalAmount());
    ever(selectedSeatClass, (_) => calculateTotalAmount());
    ever(selectedVehicleType, (_) => calculateTotalAmount());
    ever(selectedRoomType, (_) => calculateTotalAmount());

    roomsCountController.addListener(calculateTotalAmount);
    checkInDateController.addListener(calculateTotalAmount);
    checkOutDateController.addListener(calculateTotalAmount);

    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double calculatedAmount = 0.0;
    switch (serviceType) {
      case 'حجز طيران':
        calculatedAmount =
            (flightPrices[selectedSeatClass.value] ?? 0.0) * passengers.length;
        break;
      case 'تأشيرة عمرة':
      case 'تأشيرة حج':
        calculatedAmount =
            (umrahAndHajjPrices[serviceType] ?? 0.0) * passengers.length;
        break;
      case 'نقل بري':
        calculatedAmount = transportPrices[selectedVehicleType.value] ?? 0.0;
        break;
      case 'حجز فنادق':
        int rooms = int.tryParse(roomsCountController.text) ?? 1;
        int days = _calculateDays();
        calculatedAmount =
            (hotelPrices[selectedRoomType.value] ?? 0.0) * rooms * days;
        break;
      default:
        calculatedAmount = 0.0;
    }
    totalAmount.value = calculatedAmount;
  }

  int _calculateDays() {
    try {
      if (checkInDateController.text.isEmpty ||
          checkOutDateController.text.isEmpty) return 1;
      final format = DateFormat("yyyy-MM-dd");
      final difference = format
          .parse(checkOutDateController.text)
          .difference(format.parse(checkInDateController.text))
          .inDays;
      return difference > 0 ? difference : 1;
    } catch (e) {
      return 1;
    }
  }

  void addPassenger() => passengers.add(PassengerModel(id: passengers.length));
  void removePassenger(PassengerModel p) {
    if (passengers.length > 1) passengers.remove(p);
  }

  Future<void> pickImage(int passengerId) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      passengers
          .firstWhere((p) => p.id == passengerId)
          .passportImagePath
          .value = image.path;
    }
  }

  // --- ✅✅✅ الدالة النهائية والمصححة للانتقال إلى الدفع ✅✅✅ ---
  void goToPayment() {
    // 1. التحقق من جميع الحقول النصية والمنسدلة عبر الـ Form
    final isFormValid = formKey.currentState!.validate();
    if (!isFormValid) {
      return; // إذا كانت البيانات غير صالحة، لا تكمل العملية
    }

    // 2. التحقق من رفع صورة الجواز لكل مسافر
    for (var p in passengers) {
      if (p.passportImagePath.value.isEmpty) {
        Get.snackbar(
          'خطأ في الإدخال',
          'الرجاء رفع صورة جواز السفر للمسافر: ${p.nameController.text}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return; // لا تكمل العملية
      }
    }

    // إذا كانت كل البيانات سليمة، استمر في عملية الانتقال للدفع
    isProcessing.value = true;

    Get.toNamed(
      AppRoutes.PAYMENT,
      arguments: {
        'user_id': authController.currentUser.value?.id ?? 0,
        'service_id': serviceId,
        'service_name': serviceType,
        'passengers_count': passengers.length,
        'passengers_names': passengers
            .map((p) => p.nameController.text)
            .where((name) => name.isNotEmpty)
            .toList(),
        'total_amount': totalAmount.value,
        'provider_id': providerId,
      },
    );

    // من الأفضل تأخير هذا قليلاً أو وضعه في onReady لشاشة الدفع
    // لكن حالياً سنبقيه كما هو
    isProcessing.value = false;
  }

  @override
  void onClose() {
    roomsCountController.removeListener(calculateTotalAmount);
    checkInDateController.removeListener(calculateTotalAmount);
    checkOutDateController.removeListener(calculateTotalAmount);
    for (var p in passengers) {
      p.nameController.dispose();
      p.passportController.dispose();
    }
    travelDateController.dispose();
    travelTimeController.dispose();
    checkInDateController.dispose();
    checkOutDateController.dispose();
    guestsCountController.dispose();
    roomsCountController.dispose();
    super.onClose();
  }
}
