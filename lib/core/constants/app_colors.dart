
import 'package:flutter/material.dart';

class AppColors {
  // ===================================================================
  // ===== لوحة ألوان "روح السفر" (بناءً على وصفك) =====
  // ===================================================================

  // Primary Colors - سيتم تعيينه للون العناوين الأزرق السماوي
  static const Color primaryColor = Color(0xFF1E90FF); // أزرق سماوي عصري
  static const Color primaryLightColor = Color(0xFF4DA8DA); // أزرق كهربائي (للوضع الداكن)
  static const Color primaryDarkColor = Color(0xFF1C86EE); // درجة أغمق قليلاً

  // Secondary Colors - سيتم تعيينه للون الزر البرتقالي
  static const Color secondaryColor = Color(0xFFFF6B35); // برتقالي مشرق
  static const Color secondaryLightColor = Color(0xFFFF8A65);
  static const Color secondaryDarkColor = Color(0xFFFF4500); // برتقالي داكن (للوضع الداكن)

  // Accent Colors - سيتم تعيينه للون التمييز الذهبي/الأصفر
  static const Color accentColor = Color(0xFFFFD700); // أصفر ذهبي فاتح
  static const Color accentLightColor = Color(0xFFFFE082);
  static const Color accentDarkColor = Color(0xFFFFC300); // أصفر كهرماني (للوضع الداكن)

  // Background Colors - الوضع الفاتح
  static const Color backgroundColor = Color(0xFFFFF9F2); // كريمي فاتح
  static const Color surfaceColor = Color(0xFFFFFFFF); // أبيض ناصع للأسطح
  static const Color cardColor = Color(0xFFFFFFFF);

  // Dark Theme Colors - الوضع الداكن
  static const Color darkBackgroundColor = Color(0xFF0D1B2A); // كحلي عميق
  static const Color darkSurfaceColor = Color(0xFF1B263B); // درجة أفتح للأسطح
  static const Color darkCardColor = Color(0xFF1B263B);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF333333); // رمادي داكن (فاتح)
  static const Color textSecondaryColor = Color(0xFF757575); // رمادي متوسط (فاتح)
  static const Color textLightColor = Color(0xFFE0E0E0); // رمادي فاتح (داكن)

  // Status Colors - سنجعل الأخضر للنجاح والأخضر الناعم كـ info
  static const Color successColor = Color(0xFF2ECC71); // أخضر زمردي
  static const Color errorColor = Color(0xFFD32F2F); // أحمر قياسي للأخطاء
  static const Color warningColor = Color(0xFFFFC300); // استخدام الأصفر الكهرماني للتحذير
  static const Color infoColor = Color(0xFF32CD99); // أخضر ناعم

  // Gradient Colors - تدرجات متناسقة
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, darkBackgroundColor],
  );

  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, secondaryDarkColor],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentColor, accentDarkColor],
  );

  // Shadow Colors
  static const Color shadowColor = Color(0x1A528AAE); // ظل أزرق شفاف
  static const Color lightShadowColor = Color(0x0D528AAE);
}
