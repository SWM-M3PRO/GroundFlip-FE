class IndividualHistoryPixelInfo {
  int? pixelId;
  String? address;
  int? addressNumber;
  int? visitCount;
  List<DateTime>? visitList;

  IndividualHistoryPixelInfo({
    this.pixelId,
    this.address,
    this.addressNumber,
    this.visitCount,
    this.visitList,
  });

  IndividualHistoryPixelInfo.fromJson(Map<String, dynamic> json) {
    pixelId = json['pixelId'];
    address = json['address'];
    addressNumber = json['addressNumber'];
    visitCount = json['visitCount'];
    if (json['visitList'] != null) {
      visitList = (json['visitList'] as List<dynamic>)
          .map((item) => DateTime.parse(item))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'addressNumber': addressNumber,
      'visitCount': visitCount,
      'visitList': visitList?.map((item) => item.toIso8601String()).toList(),
    };
  }
}
