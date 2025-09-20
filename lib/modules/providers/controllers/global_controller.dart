// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// // استيراد نموذج البيانات من ملف الـ providers_controller
// import 'providers_controller.dart';

// class GlobalController extends GetxController {
//   static GlobalController get to => Get.find(); // طريقة سهلة للوصول إليه

//   // --- قوائم البيانات الرئيسية ---
//   final RxList<ProviderModel> allProviders = <ProviderModel>[].obs;
//   final RxBool isDataLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllInitialData(); // جلب كل البيانات عند بدء التطبيق
//   }

//   Future<void> fetchAllInitialData() async {
//     try {
//       isDataLoading.value = true;
//       // !!! هام: تأكد من أن هذا هو الـ IP الصحيح لجهازك !!!
//       final url = Uri.parse('http://192.168.43.26/booking_api/');
//       final response = await http.get(url).timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse['success'] == true) {
//           final data = jsonResponse['data'] as List;
//           allProviders.assignAll(
//             data.map((d) => ProviderModel.fromJson(d)).toList(),
//           );
//         } else {
//           throw Exception('API returned success=false');
//         }
//       } else {
//         throw Exception('Server error: ${response.statusCode}');
//       }
//     } catch (e) {
//       Get.snackbar('خطأ في الشبكة', 'فشل جلب البيانات الأولية: $e');
//     } finally {
//       isDataLoading.value = false;
//     }
//   }
// }
