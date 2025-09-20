import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../core/constants/app_colors.dart';
import '../controllers/flight_booking_controller.dart';

class FlightPassengersView extends GetView<FlightBookingController> {
  const FlightPassengersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('passenger_info'.tr)),
      body: const Center(
        child: Text(
          'هذه الصفحة مخصصة لعرض تفاصيل المسافرين\nيمكن استخدامها لعرض ملخص البيانات قبل الدفع',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}
