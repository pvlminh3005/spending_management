class UserModel {
  final String uid;
  final String name;
  final int phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
  });
}

final fakeUser = UserModel(
  uid: 'user123',
  name: 'Tu Quyen',
  phoneNumber: 0398084015,
);
