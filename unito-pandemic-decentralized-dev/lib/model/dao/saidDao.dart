import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/said.dart';

/// Class that maps the query to be done to the local db on sent beacon table
/// 
/// We set the queries that can be done on the table of beacons that we send;
/// we define two different operations:
/// 1. Select all beacons sent
/// 3. Insert a new entry on the table
@dao
abstract class SaidDao {
  @Query('SELECT * FROM Heard')
  Stream<List<Said>> findAllHeards();

  @insert
  Future<void> insertSaid(Said said);
}
