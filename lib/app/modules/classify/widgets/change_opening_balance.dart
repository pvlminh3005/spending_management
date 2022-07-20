import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/thousand_input_formatter/thousand_input_formatter.dart';
import '../controllers/classify_controller.dart';

class ChangeOpeningBalance extends GetView<ClassifyController> {
  const ChangeOpeningBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(
      text: controller.openingBalance.format,
    );
    final _loading = ValueNotifier(false);
    final _disabled = ValueNotifier(true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputCustom(
          controller: _controller,
          labelText: 'Nhập số tiền',
          hintStyle: context.bodyText2,
          inputType: TextInputType.phone,
          borderSide: const BorderSide(color: Colors.grey),
          inputFormatters: [
            ThousandsFormatter(),
          ],
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
          onChanged: (val) {
            _disabled.value =
                (val == controller.openingBalance.format) || val.isEmpty;
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: _disabled,
          builder: (context, bool disable, _) {
            return ValueListenableBuilder(
              valueListenable: _loading,
              builder: (BuildContext context, bool loading, Widget? child) {
                return AppButton(
                  'Chỉnh sửa',
                  disabled: disable,
                  loading: loading,
                  axisSize: MainAxisSize.max,
                  onPressed: () async {
                    _loading.value = true;
                    try {
                      await controller
                          .onEditOpeningBalance(_controller.text.formatBalance);
                    } catch (e) {
                      rethrow;
                    } finally {
                      _loading.value = false;
                    }
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
