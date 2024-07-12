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
