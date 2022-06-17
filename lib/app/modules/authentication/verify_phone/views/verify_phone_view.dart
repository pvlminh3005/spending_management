import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../widgets/common/app_button.dart';
import '../../../../widgets/counter_time/counter_time.dart';
import '../controllers/verify_phone_controller.dart';

const _height = 48.0;

class VerifyPhoneView extends GetView<VerifyPhoneController> {
  const VerifyPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: context.primary),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              ImageUtils.waitingPlaneIcon,
              width: 200.w,
              height: 200.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  text: TextSpan(
                    text: StringUtils.announceOTP,
                    style: context.subtitle1.copyWith(fontSize: 16.sp),
                    children: [
                      TextSpan(
                        text: controller.yourPhone,
                        style: context.subtitle2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Pinput(
                controller: controller.verifyController,
                length: 6,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinAnimationType: PinAnimationType.fade,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.phone,
                onChanged: (value) => controller.onChange(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    StringUtils.noHaveOTP,
                    style: context.bodyText2.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Dimensions.width5,
                  Obx(
                    () {
                      if (controller.isResend) {
                        return SizedBox(
                          height: 48,
                          child: Center(
                            child: CounterTime(
                              onTimeEnd: controller.timeEnd,
                              style: context.bodyText1.copyWith(
                                fontSize: 14.sp,
                                color: context.primary,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return AppButton(
                          StringUtils.resend,
                          type: ButtonType.text,
                          fontSize: 14.sp,
                          textColor: context.primary,
                          padding: EdgeInsets.zero,
                          color: Colors.blue,
                          height: _height,
                          loading: controller.isLoading,
                          onPressed: controller.resendOTP,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Obx(
              () => AppButton(
                StringUtils.verify,
                height: _height,
                fontSize: 15.sp,
                axisSize: MainAxisSize.max,
                loading: controller.isLoading,
                disabled: controller.disabled,
                onPressed: controller.verifyOTP,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
