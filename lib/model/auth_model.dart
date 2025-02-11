class AuthModel {
  String? email;
  String? password;
  String? role;
  String? token;

  AuthModel({this.email, this.password, this.role, this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'],
      password: json['password'],
      role: json['role'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
      'token': token,
    };
  }
}