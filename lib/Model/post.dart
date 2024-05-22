class PostModel {
  final String userName;
  final String title;
  final String desc;
  final String email;
  final String imageUrl;
  final String time;
  final String userProfilePic;

  PostModel({
    required this.userName,
    required this.title,
    required this.desc,
    required this.email,
    required this.imageUrl,
    required this.time,
    required this.userProfilePic,
  });

  toJson() {
    return {
      'userName': userName,
      'title': title,
      'desc': desc,
      'email': email,
      'imageUrl': imageUrl,
      'time': time,
      'userProfilePic': userProfilePic
    };
  }
}
