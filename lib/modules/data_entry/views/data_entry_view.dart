// ملف: lib/app/modules/data_entry/views/data_entry_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/data_entry_controller.dart';
import '../widgets/passenger_card_widget.dart';
import '../widgets/trip_details_card_widget.dart';

class DataEntryView extends GetView<DataEntryController> {
  const DataEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.officeName), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey, // ربط الـ FormKey بالنموذج
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- قسم عدد المسافرين (بدون تغيير) ---
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'عدد المسافرين',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: AppColors.errorColor,
                                size: 32,
                              ),
                              onPressed: () {
                                if (controller.passengers.isNotEmpty) {
                                  controller.removePassenger(
                                    controller.passengers.last,
                                  );
                                }
                              },
                            ),
                            Text(
                              '${controller.passengers.length}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: AppColors.successColor,
                                size: 32,
                              ),
                              onPressed: controller.addPassenger,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
          
              // --- قسم بطاقات المسافرين (بدون تغيير) ---
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.passengers.length,
                  itemBuilder: (context, index) {
                    final passenger = controller.passengers[index];
                    return PassengerCardWidget(
                      passenger: passenger,
                      passengerNumber: index + 1,
                    );
                  },
                ),
              ),
              const Divider(height: 30, thickness: 1),
          
              // --- قسم تفاصيل الرحلة (بدون تغيير) ---
              TripDetailsCardWidget(),
              const SizedBox(height: 24),
          
              // --- ✅✅✅ بداية منطقة التعديل ✅✅✅ ---
          
              // 1. إضافة عرض السعر الإجمالي الديناميكي
              Card(
                elevation: 2,
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المبلغ الإجمالي:',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${controller.totalAmount.value.toStringAsFixed(2)} ريال',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
          
              // 2. تحديث الزر ليستدعي الدالة الصحيحة
              Obx(
                () => CustomButton(
                  text: controller.isProcessing.value
                      ? 'جاري التجهيز...'
                      : 'الانتقال إلى الدفع', // تم تغيير النص ليكون أوضح
                  onPressed: controller.isProcessing.value
                      ? null
                      : controller.goToPayment, // ✅ استدعاء الدالة الصحيحة
                  width: double.infinity,
                ),
              ),
              // --- ✅✅✅ نهاية منطقة التعديل ✅✅✅ ---
            ],
          ),
        ),
      ),
    );
  }
}
