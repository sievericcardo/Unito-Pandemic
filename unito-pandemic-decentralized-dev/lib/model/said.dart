import 'package:floor/floor.dart';

import 'beacon.dart';

/// Entity that send data to beacons
/// 
/// This entity can be seen as a **sending part** for the contact tracing. 
/// As such we extend the beacon class; moreover we do not need to instantiate
/// anything specifically, that's why we just need to call 
/// `super(contact, timestamp)` when creating a new instance
@entity
class Said extends Beacon {
  Said(String contact, int timestamp) : super(contact, timestamp);
}
