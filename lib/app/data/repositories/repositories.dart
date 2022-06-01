library repositories;

import 'package:get/get.dart';

import '../models/list_transaction/list_transaction.dart';
import '../models/user/user_model.dart';
import '../providers/providers.dart';

part 'transaction_repository.dart';
part 'user_repository.dart';

class Repositories {
  Repositories._();

  static UserRepository get user => UserRepository();
  static TransactionRepository get transaction => TransactionRepository();
}
