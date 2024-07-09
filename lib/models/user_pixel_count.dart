class UserPixelCount {
  int? currentPixelCount;
  int? accumulatePixelCount;

  UserPixelCount({
    this.currentPixelCount,
    this.accumulatePixelCount,
  });

  UserPixelCount.fromJson(Map<String, dynamic> json){
    currentPixelCount = json['currentPixelCount'];
    accumulatePixelCount = json['accumulatePixelCount'];
  }
}
