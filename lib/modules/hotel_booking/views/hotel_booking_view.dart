import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/hotel_booking_controller.dart';

class HotelBookingView extends StatelessWidget {
  final HotelBookingController controller = Get.put(HotelBookingController());

  HotelBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hotel_booking'.tr)),
      body: Form(
        key: controller.formKey,
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
                    'احجز إقامتك المثالية',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اختر من بين أفضل الفنادق المتاحة',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLightColor.withOpacity(0.8),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Booking Form Section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تفاصيل الحجز',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Check-in Date
                          CustomTextField(
                            labelText: 'تاريخ الوصول',
                            hintText: 'اختر تاريخ الوصول',
                            controller: controller.checkInController,
                            validator: controller.validateRequired,
                            prefixIcon: const Icon(Icons.calendar_today),
                            enabled: false,
                            onTap: controller.selectCheckInDate,
                          ),

                          const SizedBox(height: 16),

                          // Check-out Date
                          CustomTextField(
                            labelText: 'تاريخ المغادرة',
                            hintText: 'اختر تاريخ المغادرة',
                            controller: controller.checkOutController,
                            validator: controller.validateRequired,
                            prefixIcon: const Icon(Icons.calendar_today),
                            enabled: false,
                            onTap: controller.selectCheckOutDate,
                          ),

                          const SizedBox(height: 16),

                          // Number of Guests and Rooms
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'عدد النزلاء',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimaryColor,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: controller.decreaseGuests,
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => Text(
                                              '${controller.numberOfGuests}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: controller.increaseGuests,
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'عدد الغرف',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimaryColor,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: controller.decreaseRooms,
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => Text(
                                              '${controller.numberOfRooms}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: controller.increaseRooms,
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Special Requests
                          CustomTextField(
                            labelText: 'طلبات خاصة (اختياري)',
                            hintText: 'أي طلبات أو ملاحظات خاصة',
                            controller: controller.specialRequestsController,
                            maxLines: 3,
                            prefixIcon: const Icon(Icons.note),
                          ),
                        ],
                      ),
                    ),

                    // Hotels List Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اختر الفندق',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 16),

                          ...controller.hotels.map(
                            (hotel) => _buildHotelCard(hotel),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Proceed Button
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'المتابعة للدفع',
                onPressed: controller.proceedToPayment,
                width: double.infinity,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelCard(Map<String, dynamic> hotel) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: controller.selectedHotel?['id'] == hotel['id']
              ? const BorderSide(color: AppColors.primaryColor, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => controller.selectHotel(hotel),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Hotel Image Placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: AppColors.secondaryGradient,
                      ),
                      child: const Icon(
                        Icons.hotel,
                        size: 40,
                        color: AppColors.textLightColor,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Hotel Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            hotel['location'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Rating
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: hotel['rating'].toDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: AppColors.accentColor,
                                ),
                                itemCount: 5,
                                itemSize: 16.0,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${hotel['rating']} (${hotel['reviews']})',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${hotel['pricePerNight'].toStringAsFixed(0)} ريال',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const Text(
                          'لكل ليلة',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Description
                Text(
                  hotel['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontFamily: 'Cairo',
                  ),
                ),

                const SizedBox(height: 12),

                // Amenities
                Wrap(
                  spacing: 8,
                  children: (hotel['amenities'] as List<String>).map((amenity) {
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
                        amenity,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (controller.selectedHotel?['id'] == hotel['id'])
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.successColor,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'تم اختيار هذا الفندق',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.successColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
