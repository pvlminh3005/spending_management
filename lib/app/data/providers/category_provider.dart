part of providers;

class CategoryProvider {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _categories = _firestore.collection(DbPaths.categories);
  static AuthService get _auth => Get.find();
  static String? get _uid => _auth.user?.uid;
}
