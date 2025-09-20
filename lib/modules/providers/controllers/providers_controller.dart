import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../data/models/provider_model.dart';
import '../../../routes/app_routes.dart';

class ProvidersController extends GetxController {
  // --- المتغيرات الأصلية (تبقى كما هي ) ---
  final RxList<ProviderModel> _allProviders = <ProviderModel>[].obs;
  final RxList<ProviderModel> displayedProviders = <ProviderModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxMap<int, double> userRatings = <int, double>{}.obs;

  // متغير للاحتفاظ ببيانات الخدمة المستلمة
  late Map<String, dynamic> receivedServiceData;

  @override
  void onInit() {
    super.onInit();
    // استقبال البيانات كـ Map
    receivedServiceData = Get.arguments as Map<String, dynamic>;
    final String? serviceType = receivedServiceData['service_type'] as String?;

    print("==============================================");
    print("بيانات الخدمة المستلمة هي: $receivedServiceData");
    print("==============================================");

    _fetchAndFilterProviders(serviceType);
  }

  Future<void> _fetchAndFilterProviders(String? serviceType) async {
    try {
      isLoading.value = true;
      // !! تأكد من أن هذا الـ IP صحيح لجهازك !!
      final url = Uri.parse(
        'http://192.168.0.100/booking_api/get_providers.php',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          final providers = data
              .map((d) => ProviderModel.fromJson(d as Map<String, dynamic>))
              .toList();

          _allProviders.assignAll(providers);

          if (serviceType == null ||
              serviceType.isEmpty ||
              serviceType == 'الكل') {
            displayedProviders.assignAll(_allProviders);
          } else {
            final filteredList = _allProviders
                .where((provider) => provider.type == serviceType)
                .toList();
            displayedProviders.assignAll(filteredList);
          }
        } else {
          throw Exception('API response format error');
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

  // دالة جديدة ومهمة للانتقال إلى صفحة إدخال البيانات
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

  // دالة التقييم (تبقى كما هي)
  void rateOffice(int providerId, double rating) {
    userRatings[providerId] = rating;
    Get.back();
  }
}
