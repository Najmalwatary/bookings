import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/providers_controller.dart';

class RatingSectionWidget extends StatelessWidget {
  final int providerId;
  final ProvidersController controller = Get.find<ProvidersController>();

  RatingSectionWidget({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRatingDialog(context),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: AppColors.accentColor, size: 18),
            const SizedBox(width: 4),
            Obx(() {
              double currentRating = controller.userRatings[providerId] ?? 0.0;
              return Text(
                currentRating.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    double tempRating = controller.userRatings[providerId] ?? 3.0;
    Get.defaultDialog(
      title: 'تقييم الخدمة',
      titleStyle: const TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ما هو تقييمك لهذه الخدمة؟',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          const SizedBox(height: 20),
          RatingBar.builder(
            initialRating: tempRating,
            minRating: 1,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: AppColors.accentColor),
            onRatingUpdate: (rating) {
              tempRating = rating;
            },
          ),
        ],
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
      ),
      confirm: TextButton(
        onPressed: () {
          controller.rateOffice(providerId, tempRating);
          Get.snackbar(
            'شكراً لك!',
            'تم تسجيل تقييمك بنجاح.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        },
        child: const Text(
          'قيّم الآن',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
      ),
      radius: 15,
    );
  }
}
