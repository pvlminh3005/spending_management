library repositories;

import '../../core/constants/enum.dart';
import '../models/expense/expense.dart';
import '../providers/providers.dart';

part 'expense_repository.dart';

class Repositories {
  Repositories._();

  static ExpenseRepository get expense => ExpenseRepository();
}
