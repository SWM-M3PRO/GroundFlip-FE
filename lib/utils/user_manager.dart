class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  String? userId;

  void init() {
    userId = null;
  }

  void setUserId(String id) {
    userId = id;
  }

  String? getUserId() {
    return userId;
  }
}
