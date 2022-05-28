import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/indicators/loading_indicator.dart';
import '../../../widgets/spending_manage_item.dart';
import '../controllers/charge_manage_controller.dart';

class ChargeManageView extends GetView<ChargeManageController> {
  const ChargeManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: controller.obx(
              (state) {
                return ListView.builder(
                  itemCount: state!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SpendingManageItem(
                      model: state[index],
                      index: index,
                      tagColor: Colors.green,
                    );
                  },
                );
              },
              onLoading: const LoadingIndicator(),
              onEmpty: const Center(child: Text('No data found')),
              onError: (error) => Text(error!),
            ),
          ),
        ],
      ),
    );
  }
}
