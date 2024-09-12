class IndividualModePixelInfo {
  int? pixelId;
  String? address;
  int? addressNumber;
  int? visitCount;
  PixelOwner? pixelOwnerUser;
  List<VisitList>? visitList;

  IndividualModePixelInfo({
    this.pixelId,
    this.address,
    this.addressNumber,
    this.visitCount,
    this.pixelOwnerUser,
    this.visitList,
  });

  IndividualModePixelInfo.fromJson(Map<String, dynamic> json) {
    pixelId = json['pixelId'];
    address = json['address'];
    addressNumber = json['addressNumber'];
    visitCount = json['visitCount'];
    pixelOwnerUser = json['pixelOwnerUser'] != null
        ? PixelOwner.fromJsonUser(json['pixelOwnerUser'])
        : null;
    if (json['visitList'] != null) {
      visitList = <VisitList>[];
      json['visitList'].forEach((v) {
        visitList!.add(VisitList.fromJsonUser(v));
      });
    }
  }
}

class PixelOwner {
  int? id;
  String? name;
  String? profileImageUrl;
  int? currentPixelCount;
  int? accumulatePixelCount;

  PixelOwner({
    this.id,
    this.name,
    this.profileImageUrl,
    this.currentPixelCount,
    this.accumulatePixelCount,
  });

  PixelOwner.fromJsonUser(Map<String, dynamic> json) {
    id = json['userId'];
    name = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }

  PixelOwner.fromJsonCommunity(Map<String, dynamic> json) {
    id = json['communityId'];
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }
}

class VisitList {
  String? name;
  String? profileImageUrl;

  VisitList({this.name, this.profileImageUrl});

  VisitList.fromJsonUser(Map<String, dynamic> json) {
    name = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
  }

  VisitList.fromJsonCommunity(Map<String, dynamic> json) {
    name = json['name'];
    profileImageUrl = json['profileImageUrl'];
  }
}
