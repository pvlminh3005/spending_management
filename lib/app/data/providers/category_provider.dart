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
    final _listCategories = <CategoryModel>[];
    try {
      String _path = _getPath(type);

      final _collection = await _categories
          .doc(_uid)
          .collection(_path)
          .orderBy(DbKeys.title)
          .get();

      for (var element in _collection.docs) {
        var category = CategoryModel.fromJson(element.data());
        _listCategories.add(category);
      }

      _listCategories.sort(
        (a, b) => a.title.tiengViet.compareTo(b.title.tiengViet),
      );
      return _listCategories;
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> createCategory(CategoryModel category) async {
    try {
      String _path = _getPath(category.categoryType);
      await _categories
          .doc(_uid)
          .collection(_path)
          .doc(category.uid)
          .set(category.toJson());

      await Get.find<UserService>().init();
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> updateCategory(CategoryModel newCategory) async {
    try {
      String _path = _getPath(newCategory.categoryType);
      await _categories
          .doc(_uid)
          .collection(_path)
          .doc(newCategory.uid)
          .update(newCategory.toJson());

      await Get.find<UserService>().init();
    } on FirebaseException {
      rethrow;
    }
  }

  static Future<void> deleteCategory({
    required CategoryType type,
    required String uidCategory,
  }) async {
    try {
      String _path = _getPath(type);
      _categories.doc(_uid).collection(_path).doc(uidCategory).delete();

      await Get.find<UserService>().init();
    } on FirebaseException {
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
