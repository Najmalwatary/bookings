// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// // import 'package:get_storage/get_storage.dart'; // ✅ 1. تم إضافة هذا الاستيراد

// // import 'core/bindings/initial_binding.dart';
// // import 'core/services/localization_service.dart';
// // import 'core/services/theme_service.dart';
// // import 'routes/app_pages.dart';
// // import 'routes/app_routes.dart';

// // // ✅ 2. تم تحويل الدالة إلى async
// // void main() async {
// //   // ✅ 3. تم إضافة هذين السطرين لتهيئة خدمة التخزين
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await GetStorage.init();

// //   runApp(const MyApp()); // تم إضافة const لتحسين الأداء
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // لم يتم تغيير أي شيء داخل هذا الويدجت بناءً على طلبك
// //     return GetMaterialApp(
// //       title: 'تطبيق الحجوزات',
// //       debugShowCheckedModeBanner: false,
// //       initialBinding: InitialBinding(),

// //       // Theme Configuration
// //       theme: ThemeService.lightTheme,
// //       darkTheme: ThemeService.darkTheme,
// //       themeMode: ThemeService().theme,

// //       // Localization Configuration
// //       locale: LocalizationService().locale,
// //       fallbackLocale: LocalizationService.fallbackLocale,
// //       translations: LocalizationService(),
// //       localizationsDelegates: const [
// //         GlobalMaterialLocalizations.delegate,
// //         GlobalWidgetsLocalizations.delegate,
// //         GlobalCupertinoLocalizations.delegate,
// //       ],
// //       supportedLocales: const [
// //         Locale('ar', 'SA'), // Arabic
// //         Locale('en', 'US'), // English
// //       ],

// //       // Navigation Configuration
// //       initialRoute: AppRoutes.LOGIN,
// //       getPages: AppPages.routes,

// //       // Right-to-left support for Arabic
// //       builder: (context, child) {
// //         return Directionality(
// //           textDirection: Get.locale?.languageCode == 'ar'
// //               ? TextDirection.rtl
// //               : TextDirection.ltr,
// //           child: child!,
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ استيراد Sentry

// import 'core/bindings/initial_binding.dart';
// import 'core/services/localization_service.dart';
// import 'core/services/theme_service.dart';
// import 'routes/app_pages.dart';
// import 'routes/app_routes.dart';

// // ✅ تم تحويل main لاستخدام Sentry
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();

//   // ✅ تهيئة Sentry
//   await SentryFlutter.init(
//     (options) {
//       options.dsn = 'ضع-الـDSN-الخاص-بك-هنا'; // انسخ DSN من sentry.io
//       options.tracesSampleRate = 1.0; // 1.0 يعني إرسال كل الأحداث (يمكنك تخفيضها)
//     },
//     appRunner: () => runApp(const MyApp()),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'تطبيق الحجوزات',
//       debugShowCheckedModeBanner: false,
//       initialBinding: InitialBinding(),

//       // Theme Configuration
//       theme: ThemeService.lightTheme,
//       darkTheme: ThemeService.darkTheme,
//       themeMode: ThemeService().theme,

//       // Localization Configuration
//       locale: LocalizationService().locale,
//       fallbackLocale: LocalizationService.fallbackLocale,
//       translations: LocalizationService(),
//       localizationsDelegates: const [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [
//         Locale('ar', 'SA'), // Arabic
//         Locale('en', 'US'), // English
//       ],

//       // Navigation Configuration
//       initialRoute: AppRoutes.LOGIN,
//       getPages: AppPages.routes,

//       // Right-to-left support for Arabic
//       builder: (context, child) {
//         return Directionality(
//           textDirection: Get.locale?.languageCode == 'ar'
//               ? TextDirection.rtl
//               : TextDirection.ltr,
//           child: child!,
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // استيراد Sentry

import 'core/bindings/initial_binding.dart';
import 'core/services/localization_service.dart';
import 'core/services/theme_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  // هذه الأسطر يجب أن تكون قبل تهيئة Sentry
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // ✅ تهيئة Sentry مع الـ DSN الصحيح الخاص بك
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://65d4a499fb1d8f6361980e3c6a07e3f7@o4510059104829440.ingest.de.sentry.io/4510059113676880';
      // يمكنك إضافة خيارات أخرى هنا إذا احتجت
      options.tracesSampleRate = 1.0; // يرسل بيانات الأداء
      options.sendDefaultPii = true; // يرسل معلومات تعريفية للمستخدم للمساعدة في تتبع الأخطاء
    },
    // appRunner يضمن تشغيل تطبيقك داخل بيئة Sentry
    appRunner: ( ) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // لا حاجة لإضافة SentryWidget هنا لأن appRunner يقوم بالمهمة
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
