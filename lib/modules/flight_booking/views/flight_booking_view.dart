import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/flight_booking_controller.dart';

class FlightBookingView extends StatelessWidget {
  final FlightBookingController controller = Get.put(FlightBookingController());

  FlightBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flight_booking'.tr)),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            // Number of Passengers Section
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                children: [
                  Text(
                    'number_of_passengers'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: controller.decreasePassengers,
                        icon: const Icon(
                          Icons.remove_circle,
                          color: AppColors.textLightColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textLightColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${controller.numberOfPassengers}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: controller.increasePassengers,
                        icon: const Icon(
                          Icons.add_circle,
                          color: AppColors.textLightColor,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Passengers Information Section
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.numberOfPassengers,
                  itemBuilder: (context, index) {
                    return _buildPassengerCard(index);
                  },
                ),
              ),
            ),

            // Proceed Button
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'next'.tr,
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

  Widget _buildPassengerCard(int index) {
    final passenger = controller.passengers[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المسافر ${index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 16),

            // Passenger Name
            CustomTextField(
              labelText: 'passenger_name'.tr,
              hintText: 'أدخل اسم كما هو في جواز السفر',
              controller: passenger['name'],
              validator: controller.validateRequired,
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.darkBackgroundColor,
              ),
            ),

            const SizedBox(height: 16),

            // Passport Number
            CustomTextField(
              labelText: 'passport_number'.tr,
              hintText: 'أدخل رقم جواز السفر',
              controller: passenger['passport'],
              validator: controller.validatePassport,
              prefixIcon: const Icon(Icons.credit_card),
            ),

            const SizedBox(height: 16),
            // GestureDetector(
            //   onTap: () => controller.selectDateOfBirth(index),
            //   child: AbsorbPointer(
            //     child: CustomTextField(
            //       labelText: 'تاريخ الميلاد',
            //       hintColor: 'YYYY-MM-DD',

            //       // controller: controller.passenger['dateOfBirth'],
            //       validator: controller.validateRequired,
            //       suffixIcon: const Icon(
            //         Icons.calendar_month,
            //         color: AppColors.darkBackgroundColor,
            //       ),
            //     ),
            //   ),
            // ),

            // Date of Birth
            CustomTextField(
              labelText: 'date_of_birth'.tr,
              hintText: 'اختر تاريخ الميلاد',
              controller: passenger['dateOfBirth'],
              validator: controller.validateRequired,
              prefixIcon: const Icon(
                Icons.calendar_today,
                color: AppColors.darkBackgroundColor,
              ),
              enabled: true,
              onTap: () => controller.selectDateOfBirth(index),
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
            //     // color: Theme.of(
            //     //   AppColors.lightShadowColor,
            //     // ).inputDecorationTheme.fillColor,
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

            // Nationality
            // CustomTextField(
            //   labelText: 'nationality'.tr,
            //   hintText: 'أدخل الجنسية',
            //   controller: passenger['nationality'],
            //   validator: controller.validateRequired,
            //   prefixIcon: const Icon(Icons.flag),
            // ),
          ],
        ),
      ),
    );
  }
}
