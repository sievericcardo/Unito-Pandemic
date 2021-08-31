import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/backend/disease.dart';

/// Class that maps the query to be done to the local db on the disease table
///
/// We set the queries that can be done on the table of diseases; we define
/// two different operations:
/// 2. Clear the data from the table
/// 3. Insert a new disease entry
@dao
abstract class DiseaseDao {
  @Query('DELETE FROM Disease')
  Future<void> clearTable();

  @insert
  Future<void> insertDisease(Disease disease);

  @Query('SELECT * FROM Disease')
  Future<List<Disease>> allDiseases();
}
