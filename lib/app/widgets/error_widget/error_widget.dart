import 'package:flutter/material.dart';

import '../../core/utilities/utilities.dart';

class ErrorCustomWidget extends StatelessWidget {
  final double? width, height;
  const ErrorCustomWidget({
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImageUtils.errorImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
