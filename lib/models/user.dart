class User {
  int? userId;
  String? nickname;
  String? profileImageUrl;
  int? communityId;
  String? communityName;
  String? birthYear;
  String? gender;

  User(
      {this.userId,
      this.nickname,
      this.profileImageUrl,
      this.communityId,
      this.communityName,
      this.birthYear,
      this.gender});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    communityId = json['communityId'];
    communityName = json['communityName'];
    birthYear = json['birthYear'];
    gender = json['gender'];
  }
}
