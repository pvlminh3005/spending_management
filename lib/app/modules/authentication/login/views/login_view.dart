import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../widgets/common/app_button.dart';
import '../../../../widgets/common/input_custom.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageUtils.mainIconApp,
                  width: 200.w,
                  height: 200.w,
                ),
                Dimensions.height20,
                Text(
                  StringUtils.welcomeApp,
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: context.primary,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 75),
                InputCustom(
                  controller: controller.phoneController,
                  hintSize: 14.sp,
                  isShowPrefixIcon: true,
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(ImageUtils.vnFlag),
                      Dimensions.width5,
                      Text(
                        StringUtils.countryVNCode,
                        style: context.bodyText1.copyWith(
                          fontSize: context.bodyText1.fontSize?.sp,
                        ),
                      ),
                    ],
                  ),
                  hintText: StringUtils.inputPhone,
                  hintStyle: context.caption.copyWith(fontSize: 15.sp),
                  fontWeight: FontWeight.w600,
                  borderSide: const BorderSide(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(22.0),
                  inputFormatters: [
                    MaskTextInputFormatter(mask: "### ### ####"),
                  ],
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.done,
                  spacing: 1.05,
                  validator: Validator.validateAll([
                    PhoneValidator(StringUtils.validPhone),
                  ]),
                  maxLength: maxLength,
                  onChanged: controller.onChangedInput,
                ),
                Dimensions.height20,
                Obx(
                  () => AppButton(
                    StringUtils.signIn,
                    height: 45.h,
                    axisSize: MainAxisSize.max,
                    loading: controller.isLoading,
                    disabled: controller.disabled,
                    onPressed: controller.signIn,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringUtils.noAccount,
                      style: context.bodyText2.copyWith(fontSize: 14.sp),
                    ),
                    AppButton(
                      StringUtils.signUpHere,
                      type: ButtonType.text,
                      fontSize: 14.sp,
                      textColor: context.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: Text(
          StringUtils.copyrightBy,
          style: context.caption.copyWith(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
