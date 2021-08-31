import 'package:floor/floor.dart';

@Entity(
  tableName: 'Contagion',
)

/// Class to map the contagion mapped with the proximity tracing protocol
/// 
/// Every time we get in proximity to a person we get the contact trace of that
/// person; in case a user gets infected, his/her **key** will be **published**
/// into the public table.
class Contagion {
  @primaryKey
  int id;
  String infected;
  int timestamp;
  int diseaseId;

  Contagion(int id, String infected, int timestamp, int diseaseId) {
    this.infected = infected;
    this.timestamp = timestamp;
    this.id = 1;
    this.diseaseId = 1;
  }

  Contagion.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        timestamp = json["timestamp"],
        infected = json["infected"],
        diseaseId = json["diseaseId"];

  String get getInfected => this.infected;
  int get getTimestamp => this.timestamp;
}
