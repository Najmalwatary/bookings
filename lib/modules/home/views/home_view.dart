// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:carousel_slider/carousel_slider.dart' as slider;

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/service_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: controller.navigateToSettings,
          ),
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: controller.logout,
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildCarouselSection(),

            // Services Section
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'services'.tr,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontFamily: 'Cairo',
                ),
              ),
            ),

            const SizedBox(height: 16),
            _buildServicesGrid(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // استبدل الدالة القديمة بالكامل بهذه الدالة الجديدة
  Widget _buildCarouselSection() {
    return Column(
      children: [
        // ---  بداية الكود الجديد باستخدام الخاص بصور المتحركه PageView ---
        SizedBox(
          height: 200, // نفس الارتفاع الذي كنت تستخدمه
          child: PageView.builder(
            controller:
                controller.pageController, // الربط بالـ PageController الجديد
            itemCount: controller.carouselImages.length,
            onPageChanged:
                controller.onPageChanged, // الربط بدالة onPageChanged الجديدة
            itemBuilder: (context, index) {
              // هذا الكود يبني كل عنصر في السلايدر
              // لقد أخذت نفس تصميمك السابق ووضعته هنا
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ), // مسافة بين العناصر
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: AppColors.secondaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(26, 184, 167, 167),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: AppColors.accentGradient,
                        ),
                        // يمكنك هنا استخدام الصورة الحقيقية بدلاً من الأيقونة
                        child: Image.asset(
                          controller.carouselImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                         child:Text(
                            "discover_best".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textLightColor,
                              fontFamily: 'Cairo',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // --- نهاية الكود الجديد ---
        const SizedBox(height: 16),

        // مؤشرات التمرير (Indicators) - هذا الكود يعمل كما هو بدون تغيير
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.carouselImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentCarouselIndex == entry.key
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: controller.services.length,
        itemBuilder: (context, index) {
          final service = controller.services[index];
          return ServiceCard(
            title: service['title'].toString().tr,
            description: service['description'].toString().tr,
            icon: _getIconData(service['icon']),
            onTap: () => controller.navigateToService(service),
          );
        },
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'flight_takeoff':
        return Icons.flight_takeoff;
      case 'mosque':
        return Icons.mosque;
      case 'directions_bus':
        return Icons.directions_bus;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.star;
    }
  }
}
