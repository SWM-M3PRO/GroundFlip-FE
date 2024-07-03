class IndividualModePixelInfo {
  String? address;
  int? addressNumber;
  int? visitCount;
  PixelOwnerUser? pixelOwnerUser;
  List<VisitList>? visitList;

  IndividualModePixelInfo(
      {this.address,
      this.addressNumber,
      this.visitCount,
      this.pixelOwnerUser,
      this.visitList});

  IndividualModePixelInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressNumber = json['addressNumber'];
    visitCount = json['visitCount'];
    pixelOwnerUser = json['pixelOwnerUser'] != null
        ? new PixelOwnerUser.fromJson(json['pixelOwnerUser'])
        : null;
    if (json['visitList'] != null) {
      visitList = <VisitList>[];
      json['visitList'].forEach((v) {
        visitList!.add(new VisitList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['addressNumber'] = this.addressNumber;
    data['visitCount'] = this.visitCount;
    if (this.pixelOwnerUser != null) {
      data['pixelOwnerUser'] = this.pixelOwnerUser!.toJson();
    }
    if (this.visitList != null) {
      data['visitList'] = this.visitList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PixelOwnerUser {
  int? userId;
  String? nickname;
  String? profileImageUrl;
  int? currentPixelCount;
  int? accumulatePixelCount;

  PixelOwnerUser(
      {this.userId,
      this.nickname,
      this.profileImageUrl,
      this.currentPixelCount,
      this.accumulatePixelCount});

  PixelOwnerUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['nickname'] = this.nickname;
    data['profileImageUrl'] = this.profileImageUrl;
    data['currentPixelCount'] = this.currentPixelCount;
    data['accumulatePixelCount'] = this.accumulatePixelCount;
    return data;
  }
}

class VisitList {
  String? nickname;
  String? profileImageUrl;

  VisitList({this.nickname, this.profileImageUrl});

  VisitList.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['profileImageUrl'] = this.profileImageUrl;
    return data;
  }
}
