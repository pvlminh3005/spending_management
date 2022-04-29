import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/paybook/bindings/paybook_binding.dart';
import '../modules/paybook/views/paybook_view.dart';
import '../modules/revenue_expenditure/bindings/revenue_expenditure_binding.dart';
import '../modules/revenue_expenditure/views/revenue_expenditure_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.payBook,
      page: () => const PaybookView(),
      binding: PaybookBinding(),
    ),
    GetPage(
      name: _Paths.revenueExpenditure,
      page: () => const RevenueExpenditureView(),
      binding: RevenueExpenditureBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
