// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';

import '../../../core/styles/style.dart';
import '../../../widgets/common/input_custom.dart';

class FromToDateWidget extends StatelessWidget {
  const FromToDateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _DateTimeCustom(title: 'Từ ngày'),
        SizedBox(height: 15.h),
        const _DateTimeCustom(title: 'Đến ngày'),
      ],
    );
  }
}

class _DateTimeCustom extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(DateTime?)? onPressed;

  const _DateTimeCustom({
    required this.title,
    this.controller,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.caption.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5.h),
        InkWell(
          onTap: () async {
            var data = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(dateNow.year - 1),
              lastDate: DateTime(dateNow.year + 1),
            );

            onPressed?.call(data);
          },
          borderRadius: BorderRadius.circular(4),
          child: InputCustom(
            controller: controller,
            borderSide: const BorderSide(color: Colors.grey),
            isShowPrefixIcon: true,
            isEnabled: false,
            prefixIcon: Icon(
              CupertinoIcons.calendar,
              color: Colors.grey,
              size: 23.w,
            ),
          ),
        ),
      ],
    );
  }
}
