import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/auth_provider.dart'; // استيراد الـ Provider

class SignUpController extends GetxController {
  // --- Provider (للاتصال بالـ API) ---
  final AuthProvider _authProvider = AuthProvider();

  // --- الخصائص من الكود الأصلي (تم الحفاظ عليها) ---
  final formKey = GlobalKey<FormState>();
  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  final isPasswordObscure = true.obs;
  final isConfirmObscure = true.obs;
  final isSubmitting = false.obs; // هذا هو نفسه isLoading

  // --- دالة منتقي تاريخ الميلاد (من الكود الأصلي) ---
  Future<void> pickBirthdate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 10),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      birthdateCtrl.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  // --- دالة إنشاء الحساب (submit) المحدّثة مع اتصال API ---
  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isSubmitting.value = true; // تفعيل مؤشر التحميل

    try {
      // استدعاء الـ API الحقيقي بدلاً من المحاكاة
      var response = await _authProvider.register(
        fullName: fullNameCtrl.text,
        email: emailCtrl.text,
        password: passwordCtrl.text,
        phoneNumber: phoneCtrl.text,
      );

      if (response['success'] == true) {
        // نجاح إنشاء الحساب
        Get.back(); // العودة إلى شاشة تسجيل الدخول
        Get.snackbar(
          'تم',
          'تم إنشاء الحساب بنجاح. يمكنك الآن تسجيل الدخول.',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // فشل إنشاء الحساب (عرض الرسالة من الخادم)
        throw Exception(response['message'] ?? 'فشل إنشاء الحساب');
      }
    } catch (e) {
      // التعامل مع أي خطأ
      Get.snackbar(
        'خطأ',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false; // إيقاف مؤشر التحميل
    }
  }

  // --- دوال التحقق من الصحة (من الكود الأصلي) ---
  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'الاسم الكامل مطلوب';
    if (v.trim().split(' ').length < 2) {
      return 'اكتب الاسم الأول واللقب على الأقل';
    }
    return null;
  }

  String? validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'البريد الإلكتروني مطلوب';
    final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}");
    if (!emailRegex.hasMatch(v.trim())) return 'صيغة بريد غير صحيحة';
    return null;
  }

  String? validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'رقم الهاتف مطلوب';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) return 'أدخل رقم هاتف صحيح';
    return null;
  }

  String? validateBirthdate(String? v) {
    if (v == null || v.trim().isEmpty) return 'تاريخ الميلاد مطلوب';
    return null;
  }

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'كلمة السر مطلوبة';
    if (v.length < 6) return 'يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  String? validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'تأكيد كلمة السر مطلوب';
    if (v != passwordCtrl.text) return 'كلمتا السر غير متطابقتين';
    return null;
  }

  // --- تنظيف الذاكرة ---
  @override
  void onClose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    birthdateCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }
}
