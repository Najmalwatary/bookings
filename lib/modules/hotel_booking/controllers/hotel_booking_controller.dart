import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class HotelBookingController extends GetxController {
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();
  final guestsController = TextEditingController();
  final roomsController = TextEditingController();
  final specialRequestsController = TextEditingController();
  
  final _numberOfGuests = 1.obs;
  final _numberOfRooms = 1.obs;
  final _selectedHotel = Rxn<Map<String, dynamic>>();
  
  int get numberOfGuests => _numberOfGuests.value;
  int get numberOfRooms => _numberOfRooms.value;
  Map<String, dynamic>? get selectedHotel => _selectedHotel.value;
  
  final formKey = GlobalKey<FormState>();
  
  // Sample hotels data
  final List<Map<String, dynamic>> hotels = [
    {
      'id': '1',
      'name': 'فندق الحرم الشريف',
      'image': 'assets/images/hotel1.jpg',
      'rating': 4.8,
      'reviews': 250,
      'description': 'فندق فاخر بإطلالة على الحرم الشريف',
      'amenities': ['واي فاي مجاني', 'مطعم', 'خدمة الغرف', 'موقف سيارات'],
      'pricePerNight': 450.0,
      'location': 'مكة المكرمة',
    },
    {
      'id': '2',
      'name': 'فندق المدينة الذهبية',
      'image': 'assets/images/hotel2.jpg',
      'rating': 4.6,
      'reviews': 180,
      'description': 'فندق متميز في قلب المدينة المنورة',
      'amenities': ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'سبا'],
      'pricePerNight': 380.0,
      'location': 'المدينة المنورة',
    },
    {
      'id': '3',
      'name': 'فندق الريتز كارلتون',
      'image': 'assets/images/hotel3.jpg',
      'rating': 4.9,
      'reviews': 320,
      'description': 'فندق فاخر من فئة 5 نجوم مع خدمات استثنائية',
      'amenities': ['واي فاي مجاني', 'مطعم', 'مسبح', 'سبا', 'خدمة الكونسيرج'],
      'pricePerNight': 650.0,
      'location': 'الرياض',
    },
  ];
  
  @override
  void onInit() {
    super.onInit();
    guestsController.text = _numberOfGuests.value.toString();
    roomsController.text = _numberOfRooms.value.toString();
  }
  
  @override
  void onClose() {
    checkInController.dispose();
    checkOutController.dispose();
    guestsController.dispose();
    roomsController.dispose();
    specialRequestsController.dispose();
    super.onClose();
  }
  
  void increaseGuests() {
    if (_numberOfGuests.value < 10) {
      _numberOfGuests.value++;
      guestsController.text = _numberOfGuests.value.toString();
    }
  }
  
  void decreaseGuests() {
    if (_numberOfGuests.value > 1) {
      _numberOfGuests.value--;
      guestsController.text = _numberOfGuests.value.toString();
    }
  }
  
  void increaseRooms() {
    if (_numberOfRooms.value < 5) {
      _numberOfRooms.value++;
      roomsController.text = _numberOfRooms.value.toString();
    }
  }
  
  void decreaseRooms() {
    if (_numberOfRooms.value > 1) {
      _numberOfRooms.value--;
      roomsController.text = _numberOfRooms.value.toString();
    }
  }
  
  void selectCheckInDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      checkInController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }
  
  void selectCheckOutDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      checkOutController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }
  
  void selectHotel(Map<String, dynamic> hotel) {
    _selectedHotel.value = hotel;
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
    
    if (_selectedHotel.value == null) {
      Get.snackbar(
        'خطأ',
        'يرجى اختيار الفندق',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    
    // Calculate total amount
    double totalAmount = _calculateTotalAmount();
    
    // Collect booking data
    Map<String, String> bookingData = {
      'hotel': _selectedHotel.value!['name'],
      'checkIn': checkInController.text,
      'checkOut': checkOutController.text,
      'guests': _numberOfGuests.value.toString(),
      'rooms': _numberOfRooms.value.toString(),
      'specialRequests': specialRequestsController.text,
    };
    
    // Navigate to payment
    Get.toNamed(AppRoutes.PAYMENT, arguments: {
      'service': 'hotel_booking',
      'passengers': [bookingData], // Hotel booking data
      'amount': totalAmount,
      'hotel': _selectedHotel.value,
    });
  }
  
  double _calculateTotalAmount() {
    if (_selectedHotel.value == null) return 0.0;
    
    // Simple calculation: price per night * number of rooms * number of nights
    // For demo, assume 2 nights
    double pricePerNight = _selectedHotel.value!['pricePerNight'].toDouble();
    int nights = 2; // This should be calculated from check-in and check-out dates
    
    return pricePerNight * _numberOfRooms.value * nights;
  }
}

