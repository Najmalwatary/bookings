import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/service_card.dart';
import '../controllers/umrah_hajj_visa_controller.dart';

class UmrahHajjVisaView extends StatelessWidget {
  // *** بداية التعديل: لا يوجد constructor هنا، وهذا جيد ***
  // لكن سننقل السطر التالي إلى دالة build
  // final UmrahHajjVisaController controller = Get.put(UmrahHajjVisaController());

  // نضيف constructor فارغًا ليكون الكود أكثر وضوحًا
  const UmrahHajjVisaView({super.key});
  // *** نهاية التعديل ***

  @override
  Widget build(BuildContext context) {
    // *** بداية التعديل: نقل تهيئة الـ Controller إلى هنا ***
    final UmrahHajjVisaController controller = Get.put(UmrahHajjVisaController());
    // *** نهاية التعديل ***

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأشيرة العمرة والحج'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اختر نوع الخدمة',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نقدم لك أفضل المكاتب المعتمدة لخدمات العمرة والحج',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textLightColor.withOpacity(0.8),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Services Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [
                  ServiceCard(
                    title: 'تأشيرة العمرة',
                    description: 'احصل على تأشيرة العمرة مع أفضل المكاتب المعتمدة',
                    icon: Icons.mosque,
                    onTap: () => controller.selectService('umrah'),
                  ),
                  ServiceCard(
                    title: 'تأشيرة الحج',
                    description: 'خدمات الحج الشاملة مع مرشدين متخصصين',
                    icon: Icons.mosque,
                    onTap: () => controller.selectService('hajj'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Features Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مميزات خدماتنا',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildFeatureItem(
                    icon: Icons.verified,
                    title: 'مكاتب معتمدة',
                    description: 'جميع المكاتب معتمدة من الجهات الرسمية',
                  ),
                  
                  _buildFeatureItem(
                    icon: Icons.support_agent,
                    title: 'دعم على مدار الساعة',
                    description: 'فريق دعم متاح لمساعدتك في أي وقت',
                  ),
                  
                  _buildFeatureItem(
                    icon: Icons.price_check,
                    title: 'أسعار تنافسية',
                    description: 'أفضل الأسعار مع جودة عالية في الخدمة',
                  ),
                  
                  _buildFeatureItem(
                    icon: Icons.security,
                    title: 'دفع آمن',
                    description: 'نظام دفع آمن ومحمي لضمان سلامة معاملاتك',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightShadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
