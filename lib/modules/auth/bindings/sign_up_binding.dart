import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart'; // استيراد المتحكم الخاص بإنشاء الحساب

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // استخدام lazyPut لتحميل المتحكم فقط عند استخدامه لأول مرة
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
