library repositories;

import '../../core/constants/enum.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../providers/providers.dart';
import 'category_repository.dart';
import 'classify_repository.dart';

part 'transaction_repository.dart';
part 'user_repository.dart';

class Repositories {
  Repositories._();

  static UserRepository get user => UserRepository();
  static TransactionRepository get transaction => TransactionRepository();
  static CategoryRepository get category => CategoryRepository();
  static ClassifyRepository get classify => ClassifyRepository();
}
