import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart'; // ✅ 1. تم إضافة هذا الاستيراد

import 'core/bindings/initial_binding.dart';
import 'core/services/localization_service.dart';
import 'core/services/theme_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

// ✅ 2. تم تحويل الدالة إلى async
void main() async {
  // ✅ 3. تم إضافة هذين السطرين لتهيئة خدمة التخزين
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp()); // تم إضافة const لتحسين الأداء
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // لم يتم تغيير أي شيء داخل هذا الويدجت بناءً على طلبك
    return GetMaterialApp(
      title: 'تطبيق الحجوزات',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),

      // Theme Configuration
      theme: ThemeService.lightTheme,
      darkTheme: ThemeService.darkTheme,
      themeMode: ThemeService().theme,

      // Localization Configuration
      locale: LocalizationService().locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'), // Arabic
        Locale('en', 'US'), // English
      ],

      // Navigation Configuration
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.routes,

      // Right-to-left support for Arabic
      builder: (context, child) {
        return Directionality(
          textDirection: Get.locale?.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
