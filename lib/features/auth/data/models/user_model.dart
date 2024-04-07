import '/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.userName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        userName: map['username'],
      );
}
