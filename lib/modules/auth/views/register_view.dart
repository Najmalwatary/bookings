import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/sign_up_controller.dart'; //   <--- استيراد SignUpController

class RegisterView extends GetView<SignUpController> {
  //   <--- استخدام SignUpController
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
           decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ... (نفس تصميم الواجهة من الكود الأصلي)
                  const SizedBox(height: 35),
                  Text(
                    'مرحباً بك!\nأنشئ حسابك الآن',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'أدخل بياناتك للبدء في رحلتك',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 24,
                          offset: Offset(0, 10),
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: 'الاسم الكامل',
                            controller: controller.fullNameCtrl,
                            validator: controller.validateName,
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            labelText: 'البريد الإلكتروني',
                            controller: controller.emailCtrl,
                            validator: controller.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            labelText: 'رقم الهاتف',
                            controller: controller.phoneCtrl,
                            validator: controller.validatePhone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 18),
                          Obx(
                            () => CustomTextField(
                              labelText: 'كلمة السر',
                              controller: controller.passwordCtrl,
                              validator: controller.validatePassword,
                              obscureText: controller.isPasswordObscure.value,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.isPasswordObscure.toggle(),
                                icon: Icon(
                                  controller.isPasswordObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Obx(
                            () => CustomTextField(
                              labelText: 'تأكيد كلمة السر',
                              controller: controller.confirmPasswordCtrl,
                              validator: controller.validateConfirm,
                              obscureText: controller.isConfirmObscure.value,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.isConfirmObscure.toggle(),
                                icon: Icon(
                                  controller.isConfirmObscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Obx(
                            () => CustomButton(
                              text: "إنشاء حساب",
                              onPressed:
                                  controller.submit, // استدعاء دالة submit
                              isLoading: controller.isSubmitting.value,
                              width: double.infinity,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'لديك حساب بالفعل؟ تسجيل الدخول',
                      style: TextStyle(color: Colors.white.withOpacity(0.9)),
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
