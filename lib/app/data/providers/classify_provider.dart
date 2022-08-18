part of providers;

class ClassifyProvider {
  factory ClassifyProvider() => _instance;
  ClassifyProvider._internal();
  static final ClassifyProvider _instance = ClassifyProvider._internal();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _classify = _firestore.collection(DbPaths.classify);
  static AuthService get _auth => Get.find();
  static String get _uid => _auth.user!.uid;

  static Future<List<ClassifyModel>> getListClassify({
    DateTime? date,
  }) async {
    try {
      final _listClassify = <ClassifyModel>[];
      DateTime _date = date ?? DateTime.now();
      final _collection = await _classify.doc(_uid).collection(_pathCollectionDate(_date)).get();

      for (var element in _collection.docs) {
        final _classify = ClassifyModel.fromJson(element.data());
        _listClassify.add(_classify);
      }

      _listClassify.sort((a, b) => a.category.title.tiengViet.compareTo(b.category.title.tiengViet));

      return _listClassify;
    } on FirebaseException {
      rethrow;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> streamListClassify() {
    return _classify.doc(_uid).collection(_pathCollectionDate(DateTime.now())).snapshots();
  }

  static Future<int> getOpeningBalance() async {
    try {
      var _document = await _classify.doc(_uid).get();
      return _document.data()![DbKeys.openingBalance] as int;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createCacheClassify() async {
    try {
      var _existed = await _classify.doc(_uid).get();
      if (_existed.data() == null) {
        _classify.doc(_uid).set({
          DbKeys.cacheMonth: DateTime.now().month,
          DbKeys.openingBalance: 0,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createClassify(ClassifyModel classify, {bool isCreateCategory = true}) async {
    //* 1: create classify
    //* 2: create category use classify's uid
    try {
      await _classify
          .doc(_uid)
          .collection(_pathCollectionDate(DateTime.now())) // Ex: 4XzKLnSuUzZ4VZT_06/2022
          .add(classify.toJson())
          .then((value) async {
        createCacheClassify();
        //update uid model
        classify = classify.copyWith(
          category: classify.category.copyWith(uid: value.id),
        );
        await _classify.doc(_uid).collection(_pathCollectionDate(DateTime.now())).doc(value.id).update({
          DbKeys.uid: value.id,
          DbKeys.category: classify.category.toJson(),
        }).then((_) async {
          if (isCreateCategory) {
            await Repositories.category.createCategory(classify.category);
          }
        });
      });
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateClassify(ClassifyModel newClassify) async {
    try {
      await _classify.doc(_uid).collection(_pathCollectionDate(DateTime.now())).doc(newClassify.uid).update({
        DbKeys.defaultBalance: newClassify.defaultBalance,
      });
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateCurrentBalance({
    required String uidClassify,
    required int newBalance,
    required DateTime date,
    required isPlus,
  }) async {
    try {
      //* check exist collection db
      var _dataClassify = await _classify.doc(_uid).collection(_pathCollectionDate(date)).get();
      final _isPlus = _dataClassify.docs.isEmpty ? true : isPlus;

      if (_dataClassify.docs.isEmpty) {
        await resetCurrentBalanceClassify(date);
      }

      _classify
          .doc(_uid)
          .collection(_pathCollectionDate(date))
          .doc(uidClassify)
          .update({DbKeys.currentBalance: FieldValue.increment(_isPlus ? newBalance : -newBalance)});
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> deleteClassify(ClassifyModel classify) async {
    try {
      await _classify
          .doc(_uid)
          .collection(_pathCollectionDate(DateTime.now()))
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

  static Future<void> resetCurrentBalanceClassify(
    DateTime currentDate, {
    bool isUpdateCacheMonth = false,
  }) async {
    DocumentReference<Map<String, dynamic>> _doc = _classify.doc(_uid);
    try {
      var _value = await _doc.get();

      int _cacheMonth = _value.data()?[DbKeys.cacheMonth];
      int _openingBalance = _value.data()?[DbKeys.openingBalance];

      if (_cacheMonth != currentDate.month) {
        //* get data in previous date
        await _doc
            .collection(_pathCollectionDate(DateTime(
              DateTime.now().year,
              _cacheMonth,
            )))
            .get()
            .then((collection) async {
          //* create classify current month same previous data

          for (var element in collection.docs) {
            ClassifyModel classify = ClassifyModel.fromJson(element.data());
            if (classify.type == CategoryType.charge) {
              _openingBalance += classify.currentBalance;
            } else {
              _openingBalance -= classify.currentBalance;
            }

            classify = classify.copyWith(currentBalance: 0);
            await _classify
                .doc(_uid)
                .collection(_pathCollectionDate(currentDate))
                .doc(classify.uid) // Ex: 4XzKLnSuUzZ4VZT_06/2022
                .set(classify.toJson());
          }
        });

        if (isUpdateCacheMonth) {
          await _doc.update({
            DbKeys.cacheMonth: currentDate.month,
            DbKeys.openingBalance: _openingBalance,
          });
        }
      }
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateOpeningBalance(int balance) async {
    try {
      await _classify.doc(_uid).update({DbKeys.openingBalance: balance});
    } on FirebaseException {
      rethrow;
    }
  }

  static String _pathCollectionDate(DateTime date) => _uid + '_${date.month}_${date.year}';
}
