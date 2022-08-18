import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/classify_model.dart';
import '../providers/providers.dart';

abstract class ClassifyRepositoryBase {
  Future<void> createCacheClassify();
  Future<List<ClassifyModel>> getListClassify({DateTime? date});
  Stream<QuerySnapshot<Map<String, dynamic>>> streamListClassify();
  Future<void> createClassify(ClassifyModel classify);
  Future<void> updateClassify(ClassifyModel newClassify);
  Future<void> updateCurrentBalance({
    required String uidClassify,
    required int newBalance,
    required DateTime date,
    bool isPlus = true,
  });
  Future<void> deleteClassify(ClassifyModel classify);
  Future<void> resetCurrentBalanceClassify(DateTime currentDate, {bool isUpdateCacheMonth});
  Future<int> getOpeningBalance();
  Future<void> updateOpeningBalance(int balance);
}

class ClassifyRepository implements ClassifyRepositoryBase {
  @override
  Future<void> createCacheClassify() {
    return ClassifyProvider.createCacheClassify();
  }

  @override
  Future<List<ClassifyModel>> getListClassify({DateTime? date}) {
    return ClassifyProvider.getListClassify(date: date);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> streamListClassify() {
    return ClassifyProvider.streamListClassify();
  }

  @override
  Future<void> createClassify(ClassifyModel classify) {
    return ClassifyProvider.createClassify(classify);
  }

  @override
  Future<void> updateClassify(ClassifyModel newClassify) async {
    return ClassifyProvider.updateClassify(newClassify);
  }

  @override
  Future<void> deleteClassify(ClassifyModel classify) {
    return ClassifyProvider.deleteClassify(classify);
  }

  @override
  Future<void> updateCurrentBalance({
    required String uidClassify,
    required int newBalance,
    required DateTime date,
    bool isPlus = true,
  }) {
    return ClassifyProvider.updateCurrentBalance(
      uidClassify: uidClassify,
      newBalance: newBalance,
      date: date,
      isPlus: isPlus,
    );
  }

  @override
  Future<void> resetCurrentBalanceClassify(DateTime currentDate, {bool isUpdateCacheMonth = false}) {
    return ClassifyProvider.resetCurrentBalanceClassify(
      currentDate,
      isUpdateCacheMonth: isUpdateCacheMonth,
    );
  }

  @override
  Future<int> getOpeningBalance() {
    return ClassifyProvider.getOpeningBalance();
  }

  @override
  Future<void> updateOpeningBalance(int balance) {
    return ClassifyProvider.updateOpeningBalance(balance);
  }
}
