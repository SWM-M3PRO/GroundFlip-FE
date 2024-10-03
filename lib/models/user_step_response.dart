class UserStepResponse {
  List<int>? steps;

  UserStepResponse({this.steps});

  factory UserStepResponse.fromJson(dynamic json) {
    if (json is List) {
      return UserStepResponse(steps: List<int>.from(json));
    } else {
      throw Exception("Invalid JSON format for UserStepResponse");
    }
  }
}

class DailyPixel {
  List<int>? dailyPixelCounts;

  DailyPixel({this.dailyPixelCounts});

  factory DailyPixel.fromJson(dynamic json) {
    if (json is List) {
      return DailyPixel(dailyPixelCounts: List<int>.from(json));
    } else {
      throw Exception("Invalid JSON format for DailyPixel");
    }
  }
}
