part of providers;

typedef EnumValues<T> = TransactionType;

class TransactionProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _transactions = _firestore.collection(DbPaths.transactions);

  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;

  static Future<List<TransactionModel>> getListTransactions(
      TransactionType type) async {
    try {
      AppUtils.log('UID: $_uid');
      String _path = getPath(type);
      final _collection = await _transactions.doc(_uid).collection(_path).get();

      return _collection.docs.map((transaction) {
        print(transaction.data());
        return TransactionModel.fromJson(transaction.data());
      }).toList();
    } on FirebaseException catch (e) {
      AppUtils.toast(e.message!);
      rethrow;
    }
  }

  static Future<void> createTransaction(Map<String, dynamic> data) async {
    try {} catch (e) {
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
