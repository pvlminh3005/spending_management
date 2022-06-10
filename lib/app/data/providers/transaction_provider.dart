part of providers;

typedef EnumValues<T> = TransactionType;

DateTime _dateNow = DateTime.now();

class TransactionProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _transactions = _firestore.collection(DbPaths.transactions);

  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;

  static Future<List<TransactionModel>> getListTransactions({
    required int page,
    int? month,
    required TransactionType type,
  }) async {
    final _month = month ?? _dateNow.month;
    final DateTime _firstDate = DateTime(_dateNow.year, _month, 1);
    final DateTime _lastDate = DateTime(_dateNow.year, _month + 1, 0);

    try {
      String _path = getPath(type);
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
      AppUtils.toast(e.message!);
      rethrow;
    }
  }

  static Future<void> createTransaction(TransactionModel transaction) async {
    try {
      String _path = getPath(transaction.transactionType);
      await _transactions
          .doc(_uid)
          .collection(_path)
          .doc(transaction.uid)
          .set(TransactionModel(
            uid: '1234',
            title: 'Test 1',
            description: 'ALo',
            createdAt: DateTimeExt.parseDate('10/06/2022'),
            transactionType: TransactionType.payment,
            balance: 10000,
          ).toJson());
    } on FirebaseException catch (e) {
      AppUtils.log(e);
      AppUtils.toast(e.message!);
      rethrow;
    }
  }

  static String getPath(TransactionType type) {
    switch (type) {
      case TransactionType.payment:
        return DbPaths.transactionPayment;
      case TransactionType.charge:
        return DbPaths.transactionCharge;
    }
  }
}
