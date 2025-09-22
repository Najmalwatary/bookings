// lib/app/modules/data_entry/widgets/trip_details_card_widget.dart (النسخة المعدلة مع التحقق)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../controllers/data_entry_controller.dart';

class TripDetailsCardWidget extends StatelessWidget {
  final DataEntryController controller = Get.find();

  TripDetailsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Obx يراقب متغيرات الحالة ويعيد بناء الواجهة عند تغييرها
    return Obx(() {
      // إذا كانت الخدمة تتطلب تفاصيل رحلة (طيران أو نقل بري)
      if (controller.showFlightDetails.value) {
        return _buildFlightDetailsCard(context);
      }
      // إذا كانت الخدمة حجز فندق
      else if (controller.showHotelDetails.value) {
        return _buildHotelDetailsCard(context);
      }
      // إذا كانت الخدمة نقل بري
      else if (controller.showLandTransportDetails.value) {
        return _buildLandTransportDetailsCard(context);
      }
      // إذا لم تكن أي من هذه، اعرض حاوية فارغة
      else {
        return const SizedBox.shrink();
      }
    });
  }

  // --- 1. ويدجت تفاصيل الطيران ---
  Widget _buildFlightDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('تفاصيل الرحلة الجوية'),
            const SizedBox(height: 16),
            // --- ✅ بداية التعديل ✅ ---
            // تم تحويله إلى ويدجت منفصل لإضافة التحقق
            _buildCitiesDropdowns(),
            // --- ❌ نهاية التعديل ❌ ---
            const SizedBox(height: 16),
            _buildDateAndTimeRow(context),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildSeatSelection(), // قسم اختيار درجة المقعد
          ],
        ),
      ),
    );
  }

  // --- 2. ويدجت تفاصيل الفندق ---
  Widget _buildHotelDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('تفاصيل حجز الفندق'),
            const SizedBox(height: 16),
            _buildDropdown(
              hint: 'اختر مدينة الفندق',
              value: controller.hotelCity.value,
              items: controller.cities,
              onChanged: (v) => controller.hotelCity.value = v,
              prefixIcon: Icons.location_city,
              validator: (value) { // التحقق من مدينة الفندق
                if (value == null) return 'الرجاء اختيار مدينة الفندق';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    context,
                    'تاريخ الدخول',
                    controller.checkInDateController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    context,
                    'تاريخ المغادرة',
                    controller.checkOutDateController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildCounterField(
                    'عدد النزلاء',
                    controller.guestsCountController,
                    Icons.people,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCounterField(
                    'عدد الغرف',
                    controller.roomsCountController,
                    Icons.king_bed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildRoomTypeSelection(),
          ],
        ),
      ),
    );
  }

  // --- 3. ويدجت تفاصيل النقل البري ---
  Widget _buildLandTransportDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTitle('تفاصيل النقل البري'),
            const SizedBox(height: 16),
            // --- ✅ بداية التعديل ✅ ---
            // تم تحويله إلى ويدجت منفصل لإضافة التحقق
            _buildCitiesDropdowns(),
            // --- ❌ نهاية التعديل ❌ ---
            const SizedBox(height: 16),
            _buildDateAndTimeRow(context),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildVehicleSelection(),
          ],
        ),
      ),
    );
  }

  // --- 4. ويدجتس فرعية ومساعدة ---

  Widget _buildCardTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }

  // --- ✅ بداية الويدجت الجديدة للتحقق من المدن ✅ ---
  Widget _buildCitiesDropdowns() {
    return Column(
      children: [
        _buildDropdown(
          hint: 'من (المدينة)',
          value: controller.fromCity.value,
          items: controller.cities,
          onChanged: (v) => controller.fromCity.value = v,
          prefixIcon: Icons.flight_takeoff,
          validator: (value) {
            if (value == null) return 'الرجاء اختيار مدينة المغادرة';
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildDropdown(
          hint: 'إلى (المدينة)',
          value: controller.toCity.value,
          items: controller.cities,
          onChanged: (v) => controller.toCity.value = v,
          prefixIcon: Icons.flight_land,
          validator: (value) {
            if (value == null) return 'الرجاء اختيار مدينة الوصول';
            return null;
          },
        ),
      ],
    );
  }
  // --- ❌ نهاية الويدجت الجديدة ❌ ---

  Widget _buildSeatSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardTitle('اختر درجة المقعد'),
        ...controller.seatClasses.map((seatClass) {
          return RadioListTile<String>(
            title: Text(seatClass, style: const TextStyle(fontFamily: 'Cairo')),
            value: seatClass,
            groupValue: controller.selectedSeatClass.value,
            onChanged: (v) => controller.selectedSeatClass.value = v ?? '',
            activeColor: AppColors.secondaryColor,
            contentPadding: EdgeInsets.zero,
          );
        }),
      ],
    );
  }

  Widget _buildRoomTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardTitle('اختر نوع الغرفة'),
        ...controller.roomTypes.map((roomType) {
          return RadioListTile<String>(
            title: Text(roomType, style: const TextStyle(fontFamily: 'Cairo')),
            value: roomType,
            groupValue: controller.selectedRoomType.value,
            onChanged: (v) => controller.selectedRoomType.value = v ?? '',
            activeColor: AppColors.secondaryColor,
            contentPadding: EdgeInsets.zero,
          );
        }),
      ],
    );
  }

  Widget _buildVehicleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardTitle('اختر وسيلة النقل'),
        ...controller.vehicleTypes.map((vehicleType) {
          return RadioListTile<String>(
            title: Text(
              vehicleType,
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            value: vehicleType,
            groupValue: controller.selectedVehicleType.value,
            onChanged: (v) => controller.selectedVehicleType.value = v ?? '',
            activeColor: AppColors.secondaryColor,
            contentPadding: EdgeInsets.zero,
          );
        }),
      ],
    );
  }

  Widget _buildDateAndTimeRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildDateField(
            context,
            'تاريخ السفر',
            controller.travelDateController,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimeField(
            context,
            'وقت السفر',
            controller.travelTimeController,
          ),
        ),
      ],
    );
  }

  // --- ✅ بداية التعديل الأول ✅ ---
  Widget _buildDateField(
    BuildContext context,
    String label,
    TextEditingController dateController,
  ) {
    return CustomTextField(
      controller: dateController,
      labelText: label,
      prefixIcon: const Icon(
        Icons.calendar_today,
        color: AppColors.primaryColor,
      ),
      enabled: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          dateController.text =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء تحديد $label'; // رسالة خطأ ديناميكية
        }
        return null;
      },
    );
  }
  // --- ❌ نهاية التعديل الأول ❌ ---

  // --- ✅ بداية التعديل الثاني ✅ ---
  Widget _buildTimeField(
    BuildContext context,
    String label,
    TextEditingController timeController,
  ) {
    return CustomTextField(
      controller: timeController,
      labelText: label,
      prefixIcon: const Icon(Icons.access_time, color: AppColors.primaryColor),
      enabled: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          timeController.text = pickedTime.format(context);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء تحديد $label'; // رسالة خطأ ديناميكية
        }
        return null;
      },
    );
  }
  // --- ❌ نهاية التعديل الثاني ❌ ---

  Widget _buildCounterField(
    String label,
    TextEditingController countController,
    IconData icon,
  ) {
    return CustomTextField(
      controller: countController,
      labelText: label,
      keyboardType: TextInputType.number,
      prefixIcon: Icon(icon, color: AppColors.primaryColor),
    );
  }

  // --- ✅ بداية التعديل الثالث ✅ ---
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required IconData prefixIcon,
    String? Function(String?)? validator, // إضافة خاصية التحقق
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: const TextStyle(fontFamily: 'Cairo')),
      isExpanded: true,
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontFamily: 'Cairo')),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator, // استخدام خاصية التحقق
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
  // --- ❌ نهاية التعديل الثالث ❌ ---
}
// // lib/app/modules/data_entry/widgets/trip_details_card_widget.dart (النسخة النهائية الموحدة)

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/widgets/custom_text_field.dart';
// import '../controllers/data_entry_controller.dart';

// class TripDetailsCardWidget extends StatelessWidget {
//   final DataEntryController controller = Get.find();

//   TripDetailsCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Obx يراقب متغيرات الحالة ويعيد بناء الواجهة عند تغييرها
//     return Obx(() {
//       // إذا كانت الخدمة تتطلب تفاصيل رحلة (طيران أو نقل بري)
//       if (controller.showFlightDetails.value) {
//         return _buildFlightDetailsCard(context);
//       }
//       // إذا كانت الخدمة حجز فندق
//       else if (controller.showHotelDetails.value) {
//         return _buildHotelDetailsCard(context);
//       }
//       // إذا كانت الخدمة نقل بري
//       else if (controller.showLandTransportDetails.value) {
//         return _buildLandTransportDetailsCard(context);
//       }
//       // إذا لم تكن أي من هذه، اعرض حاوية فارغة
//       else {
//         return const SizedBox.shrink();
//       }
//     });
//   }

//   // --- 1. ويدجت تفاصيل الطيران ---
//   Widget _buildFlightDetailsCard(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCardTitle('تفاصيل الرحلة الجوية'),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               hint: 'من (المدينة)',
//               value: controller.fromCity.value,
//               items: controller.cities,
//               onChanged: (v) => controller.fromCity.value = v,
//               prefixIcon: Icons.flight_takeoff,
//             ),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               hint: 'إلى (المدينة)',
//               value: controller.toCity.value,
//               items: controller.cities,
//               onChanged: (v) => controller.toCity.value = v,
//               prefixIcon: Icons.flight_land,
//             ),
//             const SizedBox(height: 16),
//             _buildDateAndTimeRow(context),
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//             _buildSeatSelection(), // قسم اختيار درجة المقعد
//           ],
//         ),
//       ),
//     );
//   }

//   // --- 2. ويدجت تفاصيل الفندق ---
//   Widget _buildHotelDetailsCard(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCardTitle('تفاصيل حجز الفندق'),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               hint: 'اختر مدينة الفندق',
//               value: controller.hotelCity.value,
//               items: controller.cities,
//               onChanged: (v) => controller.hotelCity.value = v,
//               prefixIcon: Icons.location_city,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildDateField(
//                     context,
//                     'تاريخ الدخول',
//                     controller.checkInDateController,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: _buildDateField(
//                     context,
//                     'تاريخ المغادرة',
//                     controller.checkOutDateController,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildCounterField(
//                     'عدد النزلاء',
//                     controller.guestsCountController,
//                     Icons.people,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: _buildCounterField(
//                     'عدد الغرف',
//                     controller.roomsCountController,
//                     Icons.king_bed,
//                   ),
//                 ),
//               ],
//             ),
//             // ✅✅✅  بداية التعديل الجديد  ✅✅✅
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//             _buildRoomTypeSelection(), // إضافة قسم اختيار نوع الغرفة
//             // ✅✅✅  نهاية التعديل الجديد  ✅✅✅
//           ],
//         ),
//       ),
//     );
//   }

//   // --- 3. ويدجت تفاصيل النقل البري ---
//   Widget _buildLandTransportDetailsCard(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCardTitle('تفاصيل النقل البري'),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               hint: 'من (المدينة)',
//               value: controller.fromCity.value,
//               items: controller.cities,
//               onChanged: (v) => controller.fromCity.value = v,
//               prefixIcon: Icons.directions_bus,
//             ),
//             const SizedBox(height: 16),
//             _buildDropdown(
//               hint: 'إلى (المدينة)',
//               value: controller.toCity.value,
//               items: controller.cities,
//               onChanged: (v) => controller.toCity.value = v,
//               prefixIcon: Icons.pin_drop,
//             ),
//             const SizedBox(height: 16),
//             _buildDateAndTimeRow(context),
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//             _buildVehicleSelection(), // قسم اختيار نوع المركبة
//           ],
//         ),
//       ),
//     );
//   }

//   // --- 4. ويدجتس فرعية ومساعدة ---

//   Widget _buildCardTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontFamily: 'Cairo',
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: AppColors.primaryColor,
//       ),
//     );
//   }

//   Widget _buildSeatSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildCardTitle('اختر درجة المقعد'),
//         ...controller.seatClasses.map((seatClass) {
//           return RadioListTile<String>(
//             title: Text(seatClass, style: const TextStyle(fontFamily: 'Cairo')),
//             value: seatClass,
//             groupValue: controller.selectedSeatClass.value,
//             onChanged: (v) => controller.selectedSeatClass.value = v ?? '',
//             activeColor: AppColors.secondaryColor,
//             contentPadding: EdgeInsets.zero,
//           );
//         }),
//       ],
//     );
//   }

//   // ✅✅✅  بداية الويدجت الجديدة  ✅✅✅
//   Widget _buildRoomTypeSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildCardTitle('اختر نوع الغرفة'),
//         ...controller.roomTypes.map((roomType) {
//           return RadioListTile<String>(
//             title: Text(roomType, style: const TextStyle(fontFamily: 'Cairo')),
//             value: roomType,
//             groupValue: controller.selectedRoomType.value,
//             onChanged: (v) => controller.selectedRoomType.value = v ?? '',
//             activeColor: AppColors.secondaryColor,
//             contentPadding: EdgeInsets.zero,
//           );
//         }),
//       ],
//     );
//   }
//   // ✅✅✅  نهاية الويدجت الجديدة  ✅✅✅

//   Widget _buildVehicleSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildCardTitle('اختر وسيلة النقل'),
//         ...controller.vehicleTypes.map((vehicleType) {
//           return RadioListTile<String>(
//             title: Text(
//               vehicleType,
//               style: const TextStyle(fontFamily: 'Cairo'),
//             ),
//             value: vehicleType,
//             groupValue: controller.selectedVehicleType.value,
//             onChanged: (v) => controller.selectedVehicleType.value = v ?? '',
//             activeColor: AppColors.secondaryColor,
//             contentPadding: EdgeInsets.zero,
//           );
//         }),
//       ],
//     );
//   }

//   Widget _buildDateAndTimeRow(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildDateField(
//             context,
//             'تاريخ السفر',
//             controller.travelDateController,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _buildTimeField(
//             context,
//             'وقت السفر',
//             controller.travelTimeController,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateField(
//     BuildContext context,
//     String label,
//     TextEditingController dateController,
//   ) {
//     return CustomTextField(
//       controller: dateController,
//       labelText: label,
//       prefixIcon: const Icon(
//         Icons.calendar_today,
//         color: AppColors.primaryColor,
//       ),
//       enabled: true,
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime.now(),
//           lastDate: DateTime(2101),
//         );
//         if (pickedDate != null) {
//           dateController.text =
//               "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//         }
//       },
//     );
//   }

//   Widget _buildTimeField(
//     BuildContext context,
//     String label,
//     TextEditingController timeController,
//   ) {
//     return CustomTextField(
//       controller: timeController,
//       labelText: label,
//       prefixIcon: const Icon(Icons.access_time, color: AppColors.primaryColor),
//       enabled: true,
//       onTap: () async {
//         TimeOfDay? pickedTime = await showTimePicker(
//           context: context,
//           initialTime: TimeOfDay.now(),
//         );
//         if (pickedTime != null) {
//           timeController.text = pickedTime.format(context);
//         }
//       },
//     );
//   }

//   Widget _buildCounterField(
//     String label,
//     TextEditingController countController,
//     IconData icon,
//   ) {
//     return CustomTextField(
//       controller: countController,
//       labelText: label,
//       keyboardType: TextInputType.number,
//       prefixIcon: Icon(icon, color: AppColors.primaryColor),
//     );
//   }

//   Widget _buildDropdown({
//     required String hint,
//     required String? value,
//     required List<String> items,
//     required void Function(String?) onChanged,
//     required IconData prefixIcon,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       hint: Text(hint, style: const TextStyle(fontFamily: 'Cairo')),
//       isExpanded: true,
//       items: items
//           .map(
//             (item) => DropdownMenuItem<String>(
//               value: item,
//               child: Text(item, style: const TextStyle(fontFamily: 'Cairo')),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: AppColors.primaryColor.withOpacity(0.3),
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: AppColors.primaryColor.withOpacity(0.3),
//           ),
//         ),
//       ),
//     );
//   }
// }
