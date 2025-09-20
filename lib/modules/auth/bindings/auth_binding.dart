import 'package:get/get.dart';
import '../controllers/auth_controller.dart'; // استيراد متحكم تسجيل الدخول فقط

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
