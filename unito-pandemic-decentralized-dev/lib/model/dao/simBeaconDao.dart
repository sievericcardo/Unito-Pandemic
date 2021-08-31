import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/db/simheard.dart';
import 'package:unito_pandemic_decentralized/model/db/simsaid.dart';

/// Class that maps the query to be done to the local db on the simbeacon table
/// 
/// We set the queries that can be done on the table of beacons that we use
/// during a simulation; we define as such four different operations on this
/// specific table:
/// 1. Select all beacons sent on SimSaid
/// 2. Select all the beacons received on SimHeard
/// 3. Insert a new entry of the simultation beacon received
/// 4. Insert a new entry of the simultation beacon sent
@dao
abstract class SimBeaconDao {
  @Query('SELECT * FROM SimSaid')
  Stream<List<SimSaid>> findAllSimSaids();

  @Query('SELECT * FROM SimHeard')
  Stream<List<SimHeard>> findAllSimHeards();

  @insert
  Future<void> insertSimHeard(SimHeard item);

  @insert
  Future<void> insertSimSaid(SimSaid item);
}
