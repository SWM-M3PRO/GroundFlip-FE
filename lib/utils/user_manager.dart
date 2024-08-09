class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  int? userId;

  void init() {
    userId = null;
  }

  void setUserId(int id) {
    userId = id;
  }

  int? getUserId() {
    return userId;
  }
}
