import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/simbeacon.dart';

@entity
class SimHeard extends SimBeacon {
  SimHeard(String contact, int timestamp, int simId) : super(contact, timestamp, simId);
}
