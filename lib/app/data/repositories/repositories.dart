library repositories;

import '../../core/constants/enum.dart';
import '../models/transaction/transaction.dart';
import '../providers/providers.dart';

part 'expense_repository.dart';

class Repositories {
  Repositories._();

  static TransactionRepository get transaction => TransactionRepository();
}
