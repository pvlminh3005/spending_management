library providers;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/date_extension.dart';
import '../../core/utilities/app_utils.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

part 'category_provider.dart';
part 'user_provider.dart';
part 'transaction_provider.dart';
