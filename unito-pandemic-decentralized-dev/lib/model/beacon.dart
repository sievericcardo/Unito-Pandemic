import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

/// Beacon entity
/// 
/// We use beacon with the proximity tracing for communications between
/// smartphone. To generate a new beacon we can just do it with the constructor
/// 
/// ```dart
/// Beacon(contact, timestamp)
/// ```
/// 
/// as we need to keep track of the time
@entity
class Beacon {
  @primaryKey
  int id;
  String contact;
  int timestamp;

  Beacon(String contact, int timestamp) {
    this.contact = contact;
    this.timestamp = timestamp;
  }

  void setId(int id) {
    this.id = id;
  }

  void setContact(String contact) {
    this.contact = contact;
  }

  void setTimestamp(int timestamp) {
    this.timestamp = timestamp;
  }

  String get getSimplifiedContact {
    return this.contact.substring(0, 17);
  }

  int get getId => id;
  String get getContact => contact;
  int get getTimestamp => timestamp;

  String get getTimestampAsDate {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this.timestamp * 1000);
    String x = DateFormat('dd-MM-yyy hh:mm').format(date);
    return x;
  }
}
