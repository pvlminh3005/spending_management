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
    Future<void> Function()? onConfirm,
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
                style: context.caption.copyWith(fontSize: 13),
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
    Future<void> Function(ClassifyModel)? onCreate,
    Future<void> Function(ClassifyModel)? onEdit,
    Future<void> Function()? onDelete,
  }) {
    final BuildContext context = Get.context!;
    final _isLoadingBtn1 = ValueNotifier<bool>(false);
    final _isLoadingBtn2 = ValueNotifier<bool>(false);

    final _titleCtrl = TextEditingController(text: classify?.title);
    final _defaultCtrl = TextEditingController(
        text: classify?.defaultBalance.format.toString() ?? '0');
    final _categoryType =
        ValueNotifier<CategoryType>(classify?.type ?? CategoryType.payment);
    final _haveChanged = ValueNotifier<bool>(false);
    final Color fillColor =
        isEdit ? context.tertiary.withOpacity(.6) : Colors.transparent;

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? 'Chỉnh sửa' : 'Tạo mới',
                  style:
                      context.subtitle1.copyWith(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: Get.back,
                  child: Icon(
                    Icons.close,
                    color: context.onBackground.withOpacity(.5),
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            InputCustom(
              controller: _titleCtrl,
              labelText: 'Tên danh mục (*)',
              isEnabled: !isEdit,
              fillColor: fillColor,
              borderSide: BorderSide(color: context.tertiary),
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _categoryType,
              builder: (BuildContext context, CategoryType value, Widget? _) {
                final bool isCharge = value == CategoryType.charge;
                return InputCustom(
                  controller: _defaultCtrl,
                  labelText: 'Ngân sách dự kiến',
                  isEnabled: !isCharge,
                  fillColor: isCharge
                      ? context.tertiary.withOpacity(.5)
                      : Colors.transparent,
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
                  onChanged: (val) {
                    _haveChanged.value = val.isNotEmpty &&
                        val.formatBalance != classify?.defaultBalance;
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: _categoryType,
              builder: (BuildContext context, CategoryType value, Widget? _) {
                return DropDownCustom(
                  categoryType: value,
                  padding: const EdgeInsets.all(15.0),
                  fillColor: isEdit
                      ? context.tertiary.withOpacity(.6)
                      : Colors.transparent,
                  onChanged: isEdit
                      ? null
                      : (CategoryType? newType) {
                          _categoryType.value = newType!;
                          if (newType == CategoryType.charge) {
                            _defaultCtrl.clear();
                          }
                        },
                );
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _isLoadingBtn1,
                    builder: (BuildContext context, bool value, Widget? _) {
                      return AppButton(
                        isEdit ? 'Xoá' : 'Huỷ',
                        color: context.primary,
                        loading: value,
                        height: 40.0,
                        elevation: 0,
                        borderRadius: 6.0,
                        onPressed: isEdit
                            ? () async {
                                _isLoadingBtn1.value = true;
                                await onDelete?.call();
                                _isLoadingBtn1.value = false;
                              }
                            : Get.back,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _isLoadingBtn2,
                    builder: (BuildContext context, bool isLoading, Widget? _) {
                      return ValueListenableBuilder(
                        valueListenable: _haveChanged,
                        builder: (BuildContext context, bool value, Widget? _) {
                          return AppButton(
                            isEdit ? 'Chỉnh sửa' : 'Xác nhận',
                            height: 40.0,
                            elevation: 0,
                            disabled: !value,
                            loading: isLoading,
                            color: context.secondary,
                            borderRadius: 6.0,
                            onPressed: () async {
                              _isLoadingBtn2.value = true;
                              var data = ClassifyModel(
                                uid: classify?.uid,
                                category: CategoryModel(
                                  title: _titleCtrl.text,
                                  categoryType: _categoryType.value,
                                ),
                                defaultBalance: _defaultCtrl.text.formatBalance,
                              );

                              isEdit
                                  ? await onEdit?.call(data)
                                  : await onCreate?.call(data);

                              _isLoadingBtn2.value = false;
                            },
                          );
                        },
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
