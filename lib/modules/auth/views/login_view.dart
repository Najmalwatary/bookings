import 'package:booking_app/core/services/localization_service.dart';
import 'package:booking_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // الكود الخاص بك بالكامل، لم يتم حذف أي شيء
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- هذا هو تصميمك الأصلي ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.textLightColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.flight_takeoff,
                      size: 60,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'app_name'.tr,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'welcome'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textLightColor.withOpacity(0.8),
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.textLightColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'login'.tr,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            labelText: 'email'.tr,
                            hintText: 'email'.tr,
                            controller: controller.emailController,
                            validator: controller.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // استخدام GetBuilder هنا لحل مشكلة الأخطاء السابقة
                          GetBuilder<AuthController>(
                            builder: (authController) => CustomTextField(
                              labelText: 'password'.tr,
                              hintText: 'password'.tr,
                              controller: authController.passwordController,
                              validator: authController.validatePassword,
                              obscureText: authController.isPasswordVisible,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: AppColors.textPrimaryColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  color: AppColors.lightShadowColor,
                                  authController.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  authController.togglePasswordVisibility();
                                  authController.update();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GetBuilder<AuthController>(
                            builder: (authController) => CustomButton(
                              text: 'login'.tr,
                              onPressed: authController.login,
                              isLoading: authController.isLoading,
                              width: double.infinity,
                              height: 50,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: controller.forgotPassword,
                              child: Text(
                                'forgot_password'.tr,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'have_account'.tr,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: AppColors.textSecondaryColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: () {
                                  Get.toNamed(AppRoutes.account);
                                },
                                child: Text(
                                  'create_account'.tr,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // ✅✅✅ بداية الحل ✅✅✅
                          // هذا هو التعديل الوحيد الذي يحل مشكلة الخطأ الأحمر
                          GetBuilder<AuthController>(
                            builder: (_) => TextButton.icon(
                              icon: Icon(
                                Get.locale?.languageCode == 'ar'
                                    ? Icons.language
                                    : Icons.translate,
                                color: AppColors.textPrimaryColor,
                              ),
                              onPressed: () {
                                LocalizationService().switchLanguage();
                                controller.update();
                              },
                              label: Text(
                                Get.locale?.languageCode == 'ar'
                                    ? "English"
                                    : "العربية",
                                style: const TextStyle(
                                  color: AppColors.textPrimaryColor,
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          // --- نهاية الحل ---
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
