import 'package:floor/floor.dart';

/// Entity for the different news that gets displayed in the app
/// 
/// We display news on the application so that user gets updated on the various
/// information that gets published regularly on the Disease. The idea for this
/// entity is to allow a **custom news feed**.
@entity
class News {
  @primaryKey
  int id;
  String body;
  int timestamp;

  News(String body, int timestamp) {
    this.body = body;
    this.timestamp = timestamp;
  }

  static News fromJson(Map json) {
    return new News(json["body"], json["timestamp"]);
  }
}
