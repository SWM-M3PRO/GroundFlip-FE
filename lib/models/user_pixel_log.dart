class UserPixelLog {
  int? currentPixelCount;
  int? accumulatePixelCount;

  UserPixelLog({
    this.currentPixelCount,
    this.accumulatePixelCount,
  });

  UserPixelLog.fromJson(Map<String, dynamic> json){
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }
}
