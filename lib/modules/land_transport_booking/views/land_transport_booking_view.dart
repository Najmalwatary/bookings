import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/land_transport_booking_controller.dart';

class LandTransportBookingView extends StatelessWidget {
  final LandTransportBookingController controller = Get.put(
    LandTransportBookingController(),
  );

  LandTransportBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('land_transport'.tr)),
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
                    'احجز رحلتك البرية',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سفر مريح وآمن إلى وجهتك',
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
                            'تفاصيل الرحلة',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textLightColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 16),

                          // To City Dropdown - المعدل
                          // From City - مدمج مع جميع الخصائص
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: AppColors.primaryColor.withOpacity(0.3),
                              // ),
                              // borderRadius: BorderRadius.circular(8),
                              // color: Theme.of(
                              //   context,
                              // ).inputDecorationTheme.fillColor,
                            ),
                            child: Obx(
                              () => DropdownButtonFormField<String>(
                                // الربط مع القيمة المراقبة في الـ Controller
                                value: controller.fromController.value,
                                decoration: InputDecoration(
                                  // labelText: 'from'.tr,
                                  prefixIcon: const Icon(
                                    Icons.my_location_outlined,
                                  ),
                                  border: InputBorder
                                      .none, // إزالة الحدود الافتراضية
                                  errorBorder: InputBorder
                                      .none, // إزالة حدود الخطأ الافتراضية
                                ),
                                hint: const Text(
                                  'اختر مدينة المغادرة',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                items: controller.cities.map((String city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(
                                      city,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  );
                                }).toList(),

                                onChanged: controller.selectFromCity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Container(
                          //   width: double.infinity,
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: AppColors.primaryColor.withOpacity(0.3),
                          //     ),
                          //     borderRadius: BorderRadius.circular(8),
                          //     color: Theme.of(
                          //       context,
                          //     ).inputDecorationTheme.fillColor,
                          //   ),
                          //   child: DropdownButton<String>(
                          //     value: controller.fromController.text.isEmpty
                          //         ? null
                          //         : controller.fromController.text,
                          //     hint: const Text(
                          //       'اختر مدينة المغادرة',
                          //       style: TextStyle(fontFamily: 'Cairo'),
                          //     ),
                          //     isExpanded: true,
                          //     underline: Container(),
                          //     items: controller.cities.map((city) {
                          //       return DropdownMenuItem<String>(
                          //         value: city,
                          //         child: Text(
                          //           city,
                          //           style: const TextStyle(fontFamily: 'Cairo'),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: controller.selectFromCity,
                          //   ),
                          // ),
                          const SizedBox(height: 16),

                          // To City
                          Text(
                            'إلى',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Container(
                          //   width: double.infinity,
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: AppColors.primaryColor.withOpacity(0.3),
                          //     ),
                          //     borderRadius: BorderRadius.circular(8),
                          //     color: Theme.of(
                          //       context,
                          //     ).inputDecorationTheme.fillColor,
                          //   ),
                          //   child: DropdownButton<String>(
                          //     value: controller.toController.va.isEmpty
                          //         ? null
                          //         : controller.toController.text,
                          //     hint: const Text(
                          //       'اختر مدينة الوصول',
                          //       style: TextStyle(fontFamily: 'Cairo'),
                          //     ),
                          //     isExpanded: true,
                          //     underline: Container(),
                          //     items: controller.cities.map((city) {
                          //       return DropdownMenuItem<String>(
                          //         value: city,
                          //         child: Text(
                          //           city,
                          //           style: const TextStyle(fontFamily: 'Cairo'),
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: controller.selectToCity,
                          //   ),
                          // ),
                          const SizedBox(height: 16),

                          // Departure Date
                          CustomTextField(
                            labelText: 'تاريخ المغادرة',
                            hintText: 'اختر تاريخ المغادرة',
                            controller: controller.departureDateController,
                            validator: controller.validateRequired,
                            prefixIcon: const Icon(Icons.calendar_today),
                            enabled: false,
                            onTap: controller.selectDepartureDate,
                          ),

                          const SizedBox(height: 16),

                          // Round Trip Toggle
                          // Row(
                          //   children: [
                          //     // Obx(() => Checkbox(
                          //     //   value: controller.isRoundTrip,
                          //     //   onChanged: controller.toggleRoundTrip,
                          //     //   activeColor: AppColors.primaryColor,
                          //     // )),
                          //     const Text(
                          //       'رحلة ذهاب وعودة',
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         fontFamily: 'Cairo',
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Return Date (if round trip)
                          Obx(
                            () => controller.isRoundTrip
                                ? Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      CustomTextField(
                                        labelText: 'تاريخ العودة',
                                        hintText: 'اختر تاريخ العودة',
                                        controller:
                                            controller.returnDateController,
                                        validator: controller.validateRequired,
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                        ),
                                        enabled: false,
                                        onTap: controller.selectReturnDate,
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),

                          const SizedBox(height: 16),

                          // Number of Passengers
                          Text(
                            'عدد المسافرين',
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
                                onPressed: controller.decreasePassengers,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    '${controller.numberOfPassengers}',
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
                                onPressed: controller.increasePassengers,
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Transport Options Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اختر وسيلة النقل',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ...controller.transportOptions.map(
                          //   (transport) => _buildTransportCard(transport),
                          // ),
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

  Widget _buildTransportCard(Map<String, dynamic> transport) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: controller.selectedTransport?['id'] == transport['id']
              ? const BorderSide(color: AppColors.primaryColor, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => controller.selectTransport(transport),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Transport Image Placeholder
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: AppColors.secondaryGradient,
                      ),
                      child: const Icon(
                        Icons.directions_bus,
                        size: 40,
                        color: AppColors.textLightColor,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Transport Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transport['company'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            transport['type'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Rating and Duration
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: transport['rating'].toDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: AppColors.accentColor,
                                ),
                                itemCount: 5,
                                itemSize: 16.0,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${transport['rating']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: AppColors.textSecondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                transport['duration'],
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
                          '${transport['price'].toStringAsFixed(0)} ريال',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const Text(
                          'للشخص الواحد',
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
                  transport['description'],
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
                  children: (transport['amenities'] as List<String>).map((
                    amenity,
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

                if (controller.selectedTransport?['id'] == transport['id'])
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
                          'تم اختيار هذه الوسيلة',
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
