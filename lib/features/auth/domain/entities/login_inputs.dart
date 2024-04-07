class LoginInputs {
  final String userName;
  final String password;
  LoginInputs({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': userName,
      'password': password,
    };
  }
}
