// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/constants/app_colors.dart';
// import '../controllers/data_entry_controller.dart';

// class VehicleOption {
//   final String name;
//   final String price;
//   final IconData icon;
//   VehicleOption({required this.name, required this.price, required this.icon});
// }

// class VehicleCardWidget extends StatelessWidget {
//   final DataEntryController controller = Get.find();

//   VehicleCardWidget({Key? key}) : super(key: key);

//   final List<VehicleOption> vehicleOptions = [
//     VehicleOption(
//       name: 'حافلة عادية',
//       price: '150 ريال',
//       icon: Icons.directions_bus,
//     ),
//     VehicleOption(name: 'حافلة VIP', price: '250 ريال', icon: Icons.rv_hookup),
//     VehicleOption(
//       name: 'سيارة خاصة',
//       price: '400 ريال',
//       icon: Icons.directions_car,
//     ),
//     VehicleOption(
//       name: 'هايلوكس',
//       price: '300 ريال',
//       icon: Icons.airport_shuttle,
//     ),
//   ];

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
//             Text(
//               'اختر وسيلة النقل',
//               style: TextStyle(
//                 fontFamily: 'Cairo',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 16),
//             ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: vehicleOptions.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) {
//                 final option = vehicleOptions[index];
//                 return RadioListTile<String>(
//                   title: Text(
//                     option.name,
//                     style: const TextStyle(
//                       fontFamily: 'Cairo',
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     option.price,
//                     style: TextStyle(
//                       fontFamily: 'Cairo',
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                   value: option.name,
//                   groupValue: controller.selectedVehicle,
//                   onChanged: (value) {
//                     controller.selectVehicle(value);
//                   },
//                   secondary: Icon(
//                     option.icon,
//                     color: AppColors.primaryColor,
//                     size: 30,
//                   ),
//                   activeColor: AppColors.secondaryColor,
//                   controlAffinity: ListTileControlAffinity.trailing,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
