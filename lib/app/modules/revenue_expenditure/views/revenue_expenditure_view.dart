import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/revenue_expenditure_controller.dart';

class RevenueExpenditureView extends GetView<RevenueExpenditureController> {
  const RevenueExpenditureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RevenueExpenditureView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RevenueExpenditureView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
