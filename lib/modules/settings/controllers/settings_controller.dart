import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/theme_service.dart';
import '../../../core/services/localization_service.dart';

class SettingsController extends GetxController {
  final ThemeService _themeService = ThemeService();
  final LocalizationService _localizationService = LocalizationService();

  final _isDarkMode = false.obs;
  final _isArabic = true.obs;

  bool get isDarkMode => _isDarkMode.value;
  bool get isArabic => _isArabic.value;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    // Load current theme mode
    _isDarkMode.value = Get.isDarkMode;

    // Load current language
    _isArabic.value = Get.locale?.languageCode == 'ar';
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _themeService.switchTheme();

    Get.snackbar(
      'تم تغيير المظهر',
      _isDarkMode.value ? 'تم تفعيل الوضع الداكن' : 'تم تفعيل الوضع الفاتح',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void toggleLanguage() {
    _isArabic.value = !_isArabic.value;
    _localizationService.switchLanguage();

    Get.snackbar(
      _isArabic.value ? 'تم تغيير اللغة' : 'Language Changed',
      _isArabic.value
          ? 'تم تغيير اللغة إلى العربية'
          : 'Language changed to English',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color.fromARGB(255, 101, 223, 228),
      colorText: Colors.white,
    );
  }

  void showAboutDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('about_app'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('app_name'.tr),
            SizedBox(height: 8),
            Text('الإصدار: 1.0.0'),
            SizedBox(height: 8),
            Text(
              'تطبيق شامل لحجز تذاكر الطيران والفنادق والتأشيرات والنقل البري',
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('confirm'.tr)),
        ],
      ),
    );
  }

  void showPrivacyPolicy() {
    Get.dialog(
      AlertDialog(
        title: Text('privacy_policy'.tr),
        content: SingleChildScrollView(
          child: Text(
            'هذا نص تجريبي لسياسة الخصوصية. في التطبيق الحقيقي، يجب أن تحتوي على سياسة الخصوصية الفعلية للتطبيق.',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('confirm'.tr)),
        ],
      ),
    );
  }

  void showTermsOfService() {
    Get.dialog(
      AlertDialog(
        title: Text('terms_of_service'.tr),
        content: SingleChildScrollView(
          child: Text(
            'هذا نص تجريبي لشروط الخدمة. في التطبيق الحقيقي، يجب أن تحتوي على شروط الخدمة الفعلية للتطبيق.',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('confirm'.tr)),
        ],
      ),
    );
  }
}
