import 'package:booking_app/modules/auth/bindings/auth_binding.dart';
import 'package:booking_app/modules/auth/bindings/sign_up_binding.dart';
import 'package:booking_app/modules/auth/views/register_view.dart';
import 'package:booking_app/modules/data_entry/bindings/data_entry_binding.dart';
import 'package:booking_app/modules/data_entry/views/data_entry_view.dart';
import 'package:booking_app/modules/providers/bindings/offices_binding.dart';
import 'package:booking_app/modules/providers/views/providers_view.dart';
import 'package:get/get.dart';

import '../modules/auth/views/login_view.dart';

import '../modules/home/views/home_view.dart';
import '../modules/flight_booking/views/flight_booking_view.dart';
import '../modules/flight_booking/views/flight_passengers_view.dart';
import '../modules/umrah_hajj_visa/views/umrah_hajj_visa_view.dart';
import '../modules/umrah_hajj_visa/views/umrah_hajj_offices_view.dart';
import '../modules/umrah_hajj_visa/views/umrah_hajj_details_view.dart';
import '../modules/hotel_booking/views/hotel_booking_view.dart';
import '../modules/land_transport_booking/views/land_transport_booking_view.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payment/views/payment_confirmation_view.dart';
import '../modules/settings/views/settings_view.dart';

import '../core/bindings/initial_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => RegisterView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: InitialBinding(),
    ),
    GetPage(name: AppRoutes.FLIGHT_BOOKING, page: () => FlightBookingView()),
    GetPage(
      name: AppRoutes.FLIGHT_PASSENGERS,
      page: () => FlightPassengersView(),
    ),
    GetPage(name: AppRoutes.UMRAH_HAJJ_VISA, page: () => UmrahHajjVisaView()),
    GetPage(
      name: AppRoutes.UMRAH_HAJJ_OFFICES,
      page: () => UmrahHajjOfficesView(),
    ),
    GetPage(
      name: AppRoutes.UMRAH_HAJJ_DETAILS,
      page: () => UmrahHajjDetailsView(),
    ),
    GetPage(name: AppRoutes.HOTEL_BOOKING, page: () => HotelBookingView()),
    GetPage(
      name: AppRoutes.LAND_TRANSPORT_BOOKING,
      page: () => LandTransportBookingView(),
    ),
    GetPage(name: AppRoutes.PAYMENT, page: () => PaymentView()),
    GetPage(
      name: AppRoutes.PAYMENT_CONFIRMATION,
      page: () => PaymentConfirmationView(),
    ),
    GetPage(name: AppRoutes.SETTINGS, page: () => SettingsView()),
    GetPage(
      name: AppRoutes.providers,
      page: () => ProvidersView(),
      binding: ProvidersBinding(),
    ),
    GetPage(
      name: AppRoutes.dataEntry,
      page: () => const DataEntryView(),
      binding: DataEntryBinding(),
    ),
  ];
}
