import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/appbar_custom.dart';
import '../../../widgets/common/input_custom.dart';
import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final margin = EdgeInsets.symmetric(horizontal: 10.w);
    return Scaffold(
      appBar: const AppBarCustom(title: 'Chi tiêu'),
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
                  MaskTextInputFormatter(mask: "###,###,###,###,###"),
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
              const _TitleBuilder('Phân loại'),
              Padding(
                padding: margin,
                child: Wrap(
                  spacing: 7.w,
                  runSpacing: 7.h,
                  children: List.generate(6, (index) {
                    return _CustomItemType('Lorem ${index * index * index}');
                  }).toList(),
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
            loading: controller.isLoading,
            onPressed: controller.createTransaction,
          ),
        ),
      ),
    );
  }
}

class _TitleBuilder extends StatelessWidget {
  final String title;
  const _TitleBuilder(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.w,
        right: 10.w,
        bottom: 10.h,
      ),
      child: Text(
        title,
        style: context.bodyText2.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CustomItemType extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const _CustomItemType(
    this.title, {
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 20.w,
          ),
          child: Text(
            title,
            style: context.caption.copyWith(fontWeight: FontWeight.w500),
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
        color: Colors.grey.shade200,
        child: SizedBox(
          width: context.width,
          height: 10.h,
        ),
      ),
    );
  }
}
