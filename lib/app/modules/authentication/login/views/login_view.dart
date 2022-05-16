import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/image_utils.dart';
import '../../../../widgets/common/app_button.dart';
import '../../../../widgets/common/input_custom.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageUtils.mainIconApp,
                width: 250,
                height: 250,
              ),
              Dimensions.height20,
              Text(
                'Welcome to Spending Management App',
                style: TextStyle(
                  fontSize: 32,
                  color: context.primary,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              Dimensions.height95,
              InputCustom(
                controller: controller.phoneController,
                hintSize: 17,
                isShowPrefixIcon: true,
                prefixIcon: Image.asset(ImageUtils.vnFlag),
                hintText: '(+84) 0000 000 000',
                fontWeight: FontWeight.w600,
                borderSide: const BorderSide(color: Colors.grey),
                contentPadding: const EdgeInsets.all(22.0),
                inputFormatters: [
                  MaskTextInputFormatter(mask: "#### ### ###"),
                ],
                inputType: TextInputType.phone,
                spacing: 1.05,
                onChanged: controller.onChangedInput,
              ),
              Dimensions.height20,
              Obx(
                () => AppButton(
                  'Login',
                  height: 55,
                  axisSize: MainAxisSize.max,
                  disabled: controller.disabled,
                  onPressed: controller.submitForm,
                ),
              ),
              Dimensions.height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Haven\'t account yet?'),
                  AppButton(
                    'Register here',
                    type: ButtonType.text,
                    textColor: context.primary,
                    onPressed: controller.toRegister,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Copyright 2022 by Amo 💕',
          style: context.caption,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
