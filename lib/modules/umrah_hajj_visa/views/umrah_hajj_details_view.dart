import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../routes/app_routes.dart';

class UmrahHajjDetailsView extends StatefulWidget {
  const UmrahHajjDetailsView({super.key});

  @override
  _UmrahHajjDetailsViewState createState() => _UmrahHajjDetailsViewState();
}

class _UmrahHajjDetailsViewState extends State<UmrahHajjDetailsView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passportController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final nationalityController = TextEditingController();
  final addressController = TextEditingController();

  Map<String, dynamic>? office;
  String? service;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    office = args?['office'];
    service = args?['service'];
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passportController.dispose();
    dateOfBirthController.dispose();
    nationalityController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (office == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطأ')),
        body: const Center(child: Text('لم يتم العثور على بيانات المكتب')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(office!['name'])),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Office Info Header
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
                    office!['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLightColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'السعر: ${office!['price'].toStringAsFixed(0)} ريال',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // Form Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بيانات المتقدم',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                        fontFamily: 'Cairo',
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Full Name
                    CustomTextField(
                      labelText: 'الاسم الكامل',
                      hintText: 'أدخل الاسم كما هو في جواز السفر',
                      controller: nameController,
                      validator: _validateRequired,
                      prefixIcon: const Icon(Icons.person),
                    ),

                    const SizedBox(height: 16),

                    // Phone Number
                    CustomTextField(
                      labelText: 'رقم الهاتف',
                      hintText: 'أدخل رقم الهاتف',
                      controller: phoneController,
                      validator: _validateRequired,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone),
                    ),

                    const SizedBox(height: 16),

                    // Email
                    CustomTextField(
                      labelText: 'البريد الإلكتروني',
                      hintText: 'أدخل البريد الإلكتروني',
                      controller: emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),

                    const SizedBox(height: 16),

                    // Passport Number
                    CustomTextField(
                      labelText: 'رقم جواز السفر',
                      hintText: 'أدخل رقم جواز السفر',
                      controller: passportController,
                      validator: _validatePassport,
                      prefixIcon: const Icon(Icons.credit_card),
                    ),

                    const SizedBox(height: 16),

                    // Date of Birth
                    CustomTextField(
                      labelText: 'تاريخ الميلاد',
                      hintText: 'اختر تاريخ الميلاد',
                      controller: dateOfBirthController,
                      validator: _validateRequired,
                      prefixIcon: const Icon(Icons.calendar_today),
                      enabled: false,
                      onTap: _selectDateOfBirth,
                    ),

                    const SizedBox(height: 16),

                    // Nationality
                    CustomTextField(
                      labelText: 'الجنسية',
                      hintText: 'أدخل الجنسية',
                      controller: nationalityController,
                      validator: _validateRequired,
                      prefixIcon: const Icon(Icons.flag),
                    ),

                    const SizedBox(height: 16),

                    // Address
                    CustomTextField(
                      labelText: 'العنوان',
                      hintText: 'أدخل العنوان الكامل',
                      controller: addressController,
                      validator: _validateRequired,
                      maxLines: 3,
                      prefixIcon: const Icon(Icons.location_on),
                    ),

                    const SizedBox(height: 30),

                    // Terms and Conditions
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.infoColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.infoColor.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info,
                                color: AppColors.infoColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'ملاحظات مهمة',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.infoColor,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• يرجى التأكد من صحة جميع البيانات المدخلة\n'
                            '• يجب أن يكون جواز السفر ساري المفعول لمدة 6 أشهر على الأقل\n'
                            '• سيتم التواصل معك خلال 24 ساعة لتأكيد الحجز\n'
                            '• الأسعار شاملة جميع الرسوم والضرائب',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.infoColor,
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

            // Proceed Button
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: 'المتابعة للدفع',
                onPressed: _proceedToPayment,
                width: double.infinity,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (!GetUtils.isEmail(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  String? _validatePassport(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (value.length < 6) {
      return 'رقم جواز السفر قصير جداً';
    }
    return null;
  }

  void _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateOfBirthController.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void _proceedToPayment() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Collect applicant data
    Map<String, String> applicantData = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'passport': passportController.text,
      'dateOfBirth': dateOfBirthController.text,
      'nationality': nationalityController.text,
      'address': addressController.text,
    };

    // Navigate to payment
    Get.toNamed(
      AppRoutes.PAYMENT,
      arguments: {
        'service': service == 'umrah' ? 'umrah_visa' : 'hajj_visa',
        'passengers': [applicantData], // Single applicant
        'amount': office!['price'].toDouble(),
        'office': office,
      },
    );
  }
}
