import 'package:flutter/cupertino.dart';

import '../core/constants/enum.dart';
import '../core/styles/style.dart';

class DropDownCustom extends StatelessWidget {
  final CategoryType categoryType;
  final void Function(CategoryType?)? onChanged;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;

  const DropDownCustom({
    required this.categoryType,
    required this.onChanged,
    this.padding,
    this.fillColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: context.tertiary),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: DropdownButton<CategoryType>(
          elevation: 1,
          value: categoryType,
          isExpanded: true,
          isDense: true,
          icon: const Icon(CupertinoIcons.down_arrow),
          iconSize: 18.sp,
          underline: const SizedBox.shrink(),
          style: context.bodyText2,
          items: <CategoryType>[CategoryType.payment, CategoryType.charge]
              .map((CategoryType value) {
            final bool isSelected = categoryType == value;
            return DropdownMenuItem<CategoryType>(
              value: value,
              child: Text(
                value == CategoryType.payment ? 'Chi tiêu' : 'Thu nhập',
                style: context.bodyText2.copyWith(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
