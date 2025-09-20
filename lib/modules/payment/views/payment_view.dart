import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends StatelessWidget {
  // *** بداية التعديل: لا يوجد constructor هنا، وهذا جيد ***
  // لكن سننقل السطر التالي إلى دالة build
  // final PaymentController controller = Get.put(PaymentController());

  // نضيف constructor فارغًا ليكون الكود أكثر وضوحًا
  const PaymentView({super.key});
  // *** نهاية التعديل ***

  @override
  Widget build(BuildContext context) {
    // *** بداية التعديل: نقل تهيئة الـ Controller إلى هنا ***
    final PaymentController controller = Get.put(PaymentController());
    // *** نهاية التعديل ***

    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final int passengerCount = args['passenger_count'] ?? 0;
    final List<String> passengersNames = List<String>.from(
      args['passengers_names'] ?? [],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('الدفع', style: TextStyle(fontFamily: 'Cairo')),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Obx(() {
              if (!controller.isDataLoaded.value) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  height: 170,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ملخص الدفع',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildSummaryRow('الخدمة', controller.serviceName),
                    const SizedBox(height: 8),

                    // --- ✅✅✅  هذا هو السطر الذي تم تصحيحه  ✅✅✅ ---
                    _buildSummaryRow(
                      'عدد المسافرين',
                      controller.passengerCount.toString(),
                    ),

                    // --- ✅✅✅  نهاية منطقة التصحيح  ✅✅✅ ---
                    const SizedBox(height: 8),
                    _buildSummaryRow(
                      'المبلغ الإجمالي',
                      '${controller.totalAmount.toStringAsFixed(2)} ريال',
                    ),
                  ],
                ),
              );
            }),

            // باقي الواجهة تبقى كما هي بدون أي تغيير
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اختر البنك',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => DropdownButton<int>(
                          value: controller.selectedBankId,
                          hint: const Text(
                            'اختر البنك',
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                          isExpanded: true,
                          underline: Container(),
                          items: controller.banks.map((bank) {
                            return DropdownMenuItem<int>(
                              value: bank['id'],
                              child: Text(
                                bank['name']!,
                                style: const TextStyle(fontFamily: 'Cairo'),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.onBankSelected(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'رقم حساب الشركة',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => CustomTextField(
                        hintText: controller.companyAccountNumber,
                        enabled: false,
                        prefixIcon: const Icon(Icons.account_balance),
                        suffixIcon: controller.isFetchingAccount.value
                            ? Container(
                                padding: const EdgeInsets.all(12.0),
                                child: const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'رقم حسابك',
                      controller: controller.userAccountController,
                      validator: controller.validateAccountNumber,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.credit_card),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => CustomTextField(
                        labelText: 'كلمة مرور حسابك',
                        controller: controller.userPasswordController,
                        validator: controller.validatePassword,
                        obscureText: !controller.isPasswordVisible,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => CustomButton(
                  text: 'ادفع الآن',
                  onPressed: controller.showPaymentConfirmation,
                  isLoading: controller.isLoading,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    bool isTotal = title == 'المبلغ الإجمالي';
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: isTotal ? 18 : 16,
          color: Colors.white,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '$title: ',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isTotal ? Colors.yellowAccent : Colors.white,
              fontSize: isTotal ? 20 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
