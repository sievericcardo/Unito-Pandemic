import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/heard.dart';

/// Class that maps the query to be done to the local db on the heard table
/// 
/// We set the queries that can be done on the table of received beacons; we
///  define three different operations for that table:
/// 1. Select all beacons received
/// 2. Clear the data from the table
/// 3. Insert a new entry
@dao
abstract class HeardDao {
  @Query('SELECT * FROM Heard')
  Stream<List<Heard>> findAllHeards();

  @Query('SELECT * FROM Heard')
  Future<List<Heard>> findAllHeardsSync();

  @insert
  Future<void> insertHeard(Heard heard);
}
