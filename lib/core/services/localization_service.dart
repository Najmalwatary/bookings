import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // ✅ 1. تم التغيير إلى GetStorage

import '../constants/app_strings.dart';

class LocalizationService extends Translations {
  static const String _localeKey = 'locale';
  final _box = GetStorage(); // ✅ 2. إنشاء مثيل من صندوق التخزين

  static const Locale fallbackLocale = Locale('ar', 'SA');

  static const List<Locale> supportedLocales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];

  // ✅ 3. تم تعديل منطق القراءة والكتابة هنا
  Locale get locale => _getLocaleFromStorage();

  Locale _getLocaleFromStorage() {
    // اقرأ اللغة المحفوظة (مثال: 'ar_SA')
    String? savedLocale = _box.read<String>(_localeKey);
    if (savedLocale != null) {
      // إذا كانت هناك لغة محفوظة، قم بتحويلها من نص إلى كائن Locale
      var parts = savedLocale.split('_');
      return Locale(parts[0], parts[1]);
    }
    // إذا لم تكن هناك لغة محفوظة، استخدم اللغة الافتراضية
    return fallbackLocale;
  }

  void saveLocaleToStorage(Locale locale) {
    // احفظ اللغة الجديدة كنص (مثال: 'ar_SA')
    _box.write(_localeKey, locale.toString());
  }
  // --- نهاية التعديل ---

  // لا تغيير هنا، هذه الدوال ستعمل الآن بشكل صحيح
  void changeLocale(Locale locale) {
    Get.updateLocale(locale);
    saveLocaleToStorage(locale);
  }

  void switchLanguage() {
    Locale newLocale = Get.locale?.languageCode == 'ar'
        ? const Locale('en', 'US')
        : const Locale('ar', 'SA');
    changeLocale(newLocale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SA': {
          // App General
          'app_name': AppStrings.appName,

          // Authentication
          'login': AppStrings.login,
          'email': AppStrings.email,
          'password': AppStrings.password,
          'forgot_password': AppStrings.forgotPassword,
          'create_account': AppStrings.createAccount,
          'welcom_creat_your_acount': AppStrings.welcomeCreatYourAcount,
          'enter_your_data': AppStrings.enterYourData,
          'fullName': AppStrings.fullName,
          'phoneNumber': AppStrings.phoneNumber,
          'confirm_password': AppStrings.confirmPassword,
          'have_account': AppStrings.haveAccount,
          'have_account_already': AppStrings.haveAccountAlready,

          // Home
          'welcome': AppStrings.welcome,
          'choose_service': AppStrings.chooseService,
          'discover_best': AppStrings.discoverBestDealsAndServices,
          'services': AppStrings.services,
          'description': AppStrings.description,

          // Services Descriptions
          'flight_booking': AppStrings.flightBooking,
          'book_flight_tickets_best_price':
              AppStrings.bookFlightTicketsBestPrice,
          'umrah_visa': AppStrings.umrahVisa,
          'umrah_visa_best_agencies': AppStrings.umrahVisaBestAgencies,
          'hajj_visa': AppStrings.hajjVisa,
          'hajj_visa_best_agencies': AppStrings.hajjVisaBestAgencies,
          'hotel_visa_best_agencies': AppStrings.hotelVisaBestAgencies,
          'land_visa_best_agencies': AppStrings.landVisaBestAgencies,
          'land_transport': AppStrings.landTransport,
          'hotel_booking': AppStrings.hotelBooking,

          // Flight Booking
          'from': AppStrings.from,
          'to': AppStrings.to,
          'passenger_info': AppStrings.passengerInfo,
          'number_of_passengers': AppStrings.numberOfPassengers,
          'passenger_name': AppStrings.passengerName,
          'passport_number': AppStrings.passportNumber,
          'date_of_birth': AppStrings.dateOfBirth,
          'nationality': AppStrings.nationality,

          // Payment
          'payment': AppStrings.payment,
          'bank_selection': AppStrings.bankSelection,
          'account_number': AppStrings.accountNumber,
          'amount': AppStrings.amount,
          'user_account_number': AppStrings.userAccountNumber,
          'user_password': AppStrings.userPassword,
          'pay_now': AppStrings.payNow,
          'confirm_payment': AppStrings.confirmPayment,
          'payment_successful': AppStrings.paymentSuccessful,
          'booking_confirmed': AppStrings.bookingConfirmed,

          // Settings
          'settings': AppStrings.settings,
          'appearance': AppStrings.appearance,
          'toggle_light_dark': AppStrings.toggleLightDark,
          'light_mode': AppStrings.lightMode,
          'dark_mode': AppStrings.darkMode,
          'language': AppStrings.language,
          'change_app_language': AppStrings.changeAppLanguage,
          'arabic': AppStrings.arabic,
          'english': AppStrings.english,
          'account': AppStrings.account,
          'profile': AppStrings.profile,
          'account_view_edit_label': AppStrings.accountViewEditLabel,
          'soon': AppStrings.soon,
          'feature_coming_soon_message': AppStrings.featureComingSoonMessage,
          'notifications': AppStrings.notifications,
          'notification_settings_management':
              AppStrings.notificationSettingsManagement,
          'security': AppStrings.security,
          'security_and_password_settings':
              AppStrings.securityAndPasswordSettings,
          'support_and_help': AppStrings.supportAndHelp,
          'help': AppStrings.help,
          'faq_and_support': AppStrings.faqAndSupport,
          'feedback_and_rating': AppStrings.feedbackAndRating,
          'share_your_opinion': AppStrings.shareYourOpinion,
          'thank_you': AppStrings.thankYou,
          'thank_you_for_feedback': AppStrings.thankYouForFeedback,
          'legal': AppStrings.legal,
          'privacy_policy': AppStrings.privacyPolicy,
          'view_privacy_policy': AppStrings.viewPrivacyPolicy,
          'terms_of_service': AppStrings.termsOfService,
          'view_terms_of_service': AppStrings.viewTermsOfService,
          'about_app': AppStrings.aboutApp,
          'app_info_and_version': AppStrings.appInfoAndVersion,

          // Common
          'next': AppStrings.next,
          'back': AppStrings.back,
          'cancel': AppStrings.cancel,
          'confirm': AppStrings.confirm,
          'save': AppStrings.save,
          'book': AppStrings.book,
          'select': AppStrings.select,

          // Validation
          'field_required': AppStrings.fieldRequired,
          'invalid_email': AppStrings.invalidEmail,
          'password_too_short': AppStrings.passwordTooShort,
        },
        'en_US': {
          // App General
          'app_name': AppStrings.appNameEn,

          // Authentication
          'login': AppStrings.loginEn,
          'email': AppStrings.emailEn,
          'password': AppStrings.passwordEn,
          'forgot_password': AppStrings.forgotPasswordEn,
          'create_account': AppStrings.createAccountEn,
          'have_account': AppStrings.haveAccountEn,
          'welcom_creat_your_acount': AppStrings.welcomeCreatYourAcountEn,
          'enter_your_data': AppStrings.enterYourDataEn,
          'fullName': AppStrings.fullNameEn,
          'phoneNumber': AppStrings.phoneNumberEn,
          'confirm_password': AppStrings.confirmPasswordEn,
          'have_account_already': AppStrings.haveAccountAlreadyEn,

          // Home
          'welcome': AppStrings.welcomeEn,
          'choose_service': AppStrings.chooseServiceEn,
          'discover_best': AppStrings.discoverBestDealsAndServicesEn,
          'services': AppStrings.servicesEn,
          'description': AppStrings.descriptionEn,

          // Services Descriptions
          'flight_booking': AppStrings.flightBookingEn,
          'book_flight_tickets_best_price':
              AppStrings.bookFlightTicketsBestPriceEn,
          'umrah_visa': AppStrings.umrahVisaEn,
          'umrah_visa_best_agencies': AppStrings.umrahVisaBestAgenciesEn,
          'hajj_visa': AppStrings.hajjVisaEn,
          'hajj_visa_best_agencies': AppStrings.hajjVisaBestAgenciesEn,
          'hotel_visa_best_agencies': AppStrings.hotelVisaBestAgenciesEn,
          'land_visa_best_agencies': AppStrings.landVisaBestAgenciesEn,
          'land_transport': AppStrings.landTransportEn,
          'hotel_booking': AppStrings.hotelBookingEn,

          // Flight Booking
          'from': AppStrings.fromEn,
          'to': AppStrings.toEn,
          'passenger_info': AppStrings.passengerInfoEn,
          'number_of_passengers': AppStrings.numberOfPassengersEn,
          'passenger_name': AppStrings.passengerNameEn,
          'passport_number': AppStrings.passportNumberEn,
          'date_of_birth': AppStrings.dateOfBirthEn,
          'nationality': AppStrings.nationalityEn,

          // Payment
          'payment': AppStrings.paymentEn,
          'bank_selection': AppStrings.bankSelectionEn,
          'account_number': AppStrings.accountNumberEn,
          'amount': AppStrings.amountEn,
          'user_account_number': AppStrings.userAccountNumberEn,
          'user_password': AppStrings.userPasswordEn,
          'pay_now': AppStrings.payNowEn,
          'confirm_payment': AppStrings.confirmPaymentEn,
          'payment_successful': AppStrings.paymentSuccessfulEn,
          'booking_confirmed': AppStrings.bookingConfirmedEn,

          // Settings
          'settings': AppStrings.settingsEn,
          'appearance': AppStrings.appearanceEn,
          'toggle_light_dark': AppStrings.toggleLightDarkModeEn,
          'light_mode': AppStrings.lightModeEn,
          'dark_mode': AppStrings.darkModeEn,
          'language': AppStrings.languageEn,
          'change_app_language': AppStrings.changeAppLanguageEn,
          'arabic': AppStrings.arabicEn,
          'english': AppStrings.englishEn,
          'account': AppStrings.accountEn,
          'profile': AppStrings.profileEn,
          'account_view_edit_label': AppStrings.accountViewEditLabelEn,
          'soon': AppStrings.soonEn,
          'feature_coming_soon_message': AppStrings.featureComingSoonMessageEn,
          'notifications': AppStrings.notificationsEn,
          'notification_settings_management':
              AppStrings.notificationSettingsManagementEn,
          'security': AppStrings.securityEn,
          'security_and_password_settings':
              AppStrings.securityAndPasswordSettingsEn,
          'support_and_help': AppStrings.supportAndHelpEn,
          'help': AppStrings.helpEn,
          'faq_and_support': AppStrings.faqAndSupportEn,
          'feedback_and_rating': AppStrings.feedbackAndRatingEn,
          'share_your_opinion': AppStrings.shareYourOpinionEn,
          'thank_you': AppStrings.thankYouEn,
          'thank_you_for_feedback': AppStrings.thankYouForFeedbackEn,
          'legal': AppStrings.legalEn,
          'privacy_policy': AppStrings.privacyPolicyEn,
          'view_privacy_policy': AppStrings.viewPrivacyPolicyEn,
          'terms_of_service': AppStrings.termsOfServiceEn,
          'view_terms_of_service': AppStrings.viewTermsOfServiceEn,
          'about_app': AppStrings.aboutAppEn,
          'app_info_and_version': AppStrings.appInfoAndVersionEn,

          // Common
          'next': AppStrings.nextEn,
          'back': AppStrings.backEn,
          'cancel': AppStrings.cancelEn,
          'confirm': AppStrings.confirmEn,
          'save': AppStrings.saveEn,
          'book': AppStrings.bookEn,
          'select': AppStrings.selectEn,

          // Validation
          'field_required': AppStrings.fieldRequiredEn,
          'invalid_email': AppStrings.invalidEmailEn,
          'password_too_short': AppStrings.passwordTooShortEn,
        },
      };
}
