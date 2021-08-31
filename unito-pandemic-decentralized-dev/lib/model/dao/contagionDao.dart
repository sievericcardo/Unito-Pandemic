import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/backend/contagion.dart';

/// Class that maps the query to be done to the local db on the contagion table
///
/// We set the queries that can be done on the table of contagions; we define
/// three different operations:
/// 1. Select all contagions
/// 2. Clear the data from the table
/// 3. Insert a new contagion
@dao
abstract class ContagionDao {
  @Query('SELECT * FROM Contagion')
  Stream<List<Contagion>> findAllContagions();

  @Query('DELETE FROM Contagion')
  Future<void> clearTable();

  @Query('SELECT * FROM Contagion')
  Future<List<Contagion>> allContagions();

  @insert
  Future<void> insertContagion(Contagion contagion);
}
