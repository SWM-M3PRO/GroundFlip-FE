class IndividualPixelLog {
  int? currentPixel;
  int? accumulatePixel;

  IndividualPixelLog({
    this.currentPixel,
    this.accumulatePixel,
  });

  IndividualPixelLog.fromJson(Map<String, dynamic> json){
    currentPixel = json['currentPixel'];
    accumulatePixel = json['accumulatePixel'];
  }
}
