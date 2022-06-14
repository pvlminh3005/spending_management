import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../core/constants/db_keys.dart';
import '../../core/constants/db_paths.dart';
import '../models/classify_model.dart';
import '../repositories/repositories.dart';
import '../services/auth_service.dart';

class ClassifyProvider {
  factory ClassifyProvider() => _instance;
  ClassifyProvider._internal();
  static final ClassifyProvider _instance = ClassifyProvider._internal();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _classify = _firestore.collection(DbPaths.classify);
  static AuthService get _auth => Get.find();
  static String get _uid => _auth.user!.uid;

  static Future<List<ClassifyModel>> getListClassify() async {
    try {
      final _collection = await _classify.doc(_uid).collection(_uid).get();

      return _collection.docs.map((classify) {
        return ClassifyModel.fromJson(classify.data());
      }).toList();
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> createClassify(ClassifyModel classify) async {
    //* 1: create category
    //* 2: create classify
    try {
      Repositories.category.createCategory(classify.category).then((_) async {
        await _classify
            .doc(_uid)
            .collection(_uid)
            .add(classify.toJson())
            .then((value) async {
          //update uid model
          await _classify
              .doc(_uid)
              .collection(_uid)
              .doc(value.id)
              .update({DbKeys.uid: value.id});
        });
      });
    } on FirebaseException {
      rethrow;
    }
  }
}
