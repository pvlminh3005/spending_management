import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/statistic_card.dart';
import '../controllers/paybook_controller.dart';

class PaybookView extends GetView<PaybookController> {
  const PaybookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Column(
        children: [
          StatisticCard(),
          Dimensions.height20,
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: InputCustom(
                      fillColor: Colors.grey.shade200,
                      borderSide: const BorderSide(color: Colors.transparent),
                      hintText: 'Tìm giao dịch',
                      isShowPrefixIcon: true,
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        size: 25,
                      ),
                      radius: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
