import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          _buildSectionHeader('appearance'.tr),
          _buildSettingsTile(
            icon: Icons.brightness_6,
            title: 'appearance'.tr,
            subtitle: 'toggle_light_dark'.tr, // كانت 'toggleLight'.tr
            trailing: Obx(
              () => Switch(
                value: controller.isDarkMode,
                onChanged: (value) => controller.toggleTheme(),
                activeColor: AppColors.primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Language Section
          _buildSectionHeader('language'.tr),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'language'.tr,
            subtitle: 'change_app_language'.tr, // كانت 'changeAppLanguage'.tr
            trailing: Obx(
              () => DropdownButton<String>(
                value: controller.isArabic ? 'ar' : 'en',
                underline: Container(),
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.toggleLanguage();
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Account Section
         _buildSectionHeader('account'.tr),
          _buildSettingsTile(
            icon: Icons.person,
            title: 'profile'.tr,
            // *** تم التعديل هنا ***
            subtitle: 'account_view_edit_label'.tr, // كانت 'accountViewEditLabel'.tr
            onTap: () {
              Get.snackbar(
                'soon'.tr,
                // *** تم التعديل هنا ***
                'feature_coming_soon_message'.tr, // كانت 'featureComingSoonMessage'.tr
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
          _buildSettingsTile(
            icon: Icons.notifications,
            // *** تم التعديل هنا ***
            title: 'notifications'.tr, // كانت 'notification'.tr
            // *** تم التعديل هنا ***
            subtitle: 'notification_settings_management'.tr, // كانت 'notificationSettingsManagement'.tr
            onTap: () {
              Get.snackbar(
                'soon'.tr,
                // *** تم التعديل هنا ***
                'feature_coming_soon_message'.tr, // كانت 'featureComingSoonMessage'.tr
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
          _buildSettingsTile(
            icon: Icons.security,
            title: 'security'.tr,
            // *** تم التعديل هنا ***
            subtitle: 'security_and_password_settings'.tr, // كانت 'securityAndPasswordSettings'.tr
            onTap: () {
              Get.snackbar(
                'soon'.tr,
                // *** تم التعديل هنا ***
                'feature_coming_soon_message'.tr, // كانت 'featureComingSoonMessage'.tr
                snackPosition: SnackPosition.TOP,
              );
            },
          ),

          const SizedBox(height: 20),

          // Support Section
          _buildSectionHeader('support_and_help'.tr), // كانت 'supportAndHelp'.tr
          _buildSettingsTile(
            icon: Icons.help,
            title: 'help'.tr,
            // *** تم التعديل هنا ***
            subtitle: 'faq_and_support'.tr, // كانت 'faqAndSupport'.tr
            onTap: () {
              Get.snackbar(
                'soon'.tr,
                // *** تم التعديل هنا ***
                'feature_coming_soon_message'.tr, // كانت 'featureComingSoonMessage'.tr
                snackPosition: SnackPosition.TOP,
              );
            },
          ),
          _buildSettingsTile(
            icon: Icons.feedback,
            // *** تم التعديل هنا ***
            title: 'feedback_and_rating'.tr, // كانت 'feedbackAndRating'.tr
            // *** تم التعديل هنا ***
            subtitle: 'share_your_opinion'.tr, // كانت 'shareYourOpinion'.tr
            onTap: () {
              Get.snackbar(
                'thank_you'.tr, // كانت 'thankYou'.tr
                // *** تم التعديل هنا ***
                'thank_you_for_feedback'.tr, // كانت 'thankYouForFeedback'.tr
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
          ),

          const SizedBox(height: 20),

          // Legal Section
          _buildSectionHeader('legal'.tr),
          _buildSettingsTile(
            icon: Icons.privacy_tip,
            // *** تم التعديل هنا ***
            title: 'privacy_policy'.tr, // كانت 'privacyPolicy'.tr
            // *** تم التعديل هنا ***
            subtitle: 'view_privacy_policy'.tr, // كانت 'viewPrivacyPolicy'.tr
            onTap: controller.showPrivacyPolicy,
          ),
          _buildSettingsTile(
            icon: Icons.description,
            // *** تم التعديل هنا ***
            title: 'terms_of_service'.tr, // كانت 'termsOfService'.tr
            // *** تم التعديل هنا ***
            subtitle: 'view_terms_of_service'.tr, // كانت 'viewTermsOfService'.tr
            onTap: controller.showTermsOfService,
          ),
          _buildSettingsTile(
            icon: Icons.info,
            // *** تم التعديل هنا ***
            title: 'about_app'.tr, // كانت 'aboutApp'.tr
            // *** تم التعديل هنا ***
            subtitle: 'app_info_and_version'.tr, // كانت 'appInfoAndVersion'.tr
            onTap: controller.showAboutDialog,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondaryColor,
            fontFamily: 'Cairo',
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
