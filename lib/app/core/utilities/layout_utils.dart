import 'package:get/get.dart';

import '../../data/models/category_model.dart';
import '../../data/models/classify_model.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/input_custom.dart';
import '../../widgets/dropdown_custom.dart';
import '../../widgets/thousand_input_formatter/thousand_input_formatter.dart';
import '../constants/enum.dart';
import '../styles/style.dart';
import 'utilities.dart';

class LayoutUtils {
  LayoutUtils._();

  static void dialogMessage({
    required String title,
    String? subtitle,
    Future Function()? onConfirm,
  }) {
    final BuildContext context = Get.context!;
    final _isLoading = ValueNotifier(false);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        title: Text(title, textAlign: TextAlign.center),
        titleTextStyle: context.bodyText1.copyWith(fontSize: 15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (subtitle != null) ...[
              Text(
                subtitle,
                style: context.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
            ],
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: _isLoading,
                  builder: (ctx, bool val, _) {
                    return Flexible(
                      child: AppButton(
                        StringUtils.accept,
                        height: 40,
                        elevation: 0.0,
                        loading: val,
                        axisSize: MainAxisSize.max,
                        onPressed: () async {
                          _isLoading.value = true;
                          await onConfirm?.call();
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
                Dimensions.width10,
                Flexible(
                  child: AppButton(
                    StringUtils.cancel,
                    textColor: context.onBackground,
                    height: 40,
                    elevation: 0.0,
                    color: context.tertiary,
                    axisSize: MainAxisSize.max,
                    onPressed: Get.back,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void openBottomSheet({
    bool isEdit = false,
    final ClassifyModel? classify,
    Function(ClassifyModel)? onPressed,
    VoidCallback? onDelete,
  }) {
    final BuildContext context = Get.context!;
    final bool isCharge = classify?.type == CategoryType.charge;

    final _titleCtrl = TextEditingController(text: classify?.title);
    final _defaultCtrl = TextEditingController(
        text: isCharge
            ? null
            : classify?.defaultBalance.format.toString() ?? '0');
    final _categoryType =
        ValueNotifier<CategoryType>(classify?.type ?? CategoryType.payment);

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Chỉnh sửa' : 'Tạo mới',
              style: context.subtitle1.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            InputCustom(
              controller: _titleCtrl,
              labelText: 'Tên danh mục (*)',
              borderSide: BorderSide(color: context.tertiary),
            ),
            const SizedBox(height: 15),
            InputCustom(
              controller: _defaultCtrl,
              labelText: 'Ngân sách dự kiến',
              // isEnabled: !isCharge,
              // fillColor: isCharge ? context.tertiary : Colors.transparent,
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
              borderSide: BorderSide(color: context.tertiary),
              inputType: TextInputType.number,
              inputFormatters: [ThousandsFormatter()],
              validator: Validator.validateAll([
                BalanceValidator(StringUtils.errorCategory),
              ]),
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _categoryType,
              builder: (BuildContext context, CategoryType value, Widget? _) {
                return DropDownCustom(
                  categoryType: value,
                  padding: const EdgeInsets.all(15.0),
                  onChanged: (CategoryType? newType) {
                    _categoryType.value = newType!;
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    isEdit ? 'Xoá' : 'Huỷ',
                    color: const Color(0xFFf1f2f6),
                    height: 40.0,
                    textColor: const Color(0xFF2f3542),
                    elevation: 0,
                    borderRadius: 6.0,
                    onPressed: isEdit ? onDelete : Get.back,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    isEdit ? 'Chỉnh sửa' : 'Xác nhận',
                    height: 40.0,
                    elevation: 0,
                    borderRadius: 6.0,
                    onPressed: () {
                      onPressed?.call(
                        ClassifyModel(
                          category: CategoryModel(
                            title: _titleCtrl.text,
                            categoryType: _categoryType.value,
                          ),
                          defaultBalance: _defaultCtrl.text.formatBalance,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
