part of providers;

class CategoryProvider {
  factory CategoryProvider() => _instance;
  CategoryProvider._internal();
  static final CategoryProvider _instance = CategoryProvider._internal();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _categories = _firestore.collection(DbPaths.categories);
  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;

  static Future<List<CategoryModel>> getCategories(
      {required CategoryType type}) async {
    try {
      String _path = _getPath(type);

      print('UUUUID: $_uid');

      final _collection = await _categories
          .doc(_uid)
          .collection(_path)
          .orderBy(DbKeys.title, descending: true)
          .get();

      return _collection.docs.map((category) {
        print(category.data());
        return CategoryModel.fromJson(category.data());
      }).toList();
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  static Future<void> createCategory(CategoryModel category) async {
    try {} catch (e) {
      rethrow;
    }
  }

  static Future<void> updateCategory(CategoryModel newCategory) async {
    try {} catch (e) {
      rethrow;
    }
  }

  static String _getPath(CategoryType type) {
    switch (type) {
      case CategoryType.payment:
        return DbPaths.categoryPayment;
      case CategoryType.charge:
        return DbPaths.categoryCharge;
    }
  }
}
