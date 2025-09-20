// ملف: lib/app/modules/payment/controllers/payment_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../routes/app_routes.dart';

class PaymentController extends GetxController {
  // --- 1. الخصائص والمتغيرات (تم الحفاظ عليها وتصحيحها ) ---
  final formKey = GlobalKey<FormState>();
  final userAccountController = TextEditingController();
  final userPasswordController = TextEditingController();

  final List<Map<String, dynamic>> banks = [
    {'id': 1, 'name': 'البنك الأهلي السعودي'},
    {'id': 2, 'name': 'بنك الراجحي'},
    {'id': 3, 'name': 'بنك ساب'},
    {'id': 4, 'name': 'البنك السعودي للاستثمار'},
    {'id': 5, 'name': 'بنك الرياض'},
  ];

  // --- بداية منطقة التصحيح ---
  // التعريف الصحيح للمتغيرات التفاعلية (Rx)
  final Rxn<int> _selectedBankId = Rxn<int>();
  final RxString _companyAccountNumber = ''.obs;
  // --- نهاية منطقة التصحيح ---
  final RxBool isDataLoaded = false.obs;
  final _isLoading = false.obs;
  final _isPasswordVisible = false.obs;
  final isFetchingAccount = false.obs;

  // Getters الصحيحة التي تقرأ فقط من المتغيرات التفاعلية
  int? get selectedBankId => _selectedBankId.value;
  String get companyAccountNumber => _companyAccountNumber.value;
  bool get isLoading => _isLoading.value;
  bool get isPasswordVisible => _isPasswordVisible.value;

  // --- 2. متغيرات البيانات (تم الحفاظ عليها) ---
  late int userId;
  late int serviceId;
  late String serviceName;
  late int passengerCount;
  late double totalAmount;
  late String passengersNames;

  @override
  void onInit() {
    super.onInit();
    _loadDataFromArguments();
  }

  @override
  void onClose() {
    userAccountController.dispose();
    userPasswordController.dispose();
    super.onClose();
  }

  // --- 3. دالة تحميل البيانات (تم الحفاظ عليها) ---
  void _loadDataFromArguments() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    userId = args['user_id'] ?? 0;
    serviceId = args['service_id'] ?? 0;
    serviceName = args['service_name'] ?? 'خدمة غير محددة';
    passengerCount = args['passenger_count'] ?? 0;
    totalAmount = (args['total_amount'] as num?)?.toDouble() ?? 0.0;
    List<String> passengerList = List<String>.from(
      args['passengers_names'] ?? [],
    );
    passengerCount = passengerList.length;
    passengersNames = passengerList.join(', ');
    isDataLoaded.value = true;
  }

  // --- 4. دوال الاتصال بالـ API (تم تصحيحها) ---
  Future<void> onBankSelected(int? bankId) async {
    if (bankId == null) return;

    // --- بداية منطقة التصحيح ---
    // التعديل الصحيح لقيمة المتغير التفاعلي
    _selectedBankId.value = bankId;
    isFetchingAccount.value = true;
    _companyAccountNumber.value = '...جاري التحميل';
    // --- نهاية منطقة التصحيح ---

    try {
      final url = Uri.parse(
        'http://192.168.0.100/booking_api/get_company_account.php',
      );
      final response = await http
          .post(url, body: {'bank_id': bankId.toString()})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success'] == true) {
          _companyAccountNumber.value = result['account_number'];
        } else {
          _companyAccountNumber.value = 'حساب غير متوفر';
        }
      } else {
        _companyAccountNumber.value = 'خطأ في الاتصال بالخادم';
      }
    } catch (e) {
      _companyAccountNumber.value = 'خطأ في الشبكة';
    } finally {
      isFetchingAccount.value = false;
    }
  }

  Future<void> processFinalPayment() async {
    Get.back();
    _isLoading.value = true;

    try {
      final url = Uri.parse(
        'http://192.168.0.100/booking_api/process_payment.php',
      );
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: json.encode({
              'user_id': userId,
              'service_id': serviceId,
              'bank_id': selectedBankId,
              'user_account_number': userAccountController.text,
              'user_password': userPasswordController.text,
              'amount': totalAmount,
              'service_name': serviceName,
              'passengers_count': passengerCount,
              'passengers_names': passengersNames,
            }),
          )
          .timeout(const Duration(seconds: 20));

      final result = json.decode(response.body);

      if (result['success'] == true) {
        Get.offAllNamed(
          AppRoutes.PAYMENT_CONFIRMATION,
          arguments: {
            'booking_id': result['booking_id'],
            'service_name': serviceName,
            'passenger_count': passengerCount,
            'bank_name': banks.firstWhere(
              (b) => b['id'] == selectedBankId,
            )['name'],
            'total_amount': totalAmount,
            'booking_date': DateTime.now(),
          },
        );
      } else {
        throw Exception(result['message'] ?? 'حدث خطأ غير معروف');
      }
    } catch (e) {
      Get.snackbar(
        'فشل عملية الدفع',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // --- 5. الدوال المساعدة (تم تصحيحها) ---
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
    if (value.length < 10) return 'رقم الحساب يجب أن يكون 10 أرقام على الأقل';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
    return null;
  }

  void showPaymentConfirmation() {
    if (!formKey.currentState!.validate()) return;
    if (selectedBankId == null) {
      Get.snackbar('خطأ', 'يرجى اختيار البنك أولاً.');
      return;
    }
    if (companyAccountNumber.isEmpty ||
        companyAccountNumber.contains('غير') ||
        companyAccountNumber.contains('خطأ')) {
      Get.snackbar('خطأ', 'لا يمكن المتابعة، رقم حساب الشركة غير متوفر.');
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد الدفع', style: TextStyle(fontFamily: 'Cairo')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'البنك: ${banks.firstWhere((b) => b['id'] == selectedBankId)['name']}',
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 8),
            Text(
              'رقم حساب الشركة: $companyAccountNumber',
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 8),
            Text(
              'المبلغ: ${totalAmount.toStringAsFixed(2)} ريال',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: processFinalPayment,
            child: const Text(
              'تأكيد الدفع',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
