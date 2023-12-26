class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? profilePic;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.profilePic,
  });

  UserModel.frommap(Map<String, dynamic> map) {
    uid = map['uid'];
    fullname = map['fullname'];
    email = map['email'];
    profilePic = map['profilePic'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'profilePic': profilePic,
    };
  }
}
