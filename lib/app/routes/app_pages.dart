import 'package:admin_cafe_mobile/app/modules/payment/views/payment_ovo_view.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/payment/bindings/loading_payment_binding.dart';
import 'package:admin_cafe_mobile/app/modules/payment/views/loading_payment_view.dart';
import 'package:admin_cafe_mobile/app/modules/payment/views/payment_failed_view.dart';
import 'package:admin_cafe_mobile/app/modules/payment/views/payment_success_view.dart';

import '../modules/authentication/image_profile/bindings/image_profile_binding.dart';
import '../modules/authentication/image_profile/views/image_profile_view.dart';
import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/register/bindings/register_binding.dart';
import '../modules/authentication/register/views/register_view.dart';
import '../modules/banner/bindings/banner_binding.dart';
import '../modules/banner/views/banner_view.dart';
import '../modules/banner/views/form_banner_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/booking/views/form_booking_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_user_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/foodndrink/bindings/foodndrink_binding.dart';
import '../modules/foodndrink/views/foodndrink_view.dart';
import '../modules/foodndrink/views/form_foodndrink_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/change_password_reset_view.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/reset_password/views/verify_token_password_reset_view.dart';
import '../modules/room/bindings/room_binding.dart';
import '../modules/room/views/form_room_view.dart';
import '../modules/room/views/room_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_PROFILE,
      page: () => const ImageProfileView(),
      binding: ImageProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_USER,
      page: () => const DashboardUserView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ROOM,
      page: () => const RoomView(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.BANNER,
      page: () => const BannerView(),
      binding: BannerBinding(),
    ),
    GetPage(
      name: _Paths.FORMBANNER,
      page: () => const FormBannerView(),
      binding: BannerBinding(),
    ),
    GetPage(
      name: _Paths.FORMROOM,
      page: () => const FormRoomView(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.FOODNDRINK,
      page: () => const FoodndrinkView(),
      binding: FoodndrinkBinding(),
    ),
    GetPage(
      name: _Paths.FORMFOODNDRINK,
      page: () => const FormFoodndrinkView(),
      binding: FoodndrinkBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.FORMBOOKING,
      page: () => const FormBookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD_VERIFY,
      page: () => const VerifyTokenPasswordResetView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD_RESET,
      page: () => const ChangePasswordResetView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_LOADING,
      page: () => const LoadingPaymentView(),
      binding: LoadingPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESS,
      page: () => const PaymentSuccessView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_FAILED,
      page: () => const PaymentFailedView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_OVO_MOBILE_PHONE,
      page: () => const PaymentOvoView(),
      binding: PaymentBinding(),
    ),
  ];
}
