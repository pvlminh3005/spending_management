import '../../core/constants/constants.dart';

class CostModel {
  final String uid;
  final String title;

  CostModel({required this.uid, required this.title});

  CostType get costType => CostType.values.firstWhere(
        (element) => element.name == title.replaceAll(' ', '').toLowerCase(),
      );
}
