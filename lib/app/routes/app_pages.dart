import 'package:get/get.dart';

import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/register/bindings/register_binding.dart';
import '../modules/authentication/register/views/register_view.dart';
import '../modules/authentication/verify_phone/bindings/verify_phone_binding.dart';
import '../modules/authentication/verify_phone/views/verify_phone_view.dart';
import '../modules/charge_manage/bindings/charge_manage_binding.dart';
import '../modules/classify/bindings/classify_binding.dart';
import '../modules/classify_detail/bindings/classify_detail_binding.dart';
import '../modules/classify_detail/views/classify_detail_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/filter/bindings/filter_binding.dart';
import '../modules/filter/views/filter_view.dart';
import '../modules/payment_manage/bindings/payment_manage_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/transaction_detail/bindings/transaction_detail_binding.dart';
import '../modules/transaction_detail/views/transaction_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      bindings: [
        PaymentManageBinding(),
        ChargeManageBinding(),
        ClassifyBinding(),
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.verifyPhone,
      page: () => const VerifyPhoneView(),
      binding: VerifyPhoneBinding(),
    ),
    GetPage(
      name: _Paths.filter,
      page: () => const FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: _Paths.transactionDetail,
      page: () => const TransactionDetailView(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: _Paths.classifyDetail,
      page: () => const ClassifyDetailView(),
      binding: ClassifyDetailBinding(),
    ),
  ];
}
