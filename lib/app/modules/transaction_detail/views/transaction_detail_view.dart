import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/appbar_custom.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/list_classify_title_widget.dart';
import '../../../widgets/thousand_input_formatter/thousand_input_formatter.dart';
import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor =
        controller.currentTransactionType == TransactionType.payment
            ? context.error
            : context.secondary;
    final margin = EdgeInsets.symmetric(horizontal: 10.w);
    return Scaffold(
      appBar: AppBarCustom(
        title: controller.currentTransactionType == TransactionType.payment
            ? 'Chi tiêu'
            : 'Thu nhập',
        onPressed: () => Get.back(result: false),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DividerCustom(margin: EdgeInsets.only(bottom: 15)),
              Padding(
                padding: margin,
                child: InkWell(
                  onTap: () => controller.chooseDate(context),
                  child: InputCustom(
                    controller: controller.dateController,
                    isShowPrefixIcon: true,
                    isEnabled: false,
                    prefixIcon: Icon(
                      CupertinoIcons.calendar,
                      size: 24.w,
                    ),
                    borderSide: const BorderSide(color: Colors.grey),
                    labelText: 'Chọn ngày',
                  ),
                ),
              ),
              const _DividerCustom(),
              InputCustom(
                controller: controller.balanceController,
                margin: margin,
                labelText: 'Nhập số tiền',
                hintStyle: context.bodyText2,
                inputType: TextInputType.number,
                borderSide: const BorderSide(color: Colors.grey),
                inputFormatters: [
                  ThousandsFormatter(),
                ],
                validator: Validator.validateAll([
                  BalanceValidator(StringUtils.errorBalance),
                ]),
                isShowSuffixIcon: true,
                isClear: false,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '₫',
                    style: context.subtitle1.copyWith(
                      fontSize: 20.sp,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
              const _DividerCustom(),
              Padding(
                padding: margin,
                child: Obx(
                  () => ListClassifyTitleWidget(
                    listCategories: controller.listCategories,
                    currentCategory: controller.currentCategory,
                    selectedColor: _primaryColor,
                    onSelected: controller.selectedCategory,
                  ),
                ),
              ),
              const _DividerCustom(),
              InputCustom(
                controller: controller.descriptionController,
                margin: margin,
                inputType: TextInputType.multiline,
                labelText: 'Nhập mô tả',
                borderSide: const BorderSide(color: Colors.grey),
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.h),
        child: Obx(
          () => AppButton(
            controller.titleButton,
            color: _primaryColor,
            loading: controller.isLoading,
            disabled: controller.isDisable,
            onPressed: controller.toggleTransaction,
          ),
        ),
      ),
    );
  }
}

class _DividerCustom extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  const _DividerCustom({
    this.margin = const EdgeInsets.symmetric(vertical: 15),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ColoredBox(
        color: context.dividerColor,
        child: SizedBox(
          width: context.width,
          height: 10,
        ),
      ),
    );
  }
}
