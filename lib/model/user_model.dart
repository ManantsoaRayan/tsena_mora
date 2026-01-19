class User {
  int? id;
  String username;
  String password;
  String location;
  String createdAt;
  String grade;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.createdAt,
    this.location = "",
    this.grade = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "location": location,
      "grade": grade,
      "created_at": createdAt
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      username: map["username"],
      password: map["password"],
      location: map["location"],
      grade: map["grade"],
      createdAt: map["created_at"]
    );
  }
}
