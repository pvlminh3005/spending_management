part of providers;

class TransactionProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _referencePayment =
      _firestore.collection(DbPaths.transactionPayment);
  static final CollectionReference _referenceCharge =
      _firestore.collection(DbPaths.transactionCharge);
  static AuthService get _auth => Get.find();

  static Future getListPayment() async {
    try {
      final _collection = await _referencePayment.doc(_auth.user?.uid).get();
      print(_collection.data());
      return ListTransactionModel.fromJson(_collection.data()!);
    } on FirebaseException catch (e) {
      AppUtils.toast(e.message!);
      rethrow;
    }
  }

  static Future<ListTransactionModel> getListCharge() async {
    try {
      await 1.delay();
      return chargeTransactions;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createTransaction(Map<String, dynamic> data) async {
    try {} catch (e) {
      rethrow;
    }
  }
}
