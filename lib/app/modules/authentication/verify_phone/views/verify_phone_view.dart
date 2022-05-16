import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../widgets/common/app_button.dart';
import '../controllers/verify_phone_controller.dart';

class VerifyPhoneView extends GetView<VerifyPhoneController> {
  const VerifyPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageUtils.waitingPlaneIcon,
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: RichText(
                  text: TextSpan(
                    text: 'You will get a OTP via SMS: ',
                    style: context.subtitle1,
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
              Pinput(
                controller: controller.verifyController,
                length: 6,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinAnimationType: PinAnimationType.fade,
                onChanged: (value) => controller.onChange(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Didn't receive a OTP?",
                      style: context.bodyText2.copyWith(color: Colors.grey),
                    ),
                    Dimensions.width5,
                    AppButton(
                      'Resend OTP',
                      type: ButtonType.text,
                      textColor: context.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Obx(
                () => AppButton(
                  'Verify',
                  height: 55,
                  axisSize: MainAxisSize.max,
                  loading: controller.isLoading,
                  disabled: controller.disabled,
                  onPressed: controller.verifyOTP,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
