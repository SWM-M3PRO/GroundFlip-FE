import 'individual_mode_pixel_info.dart';

class CommunityModePixelInfo {
  int? pixelId;
  String? address;
  int? addressNumber;
  int? visitCount;
  PixelOwner? pixelOwnerCommunity;
  List<VisitList>? visitList;

  CommunityModePixelInfo({
    this.pixelId,
    this.address,
    this.addressNumber,
    this.visitCount,
    this.pixelOwnerCommunity,
    this.visitList,
  });

  CommunityModePixelInfo.fromJson(Map<String, dynamic> json) {
    pixelId = json['pixelId'];
    address = json['address'];
    addressNumber = json['addressNumber'];
    visitCount = json['visitCount'];
    pixelOwnerCommunity = json['pixelOwnerCommunity'] != null
        ? PixelOwner.fromJsonCommunity(json['pixelOwnerCommunity'])
        : null;
    if (json['visitList'] != null) {
      visitList = <VisitList>[];
      json['visitList'].forEach((v) {
        visitList!.add(VisitList.fromJsonCommunity(v));
      });
    }
  }
}
