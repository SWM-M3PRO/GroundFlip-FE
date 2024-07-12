class UserStepResponse {
  List<int>? userId = [0,0,0,0,0,0,0];

  UserStepResponse({this.userId});

  List<int>? getUserId(){
    return userId;
  }

  factory UserStepResponse.fromJson(dynamic json) {
    if (json is List) {
      return UserStepResponse(userId: List<int>.from(json));
    } else {
      throw Exception("Invalid JSON format for UserStepResponse");
    }
  }
}
