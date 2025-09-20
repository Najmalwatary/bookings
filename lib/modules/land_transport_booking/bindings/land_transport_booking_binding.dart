import 'package:get/get.dart';
import '../controllers/land_transport_booking_controller.dart';

class LandTransportBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandTransportBookingController>(
      () => LandTransportBookingController(),
    );
  }
}
