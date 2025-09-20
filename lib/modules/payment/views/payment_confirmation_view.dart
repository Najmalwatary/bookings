// ملف: lib/app/modules/payment/views/payment_confirmation_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // لاستخدامه في تنسيق التاريخ

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_routes.dart';

class PaymentConfirmationView extends StatelessWidget {
  const PaymentConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 1. قراءة البيانات الحقيقية من الشاشة السابقة ---
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final String serviceName = args['service_name'] ?? 'غير متوفر';
    final int passengerCount = args['passenger_count'] ?? 0;
    final String bankName = args['bank_name'] ?? 'غير متوفر';
    final double amountPaid = (args['amount_paid'] as num?)?.toDouble() ?? 0.0;
    final int bookingId = args['booking_id'] ?? 0; // رقم الحجز من الخادم
    final List<String> passengersNames = List<String>.from(
      args['passengers_names'] ?? [],
    );

    // تنسيق تاريخ اليوم
    final String bookingDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.primaryColor, // لون الخلفية أزرق
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- 2. أيقونة وعنوان النجاح (مطابق للصورة) ---
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.successColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'تم الدفع بنجاح',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'تم تأكيد الحجز بنجاح',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // --- 3. بطاقة تفاصيل الحجز (مطابقة للصورة) ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تفاصيل الحجز',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow('الخدمة:', serviceName),
                      _buildDetailRow(
                        'عدد المسافرين:',
                        passengerCount.toString(),
                      ),
                      _buildDetailRow('البنك:', bankName),
                      _buildDetailRow(
                        'المبلغ المدفوع:',
                        '${amountPaid.toStringAsFixed(2)} ريال',
                      ),
                      _buildDetailRow('تاريخ الحجز:', bookingDate),
                      _buildDetailRow(
                        'رقم الحجز:',
                        'BK$bookingId',
                      ), // استخدام الرقم الحقيقي
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        'المسافرون:',
                        passengersNames.join('\n'),
                      ), // عرض أسماء المسافرين
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // --- 4. أزرار الإجراءات (مطابقة للصورة) ---
                CustomButton(
                  text: 'العودة للرئيسية',
                  onPressed: () => Get.offAllNamed(AppRoutes.HOME),
                  width: double.infinity,
                  height: 50,
                  backgroundColor: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'حجز جديد',
                  onPressed: () => Get.offAllNamed(
                    AppRoutes.HOME,
                  ), // يمكنك توجيهه إلى شاشة الخدمات
                  width: double.infinity,
                  height: 50,
                  isOutlined: true,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة لعرض تفاصيل الحجز
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // عرض ثابت لترتيب الواجهة
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondaryColor,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimaryColor,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
