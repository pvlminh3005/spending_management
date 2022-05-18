import '../../core/constants/constants.dart';
import '../../core/styles/style.dart';

class ExpenseModel {
  final String uid;
  final String title;
  final String description;
  final int price;
  final int expenseType;
  final DateTime createdAt;

  ExpenseModel({
    required this.uid,
    required this.title,
    this.description = '',
    this.price = 0,
    this.expenseType = 0,
    required this.createdAt,
  });

  CostType get costType => CostType.values.firstWhere(
        (element) => element.name == title.replaceAll(' ', '').toLowerCase(),
      );
  ExpenseType get actionType => ExpenseType.values[expenseType];

  String titleTagBuilder(CostType type) {
    switch (type) {
      //?payment
      case CostType.eat:
        return 'Eat';
      case CostType.personal:
        return 'Personal';
      case CostType.study:
        return 'Study';
      case CostType.shopping:
        return 'Shopping';
      case CostType.donate:
        return 'Donate';

      //?charge
      case CostType.award:
        return 'Award';
      case CostType.salary:
        return 'Salary';
      default:
        return 'Other';
    }
  }

  String get formatDate => (createdAt).displayDate;
  String get month => createdAt.month.toString();
}

List<ExpenseModel> fakeData = [
  //? payment
  ExpenseModel(
    uid: 'ex001',
    title: 'Play',
    description: 'Cafe với bae',
    price: 45000,
    expenseType: 0,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex002',
    title: 'Eat',
    description: 'Đi chợ',
    price: 91000,
    expenseType: 0,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex001',
    title: 'Study',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    price: 9786000,
    expenseType: 0,
    createdAt: DateTime.now(),
  ),
  //? charge
  ExpenseModel(
    uid: 'ex003',
    title: 'Award',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    price: 145000,
    expenseType: 1,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex004',
    title: 'Salary',
    description:
        'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Molestiae sapiente saepe ullam eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    price: 145000,
    expenseType: 1,
    createdAt: DateTime.now(),
  ),
];
