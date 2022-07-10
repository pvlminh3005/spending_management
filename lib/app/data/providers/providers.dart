library providers;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/extension.dart';
import '../models/category_model.dart';
import '../models/classify_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../repositories/repositories.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

part 'category_provider.dart';
part 'user_provider.dart';
part 'transaction_provider.dart';
part 'classify_provider.dart';
