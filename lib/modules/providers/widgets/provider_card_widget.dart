import 'package:booking_app/data/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/providers_controller.dart';
import 'rating_section_widget.dart';

class ProviderCardWidget extends StatelessWidget {
  final ProviderModel provider;
  final ProvidersController controller = Get.find<ProvidersController>();

  ProviderCardWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    const cardBorderRadius = 15.0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: AppColors.primaryColor.withOpacity(0.3),
      child: InkWell(
        // --- هذا هو التعديل الأهم والنهائي ---
        onTap: () {
          // استدعاء الدالة الصحيحة من الـ Controller
          controller.navigateToDataEntry(provider);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundImage(),
            Container(color: AppColors.primaryColor.withOpacity(0.1)),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0x000277BD),
                    const Color(0x880277BD),
                    const Color(0xDD01579B),
                  ],
                  stops: const [0.5, 0.2, 0.7, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text: provider.address ?? 'العنوان غير متوفر',
                  ),
                  if (provider.phone != null && provider.phone!.isNotEmpty)
                    _buildInfoRow(icon: Icons.phone, text: provider.phone!),
                  RatingSectionWidget(providerId: provider.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final imageUrl =
        (provider.image != null && provider.image!.startsWith('http'))
            ? provider.image!
            : 'http://192.168.0.100/booking_api/images/${provider.image}';

    if (provider.image != null && provider.image!.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(color: AppColors.primaryColor.withOpacity(0.2));
        },
      );
    } else {
      return Container(color: AppColors.primaryColor.withOpacity(0.2));
    }
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 14),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.white.withOpacity(1),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
