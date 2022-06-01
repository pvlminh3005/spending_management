part of providers;

class UserProvider {
  UserProvider._();

  static Future<UserModel> getUser() async {
    try {
      await 2.delay();
      return fakeUser;
    } catch (e) {
      rethrow;
    }
  }
}
