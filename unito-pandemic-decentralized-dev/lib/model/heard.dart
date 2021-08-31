import 'package:unito_pandemic_decentralized/model/beacon.dart';
import 'package:floor/floor.dart';

/// Entity that listens to beacons
/// 
/// This entity can be seen as a **listening part** for the contact tracing. 
/// As such we extend the beacon class; moreover we do not need to instantiate
/// anything specifically, that's why we just need to call 
/// `super(contact, timestamp)` when creating a new instance
@entity
class Heard extends Beacon {
  Heard(String contact, int timestamp) : super(contact, timestamp);
}
