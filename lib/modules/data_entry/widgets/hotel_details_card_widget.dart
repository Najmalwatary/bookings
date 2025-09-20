// // lib/app/modules/data_entry/widgets/hotel_details_card_widget.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/widgets/custom_text_field.dart';
// import '../controllers/data_entry_controller.dart';

// class HotelDetailsCardWidget extends StatelessWidget {
//   final DataEntryController controller = Get.find();

//   HotelDetailsCardWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'تفاصيل حجز الفندق',
//               style: TextStyle(
//                 fontFamily: 'Cairo',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- القائمة المنسدلة لاختيار المدينة ---
//             _buildDropdown(
//               hint: 'اختر مدينة الفندق',
//               value: controller.hotelCity.value,
//               items: controller.cities,
//               onChanged: (value) {
//                 controller.hotelCity.value = value;
//               },
//             ),
//             const SizedBox(height: 16),

//             // --- حقول تاريخ الدخول والمغادرة ---
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     controller: controller.checkInDateController,
//                     labelText: 'تاريخ الدخول',
//                     prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//                     enabled: false,
//                     onTap: () => _selectDate(context, controller.checkInDateController),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextField(
//                     controller: controller.checkOutDateController,
//                     labelText: 'تاريخ المغادرة',
//                     prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//                     enabled: false,
//                     onTap: () => _selectDate(context, controller.checkOutDateController),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // --- حقول عدد النزلاء والغرف ---
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextField(
//                     controller: controller.guestsCountController,
//                     labelText: 'عدد النزلاء',
//                     keyboardType: TextInputType.number,
//                     prefixIcon: const Icon(Icons.people, color: AppColors.primaryColor),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: CustomTextField(
//                     controller: controller.roomsCountController,
//                     labelText: 'عدد الغرف',
//                     keyboardType: TextInputType.number,
//                     prefixIcon: const Icon(Icons.king_bed, color: AppColors.primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لبناء القائمة المنسدلة
//   Widget _buildDropdown({
//     required String hint,
//     required String? value,
//     required List<String> items,
//     required void Function(String?) onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       hint: Text(hint, style: const TextStyle(fontFamily: 'Cairo')),
//       isExpanded: true,
//       items: items.map((String item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item, style: const TextStyle(fontFamily: 'Cairo')),
//         );
//       }).toList(),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.location_city, color: AppColors.primaryColor),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.3)),
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لاختيار التاريخ
//   Future<void> _selectDate(BuildContext context, TextEditingController dateController) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//       dateController.text = formattedDate;
//     }
//   }
// }
