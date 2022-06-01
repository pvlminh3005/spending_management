part of repositories;

abstract class UserRepositoryBase {
  Future<UserModel> getUser();
}

class UserRepository extends UserRepositoryBase {
  @override
  Future<UserModel> getUser() {
    return UserProvider.getUser();
  }
}
