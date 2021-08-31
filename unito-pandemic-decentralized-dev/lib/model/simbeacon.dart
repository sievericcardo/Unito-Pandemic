import 'package:floor/floor.dart';

import 'beacon.dart';

/// Beacon that is used during simulations.
/// 
/// Apart from the normal contact tracing done for real contagion, we also
/// make simulations for possible others virus that may spread and lead to
/// a pandemy; as such we prepared our application to create a simulation with
/// the purpose of **gathering data useful to statistical purpose**. We do
/// extend the Beacon class and call the `super(contact, timestamp)` constructor
/// but we do add an integer as identifier for the simulation.
@entity
class SimBeacon extends Beacon {
  int simId;

  SimBeacon(String contact, int timestamp, int simId) : super(contact, timestamp) {
    this.simId = simId;
  }

  void setSimId(int simId) {
    this.simId = simId;
  }

  int get getSimId => simId;

  static SimBeacon fromJson(Map json) {
    return new SimBeacon(json["contact"], json["timestamp"], json['simId']);
  }
}
