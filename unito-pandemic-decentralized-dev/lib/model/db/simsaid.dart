import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/simbeacon.dart';

@entity
class SimSaid extends SimBeacon {
  SimSaid(String contact, int timestamp, int simId) : super(contact, timestamp, simId);
}
