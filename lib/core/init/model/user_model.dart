class UserModel {
  String? id;
  String? displayName;
  String? email;
  String? bio;
  String? photoUrl;
  String? appPin;
  DateTime? signUpTime;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.appPin,
    required this.signUpTime,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    email = json['email'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    appPin = json['appPin'].toString();
    signUpTime = DateTime.tryParse(json['signUpTime'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userModelData = {};
    userModelData['id'] = id;
    userModelData['displayName'] = displayName;
    userModelData['email'] = email;
    userModelData['bio'] = bio;
    userModelData['photoUrl'] = photoUrl;
    userModelData['appPin'] = appPin;
    userModelData['signUpTime'] = signUpTime;
    return userModelData;
  }
}
