// lib/modules/auth/controllers/auth_controller.dart (النسخة النهائية)

import 'package:booking_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart'; // استيراد موديل المستخدم
import '../../../data/providers/auth_provider.dart';

class AuthController extends GetxController {
  // --- الخصائص الأصلية (تبقى كما هي) ---
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _isLoading = false.obs;
  final _isPasswordVisible = true.obs;
  bool get isLoading => _isLoading.value;
  bool get isPasswordVisible => _isPasswordVisible.value;

  final AuthProvider _authProvider = AuthProvider();

  // --- المتغير الجديد لتخزين بيانات المستخدم ---
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'field_required'.tr;
    if (!GetUtils.isEmail(value)) return 'invalid_email'.tr;
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'field_required'.tr;
    if (value.length < 6) return 'password_too_short'.tr;
    return null;
  }

  // --- دالة login المحدثة بالكامل ---
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    _isLoading.value = true;

    try {
      var response = await _authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response['success'] == true && response.containsKey('user')) {
        // تحويل بيانات المستخدم من JSON وتخزينها في المتغير
        currentUser.value = UserModel.fromJson(response['user']);

        print(
          ">> تم تسجيل دخول المستخدم: ${currentUser.value?.name} (ID: ${currentUser.value?.id})",
        );

        Get.offAllNamed(AppRoutes.HOME);
        Get.snackbar(
          'نجح تسجيل الدخول',
          'مرحباً بك ${currentUser.value?.name}', // استخدام اسم المستخدم للترحيب
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        throw Exception(response['message'] ?? 'بيانات تسجيل الدخول غير صحيحة');
      }
    } catch (e) {
      Get.snackbar(
        'خطأ في تسجيل الدخول',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // --- باقي الدوال (تبقى كما هي) ---
  void forgotPassword() {
    Get.snackbar('ميزة قيد التطوير', 'سيتم تفعيل استعادة كلمة المرور قريباً');
  }

  void createAccount() {
    // Get.toNamed(AppRoutes.REGISTER);
  }
}
