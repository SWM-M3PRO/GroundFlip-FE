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
      this.visitList,});

  IndividualModePixelInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressNumber = json['addressNumber'];
    visitCount = json['visitCount'];
    pixelOwnerUser = json['pixelOwnerUser'] != null
        ? PixelOwnerUser.fromJson(json['pixelOwnerUser'])
        : null;
    if (json['visitList'] != null) {
      visitList = <VisitList>[];
      json['visitList'].forEach((v) {
        visitList!.add(VisitList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['addressNumber'] = addressNumber;
    data['visitCount'] = visitCount;
    if (pixelOwnerUser != null) {
      data['pixelOwnerUser'] = pixelOwnerUser!.toJson();
    }
    if (visitList != null) {
      data['visitList'] = visitList!.map((v) => v.toJson()).toList();
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
      this.accumulatePixelCount,});

  PixelOwnerUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    data['currentPixelCount'] = currentPixelCount;
    data['accumulatePixelCount'] = accumulatePixelCount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['profileImageUrl'] = profileImageUrl;
    return data;
  }
}
