import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/umrah_hajj_visa_controller.dart';

class UmrahHajjOfficesView extends GetView<UmrahHajjVisaController> {
  const UmrahHajjOfficesView({super.key});

  @override
  Widget build(BuildContext context) {
    final String service = Get.arguments?['service'] ?? '';
    final String serviceTitle = service == 'umrah' ? 'العمرة' : 'الحج';

    return Scaffold(
      appBar: AppBar(title: Text('مكاتب $serviceTitle')),
      body: Column(
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
                  'اختر المكتب المناسب',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLightColor,
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'جميع المكاتب معتمدة ومرخصة رسمياً',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textLightColor.withOpacity(0.8),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),

          // Offices List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.offices.length,
              itemBuilder: (context, index) {
                final office = controller.offices[index];
                return _buildOfficeCard(office, service);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeCard(Map<String, dynamic> office, String service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => controller.selectOffice(office),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Office Image Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: AppColors.secondaryGradient,
                    ),
                    child: const Icon(
                      Icons.business,
                      size: 40,
                      color: AppColors.textLightColor,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Office Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          office['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: office['rating'].toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: AppColors.accentColor,
                              ),
                              itemCount: 5,
                              itemSize: 16.0,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${office['rating']} (${office['reviews']} تقييم)',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondaryColor,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Price
                        Text(
                          'من ${office['price'].toStringAsFixed(0)} ريال',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                office['description'],
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                  fontFamily: 'Cairo',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Services
              Wrap(
                spacing: 8,
                children: (office['services'] as List<String>).map((
                  serviceItem,
                ) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      serviceItem,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // Select Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => controller.selectOffice(office),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textLightColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'اختيار',
                    style: TextStyle(fontSize: 14, fontFamily: 'Cairo'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
