import 'package:get/get.dart';

import '../../widgets/common/app_button.dart';
import '../styles/style.dart';
import 'utilities.dart';

class LayoutUtils {
  LayoutUtils._();

  static void dialogMessage({
    required String title,
    String? subtitle,
    Future Function()? onConfirm,
  }) {
    final _isLoading = ValueNotifier(false);
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, textAlign: TextAlign.center),
            if (subtitle != null)
              Text(
                subtitle,
                style: Get.context!.caption,
                textAlign: TextAlign.center,
              ),
            Dimensions.height20,
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: _isLoading,
                  builder: (ctx, bool val, _) {
                    return Flexible(
                      child: AppButton(
                        StringUtils.accept,
                        height: 45,
                        elevation: 1,
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
                    height: 45,
                    elevation: 1,
                    color: Colors.grey,
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
}
