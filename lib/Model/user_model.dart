class UserModel {
  final String username;
  final String email;
  final String pass;
  final String role;
  final String profilePicUrl;

  UserModel({
    required this.username,
    required this.pass,
    required this.email,
    required this.role,
    required this.profilePicUrl,
  });

  toJson() {
    return {
      'UserName': username,
      'Email': email,
      'Password': pass,
      'Role': role,
      'profilePicUrl': profilePicUrl,
    };
  }
}
