part of providers;

typedef EnumValues<T> = TransactionType;

DateTime _dateNow = DateTime.now();

class TransactionProvider {
  factory TransactionProvider() => _instance;
  TransactionProvider._internal();
  static final TransactionProvider _instance = TransactionProvider._internal();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _transactions = _firestore.collection(DbPaths.transactions);
  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;

  static Future<List<TransactionModel>> getListTransactions({
    required int page,
    required TransactionType type,
    int? month,
  }) async {
    final _month = month ?? _dateNow.month;
    final DateTime _firstDate = DateTime(_dateNow.year, _month, 1);
    final DateTime _lastDate = DateTime(_dateNow.year, _month + 1, 0);

    try {
      String _path = _getPath(type);
      final _collection = await _transactions
          .doc(_uid)
          .collection(_path)
          .limit(10)
          .orderBy(DbKeys.createdAt, descending: true)
          .where(DbKeys.createdAt,
              isGreaterThanOrEqualTo: _firstDate.millisecondsSinceEpoch)
          .where(DbKeys.createdAt,
              isLessThanOrEqualTo: _lastDate.millisecondsSinceEpoch)
          .get();

      return _collection.docs.map((transaction) {
        return TransactionModel.fromJson(transaction.data());
      }).toList();
    } on FirebaseException catch (e) {
      AppUtils.toast(e.toString());
      rethrow;
    }
  }

  static Future<void> createTransaction(TransactionModel transaction) async {
    try {
      String _path = _getPath(transaction.transactionType);
      await _transactions
          .doc(_uid)
          .collection(_path)
          // .doc(transaction.uid)
          // .set(transaction.toJson());
          .add(transaction.toJson())
          .then((value) async {
        await _transactions
            .doc(_uid)
            .collection(_path)
            .doc(value.id)
            .update({DbKeys.uid: value.id});
      });
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateTransaction(TransactionModel data) async {
    try {
      String _path = _getPath(data.transactionType);
      await _transactions
          .doc(_uid)
          .collection(_path)
          .doc(data.uid)
          .update(data.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> deleteTransaction({
    required TransactionType type,
    required String uidTransaction,
  }) async {
    try {
      String _path = _getPath(type);
      await _transactions
          .doc(_uid)
          .collection(_path)
          .doc(uidTransaction)
          .delete();
    } on FirebaseException {
      rethrow;
    }
  }

  static String _getPath(TransactionType type) {
    switch (type) {
      case TransactionType.payment:
        return DbPaths.transactionPayment;
      case TransactionType.charge:
        return DbPaths.transactionCharge;
    }
  }
}
