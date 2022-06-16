import '../models/classify_model.dart';
import '../providers/classify_provider.dart';

abstract class ClassifyRepositoryBase {
  Future<List<ClassifyModel>> getListClassify();
  Future<void> createClassify(ClassifyModel classify);
  Future<void> updateClassify(ClassifyModel newClassify);
  Future<void> updateCurrentBalance({
    required String uidClassify,
    required int newBalance,
    bool isPlus = true,
  });
  Future<void> deleteClassify(ClassifyModel classify);
  Future<void> resetCurrentBalanceClassify(int currentMonth);
}

class ClassifyRepository implements ClassifyRepositoryBase {
  @override
  Future<List<ClassifyModel>> getListClassify() {
    return ClassifyProvider.getListClassify();
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
    bool isPlus = true,
  }) {
    return ClassifyProvider.updateCurrentBalance(
      uidClassify: uidClassify,
      newBalance: newBalance,
      isPlus: isPlus,
    );
  }

  @override
  Future<void> resetCurrentBalanceClassify(int currentMonth) {
    return ClassifyProvider.resetCurrentBalanceClassify(currentMonth);
  }
}
