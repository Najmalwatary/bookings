// // lib/app/modules/data_entry/widgets/passenger_card_widget.dart (النسخة النهائية والمصححة)

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart'; // سيبقى هذا الاستيراد هنا
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/widgets/custom_text_field.dart';
// import '../controllers/data_entry_controller.dart';

// class PassengerCardWidget extends StatelessWidget {
//   final PassengerModel passenger;
//   final int passengerNumber;
//   final DataEntryController controller = Get.find();

//   PassengerCardWidget({
//     super.key,
//     required this.passenger,
//     required this.passengerNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'بيانات المسافر رقم $passengerNumber',
//                   style: TextStyle(
//                     fontFamily: 'Cairo',
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 if (controller.passengers.length > 1)
//                   IconButton(
//                     icon: const Icon(
//                       Icons.delete_forever,
//                       color: AppColors.errorColor,
//                     ),
//                     onPressed: () => controller.removePassenger(passenger),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             CustomTextField(
//               controller: passenger.nameController,
//               labelText: 'اسم المسافر',
//               prefixIcon: const Icon(
//                 Icons.person,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 16),
//             CustomTextField(
//               controller: passenger.passportController,
//               labelText: 'رقم جواز السفر',
//               prefixIcon: const Icon(
//                 Icons.subtitles,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Obx(() {
//               final imagePath = passenger.passportImagePath.value;
//               final isImageUploaded = imagePath.isNotEmpty;
//               return Center(
//                 child: OutlinedButton.icon(
//                   icon: Icon(
//                     isImageUploaded ? Icons.check_circle : Icons.camera_alt,
//                     color: isImageUploaded
//                         ? Colors.green
//                         : AppColors.secondaryColor,
//                   ),
//                   label: Text(
//                     isImageUploaded ? 'تم رفع الصورة' : 'رفع صورة الجواز',
//                     style: TextStyle(
//                       fontFamily: 'Cairo',
//                       color: isImageUploaded
//                           ? Colors.green
//                           : AppColors.secondaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                     side: BorderSide(
//                       color: isImageUploaded
//                           ? Colors.green
//                           : AppColors.secondaryColor,
//                       width: 2,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   // ✅✅✅  هذا هو التعديل الوحيد والمهم  ✅✅✅
//                   // الآن عند الضغط، يتم استدعاء الدالة الجديدة مباشرة
//                   onPressed: () => controller.pickImage(passenger.id),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
// lib/app/modules/data_entry/widgets/passenger_card_widget.dart (النسخة المعدلة مع التحقق)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart'; // سيبقى هذا الاستيراد هنا
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/data_entry_controller.dart';

class PassengerCardWidget extends StatelessWidget {
  final PassengerModel passenger;
  final int passengerNumber;
  final DataEntryController controller = Get.find();

  PassengerCardWidget({
    super.key,
    required this.passenger,
    required this.passengerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'بيانات المسافر رقم $passengerNumber',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                if (controller.passengers.length > 1)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: AppColors.errorColor,
                    ),
                    onPressed: () => controller.removePassenger(passenger),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // --- ✅ بداية التعديل الأول ✅ ---
            CustomTextField(
              controller: passenger.nameController,
              labelText: 'اسم المسافر',
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال اسم المسافر';
                }
                return null;
              },
            ),
            // --- ❌ نهاية التعديل الأول ❌ ---
            const SizedBox(height: 16),
            // --- ✅ بداية التعديل الثاني ✅ ---
            CustomTextField(
              controller: passenger.passportController,
              labelText: 'رقم جواز السفر',
              prefixIcon: const Icon(
                Icons.subtitles,
                color: AppColors.primaryColor,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم جواز السفر';
                }
                return null;
              },
            ),
            // --- ❌ نهاية التعديل الثاني ❌ ---
            const SizedBox(height: 20),
            Obx(() {
              final imagePath = passenger.passportImagePath.value;
              final isImageUploaded = imagePath.isNotEmpty;
              return Center(
                child: OutlinedButton.icon(
                  icon: Icon(
                    isImageUploaded ? Icons.check_circle : Icons.camera_alt,
                    color: isImageUploaded
                        ? Colors.green
                        : AppColors.secondaryColor,
                  ),
                  label: Text(
                    isImageUploaded ? 'تم رفع الصورة' : 'رفع صورة الجواز',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: isImageUploaded
                          ? Colors.green
                          : AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    side: BorderSide(
                      color: isImageUploaded
                          ? Colors.green
                          : AppColors.secondaryColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => controller.pickImage(passenger.id),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
