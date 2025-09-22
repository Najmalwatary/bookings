// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../data/models/provider_model.dart';
import '../../../routes/app_routes.dart';

class ProvidersController extends GetxController {
  final RxList<ProviderModel> _allProviders = <ProviderModel>[].obs;
  final RxList<ProviderModel> displayedProviders = <ProviderModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxMap<int, double> userRatings = <int, double>{}.obs;

  late Map<String, dynamic> receivedServiceData;

  @override
  void onInit( ) {
    super.onInit();
    receivedServiceData = Get.arguments as Map<String, dynamic>;
    final String? serviceType = receivedServiceData['service_type'] as String?;

    print("==============================================");
    print("بيانات الخدمة المستلمة هي: $receivedServiceData");
    print("نوع الخدمة المطلوب: $serviceType");
    print("==============================================");

    _fetchAndFilterProviders(serviceType);
  }

  Future<void> _fetchAndFilterProviders(String? serviceType) async {
    try {
      isLoading.value = true;
      final url = Uri.parse('http://192.168.0.101/booking_api/get_providers.php' );
      final response = await http.get(url );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true && jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          final providers = data.map((d) => ProviderModel.fromJson(d as Map<String, dynamic>)).toList();
          _allProviders.assignAll(providers);

          // ✅✅✅ بداية التعديل ✅✅✅
          // إضافة جمل طباعة تشخيصية
          print(">> تم جلب ${_allProviders.length} مكتب من قاعدة البيانات.");
          
          if (serviceType != null && serviceType.isNotEmpty) {
            print(">> جاري تصفية المكاتب حسب النوع: '$serviceType'");
            final filteredList = _allProviders.where((provider) {
              // طباعة نوع كل مكتب للمقارنة
              print("   - فحص مكتب '${provider.name}' من نوع: '${provider.type}'");
              return provider.type == serviceType;
            }).toList();
            
            print(">> نتيجة التصفية: تم العثور على ${filteredList.length} مكتب مطابق.");
            displayedProviders.assignAll(filteredList);
          } else {
            // في حالة عدم وجود نوع خدمة، اعرض كل المكاتب
            print(">> لم يتم تحديد نوع خدمة، سيتم عرض جميع المكاتب.");
            displayedProviders.assignAll(_allProviders);
          }
          // --- نهاية التعديل ---

        } else {
          throw Exception('API response format error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("===== خطأ فادح في فلاتر: $e =====");
      Get.snackbar('خطأ فادح', 'فشل جلب البيانات: $e');
      displayedProviders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToDataEntry(ProviderModel provider) {
    final Map<String, dynamic> argumentsToSend = {
      'service_id': receivedServiceData['id'],
      'service_type': receivedServiceData['service_type'],
      'provider_id': provider.id,
      'office_name': provider.name,
    };

    print(">> سيتم إرسال البيانات التالية إلى DataEntry: $argumentsToSend");
    Get.toNamed(AppRoutes.dataEntry, arguments: argumentsToSend);
  }

  void rateOffice(int providerId, double rating) {
    userRatings[providerId] = rating;
    Get.back();
  }
}