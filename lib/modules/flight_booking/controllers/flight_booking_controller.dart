import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class FlightBookingController extends GetxController {
  final fromController = TextEditingController();
  final _numberOfPassengers = 1.obs;
  final _passengers = <Map<String, TextEditingController>>[].obs;

  int get numberOfPassengers => _numberOfPassengers.value;
  List<Map<String, TextEditingController>> get passengers => _passengers;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _initializePassengers();
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void _initializePassengers() {
    _passengers.clear();
    for (int i = 0; i < _numberOfPassengers.value; i++) {
      _passengers.add(_createPassengerControllers());
    }
  }

  Map<String, TextEditingController> _createPassengerControllers() {
    return {
      'name': TextEditingController(),
      'passport': TextEditingController(),
      'dateOfBirth': TextEditingController(),
      'nationality': TextEditingController(),
    };
  }

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
  void selectFromCity(String? city) {
    if (city != null) {
      fromController.text = city;
    }
  }

  void _disposeControllers() {
    for (var passenger in _passengers) {
      for (var controller in passenger.values) {
        controller.dispose();
      }
    }
  }

  void increasePassengers() {
    if (_numberOfPassengers.value < 50) {
      _numberOfPassengers.value++;
      _passengers.add(_createPassengerControllers());
    }
  }

  void decreasePassengers() {
    if (_numberOfPassengers.value > 1) {
      // Dispose controllers for the last passenger
      for (var controller in _passengers.last.values) {
        controller.dispose();
      }
      _passengers.removeLast();
      _numberOfPassengers.value--;
    }
  }

  String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    return null;
  }

  String? validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    if (value.length < 6) {
      return 'رقم جواز السفر قصير جداً';
    }
    return null;
  }

  void selectDateOfBirth(int passengerIndex) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _passengers[passengerIndex]['dateOfBirth']!.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void proceedToPayment() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Collect passenger data
    List<Map<String, String>> passengerData = [];
    for (var passenger in _passengers) {
      passengerData.add({
        'name': passenger['name']!.text,
        'passport': passenger['passport']!.text,
        'dateOfBirth': passenger['dateOfBirth']!.text,
        'nationality': passenger['nationality']!.text,
      });
    }

    // Navigate to payment with passenger data
    Get.toNamed(
      AppRoutes.PAYMENT,
      arguments: {
        'service': 'flight_booking',
        'passengers': passengerData,
        'amount': _calculateAmount(),
      },
    );
  }

  double _calculateAmount() {
    // Simple calculation based on number of passengers
    return _numberOfPassengers.value * 1500.0; // 1500 SAR per passenger
  }
}
