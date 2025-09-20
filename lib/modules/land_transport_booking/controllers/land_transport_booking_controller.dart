import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class LandTransportBookingController extends GetxController {
  // final fromController = TextEditingController();
  // final toController = TextEditingController();
  final fromController = Rx<String?>(null);
  final toController = Rx<String?>(null);
  final departureDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final passengersController = TextEditingController();

  final _numberOfPassengers = 1.obs;
  final _isRoundTrip = false.obs;
  final _selectedTransport = Rxn<Map<String, dynamic>>();

  int get numberOfPassengers => _numberOfPassengers.value;
  bool get isRoundTrip => _isRoundTrip.value;
  Map<String, dynamic>? get selectedTransport => _selectedTransport.value;

  final formKey = GlobalKey<FormState>();

  // Sample transport options
  final List<Map<String, dynamic>> transportOptions = [
    {
      'id': '1',
      'company': 'شركة سابتكو',
      'type': 'حافلة فاخرة',
      'image': 'assets/images/bus1.jpg',
      'rating': 4.5,
      'reviews': 120,
      'description': 'حافلات مكيفة ومريحة مع خدمة ممتازة',
      'amenities': ['مكيف', 'واي فاي', 'مقاعد مريحة', 'وجبات خفيفة'],
      'price': 150.0,
      'duration': '4 ساعات',
    },
    {
      'id': '2',
      'company': 'شركة النقل الحديث',
      'type': 'حافلة VIP',
      'image': 'assets/images/bus2.jpg',
      'rating': 4.7,
      'reviews': 95,
      'description': 'حافلات VIP مع مقاعد قابلة للإمالة',
      'amenities': ['مكيف', 'واي فاي', 'مقاعد VIP', 'شاشات ترفيه'],
      'price': 200.0,
      'duration': '3.5 ساعات',
    },
    {
      'id': '3',
      'company': 'شركة الخليج للنقل',
      'type': 'ميني باص',
      'image': 'assets/images/minibus.jpg',
      'rating': 4.3,
      'reviews': 80,
      'description': 'ميني باص مريح للمجموعات الصغيرة',
      'amenities': ['مكيف', 'مقاعد مريحة', 'مساحة للأمتعة'],
      'price': 120.0,
      'duration': '4.5 ساعات',
    },
  ];

  // Sample cities
  final List<String> cities = [
    'الرياض',
    'جدة',
    'مكة المكرمة',
    'المدينة المنورة',
    'الدمام',
    'الخبر',
    'الطائف',
    'أبها',
    'تبوك',
    'حائل',
  ];

  @override
  void onInit() {
    super.onInit();
    passengersController.text = _numberOfPassengers.value.toString();
  }

  @override
  void onClose() {
    departureDateController.dispose();
    returnDateController.dispose();
    passengersController.dispose();
    super.onClose();
  }

  void increasePassengers() {
    if (_numberOfPassengers.value < 20) {
      _numberOfPassengers.value++;
      passengersController.text = _numberOfPassengers.value.toString();
    }
  }

  void decreasePassengers() {
    if (_numberOfPassengers.value > 1) {
      _numberOfPassengers.value--;
      passengersController.text = _numberOfPassengers.value.toString();
    }
  }

  void toggleRoundTrip(bool value) {
    _isRoundTrip.value = value;
    if (!value) {
      returnDateController.clear();
    }
  }

  void selectDepartureDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      departureDateController.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void selectReturnDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      returnDateController.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void selectFromCity(String? city) {
    if (city != null) {
      fromController.value = city;
    }
  }

  void selectToCity(String? city) {
    if (city != null) {
      toController.value = city;
    }
  }

  void selectTransport(Map<String, dynamic> transport) {
    _selectedTransport.value = transport;
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    return null;
  }

  void proceedToPayment() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_selectedTransport.value == null) {
      Get.snackbar(
        'خطأ',
        'يرجى اختيار وسيلة النقل',
        backgroundColor: Colors.red,
        colorText: const Color.fromARGB(255, 126, 197, 238),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Calculate total amount
    double totalAmount = _calculateTotalAmount();

    // Collect booking data
    Map<String, String> bookingData = {
      'from': fromController.value ?? "",
      'to': toController.value ?? '',
      'departureDate': departureDateController.text,
      'returnDate': returnDateController.text,
      'passengers': _numberOfPassengers.value.toString(),
      'isRoundTrip': _isRoundTrip.value.toString(),
      'transport': _selectedTransport.value!['company'],
      'type': _selectedTransport.value!['type'],
    };

    // Navigate to payment
    Get.toNamed(
      AppRoutes.PAYMENT,
      arguments: {
        'service': 'land_transport',
        'passengers': [bookingData], // Transport booking data
        'amount': totalAmount,
        'transport': _selectedTransport.value,
      },
    );
  }

  double _calculateTotalAmount() {
    if (_selectedTransport.value == null) return 0.0;

    double basePrice = _selectedTransport.value!['price'].toDouble();
    double totalAmount = basePrice * _numberOfPassengers.value;

    // Add return trip cost if round trip
    if (_isRoundTrip.value) {
      totalAmount *= 2;
    }

    return totalAmount;
  }
}
