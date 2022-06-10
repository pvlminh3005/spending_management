part of providers;

class CategoryProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _categories = _firestore.collection(DbPaths.categories);
  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;

  static Future<List<CategoryModel>> getCategories() async {
    try {
      // final data = await _categories.doc(_uid).co
      return [];
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
