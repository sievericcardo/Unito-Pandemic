/// Class for the various response
/// 
/// We map from json the various data of the user that are required.
class UserResponse {
  int id;

  String name;

  String gender;

  String password;

  int age;

  UserResponse.fromJson(Map<String, dynamic> json)
      : id = -12345,
        gender = json["gender"],
        name = json["name"],
        password = json["password"],
        age = json["age"];
}
