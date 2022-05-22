library repositories;

import '../models/expense_model.dart';
import '../providers/providers.dart';

part 'expense_repository.dart';

class Repositories {
  Repositories._();

  static ExpenseRepository get expense => ExpenseRepository();
}
