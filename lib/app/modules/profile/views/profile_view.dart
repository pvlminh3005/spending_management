import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => _ProfileItem(
                icon: controller.isDarkMode
                    ? Icons.dark_mode
                    : Icons.dark_mode_outlined,
                title: controller.isDarkMode ? 'Dark Mode' : 'Light Mode',
                isSwitch: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Divider(color: Colors.grey),
            ),
            _ProfileItem(
              icon: CupertinoIcons.square_arrow_right,
              title: 'Sign out',
              onPressed: controller.signOut,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'v1.0.0',
                  style: context.caption.copyWith(fontSize: 13.sp),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isSwitch;
  final VoidCallback? onPressed;

  const _ProfileItem({
    this.title = '',
    this.icon,
    this.isSwitch = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  ProfileController get controller => Get.find();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(12.0),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 27,
            color: Colors.grey.shade600,
          ),
          Dimensions.width10,
          Text(
            title,
            style: context.bodyText1.copyWith(),
          ),
          const Spacer(),
          if (isSwitch)
            CupertinoSwitch(
              value: controller.isDarkMode,
              onChanged: (value) {
                controller.changeMode();
              },
              activeColor: context.primary,
            ),
        ],
      ),
    );
  }
}
