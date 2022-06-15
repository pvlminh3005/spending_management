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
      final _collection = await _classify
          .doc(_uid)
          .collection(_uid)
          .orderBy(DbKeys.defaultBalance)
          .get();

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
      await _classify
          .doc(_uid)
          .collection(_uid)
          .add(classify.toJson())
          .then((value) async {
        //update uid model
        classify = classify.copyWith(
          category: classify.category.copyWith(uid: value.id),
        );
        await _classify.doc(_uid).collection(_uid).doc(value.id).update({
          DbKeys.uid: value.id,
          DbKeys.category: classify.category.toJson(),
        }).then((_) async {
          await Repositories.category.createCategory(classify.category);
        });
      });
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateClassify(ClassifyModel newClassify) async {
    try {
      await _classify.doc(_uid).collection(_uid).doc(newClassify.uid).update({
        DbKeys.defaultBalance: newClassify.defaultBalance,
      });
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateCurrentBalance({
    required String uidClassify,
    required int newBalance,
  }) async {
    try {
      _classify
          .doc(_uid)
          .collection(_uid)
          .doc(uidClassify)
          .update({DbKeys.currentBalance: newBalance});
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> deleteClassify(ClassifyModel classify) async {
    try {
      await _classify
          .doc(_uid)
          .collection(_uid)
          .doc(classify.uid)
          .delete()
          .then((_) async {
        await Repositories.category.deleteCategory(
          type: classify.category.categoryType,
          uidCategory: classify.category.uid!,
        );
      });
    } on FirebaseException {
      rethrow;
    }
  }
}
