import 'package:floor/floor.dart';
import 'package:unito_pandemic_decentralized/model/backend/news.dart';

/// Class that maps the query to be done to the local db on the news table
/// 
/// We set the queries that can be done on the table of news; we define
/// three different operations:
/// 1. Select all news
/// 2. Clear the data from the table
/// 3. Insert a new news
@dao
abstract class NewsDao {
  @Query('SELECT * FROM News')
  Stream<List<News>> findAllNews();

  @Query('DELETE FROM News')
  Future<void> clearTable();

  @insert
  Future<void> insertNews(News news);
}
