import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/providers_controller.dart';
import '../widgets/provider_card_widget.dart';

class ProvidersView extends GetView<ProvidersController> {
  const ProvidersView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.isDarkMode;
    // final String title = Get.arguments as String? ?? 'مقدمي الخدمات';
    // الكود الصحيح الذي سأضيفه لك
    final Map<String, dynamic> arguments = Get.arguments;
    final String title = arguments['service_type'] ?? 'خدمات';

    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.darkBackgroundColor
          : AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(title), // استخدام العنوان المستخرج بشكل صحيح
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.displayedProviders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 80,
                  color: AppColors.textSecondaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'لا يوجد مكاتب من نوع "$title" حالياً',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Cairo',
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: controller.displayedProviders.length,
          itemBuilder: (context, index) {
            final provider = controller.displayedProviders[index];
            return ProviderCardWidget(provider: provider);
          },
        );
      }),
    );
  }
}
