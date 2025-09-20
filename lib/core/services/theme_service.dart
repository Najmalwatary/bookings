import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // ✅ 1. تم التغيير إلى GetStorage

import '../constants/app_colors.dart';

class ThemeService {
  static const String _themeKey = 'theme_mode';
  final _box = GetStorage(); // ✅ 2. إنشاء مثيل من صندوق التخزين

  // --- lightTheme getter remains unchanged ---
  static ThemeData get lightTheme {
    // ... (لا يوجد أي تغيير هنا، الكود الخاص بك يبقى كما هو)
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        background: AppColors.backgroundColor,
        surface: AppColors.surfaceColor,
        error: AppColors.errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceColor,
        foregroundColor: AppColors.textPrimaryColor,
        elevation: 0.5,
        shadowColor: AppColors.shadowColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          fontFamily: 'Cairo',
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardColor,
        elevation: 1,
        shadowColor: AppColors.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: AppColors.textLightColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textSecondaryColor,
          fontFamily: 'Cairo',
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondaryColor,
          fontFamily: 'Cairo',
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.primaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: AppColors.primaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: AppColors.primaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: AppColors.primaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: AppColors.primaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: AppColors.textPrimaryColor, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: AppColors.textPrimaryColor, fontFamily: 'Cairo'),
        bodyMedium: TextStyle(color: AppColors.textPrimaryColor, fontFamily: 'Cairo'),
        bodySmall: TextStyle(color: AppColors.textSecondaryColor, fontFamily: 'Cairo'),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondaryColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // --- darkTheme getter remains unchanged ---
  static ThemeData get darkTheme {
    // ... (لا يوجد أي تغيير هنا، الكود الخاص بك يبقى كما هو)
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLightColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLightColor,
        brightness: Brightness.dark,
        primary: AppColors.primaryLightColor,
        secondary: AppColors.secondaryDarkColor,
        background: AppColors.darkBackgroundColor,
        surface: AppColors.darkSurfaceColor,
        error: AppColors.errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurfaceColor,
        foregroundColor: AppColors.textLightColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLightColor,
          fontFamily: 'Cairo',
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryDarkColor,
          foregroundColor: AppColors.textLightColor,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryLightColor, width: 2),
        ),
        labelStyle: TextStyle(
          color: AppColors.textLightColor.withOpacity(0.8),
          fontFamily: 'Cairo',
        ),
        hintStyle: TextStyle(
          color: AppColors.textLightColor.withOpacity(0.6),
          fontFamily: 'Cairo',
        ),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(color: AppColors.primaryLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        displayMedium: const TextStyle(color: AppColors.primaryLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        displaySmall: const TextStyle(color: AppColors.primaryLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        headlineMedium: const TextStyle(color: AppColors.primaryLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        headlineSmall: const TextStyle(color: AppColors.primaryLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.w600),
        titleLarge: const TextStyle(color: AppColors.textLightColor, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
        bodyLarge: const TextStyle(color: AppColors.textLightColor, fontFamily: 'Cairo'),
        bodyMedium: const TextStyle(color: AppColors.textLightColor, fontFamily: 'Cairo'),
        bodySmall: TextStyle(color: AppColors.textLightColor.withOpacity(0.8), fontFamily: 'Cairo'),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurfaceColor,
        selectedItemColor: AppColors.primaryLightColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // ✅ 3. تم تعديل منطق القراءة والكتابة هنا
  ThemeMode get theme => _loadThemeFromBox();

  ThemeMode _loadThemeFromBox() {
    // اقرأ القيمة المحفوظة من GetStorage
    // إذا لم تكن هناك قيمة، استخدم الوضع الافتراضي للنظام
    String themeName = _box.read<String>(_themeKey) ?? ThemeMode.system.name;
    return ThemeMode.values.firstWhere((e) => e.name == themeName);
  }

  void saveThemeToBox(ThemeMode themeMode) {
    // احفظ القيمة الجديدة في GetStorage
    _box.write(_themeKey, themeMode.name);
  }
  // --- نهاية التعديل ---

  // لا تغيير هنا، هذه الدوال ستعمل الآن بشكل صحيح
  void changeThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    saveThemeToBox(themeMode);
  }

  void switchTheme() {
    final newThemeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(newThemeMode);
    saveThemeToBox(newThemeMode);
  }
}
