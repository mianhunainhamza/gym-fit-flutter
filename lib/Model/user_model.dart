class UserModel{
  final String username;
  final String email;
  final String pass;
  final String role;

  UserModel(
  {
    required this.username,
    required this.pass,
    required this.email,
    required this.role
}
);

  toJson(){
    return {
      'UserName':username,
      'Email':email,
      'Password':pass,
      'Role':role
    };
  }
}