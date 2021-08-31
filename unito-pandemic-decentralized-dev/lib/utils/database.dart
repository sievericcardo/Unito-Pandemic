import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:unito_pandemic_decentralized/model/backend/contagion.dart';
import 'package:unito_pandemic_decentralized/model/backend/disease.dart';
import 'package:unito_pandemic_decentralized/model/backend/news.dart';
import 'package:unito_pandemic_decentralized/model/dao/contagionDao.dart';
import 'package:unito_pandemic_decentralized/model/dao/diseaseDao.dart';
import 'package:unito_pandemic_decentralized/model/dao/heardDao.dart';
import 'package:unito_pandemic_decentralized/model/dao/newsDao.dart';
import 'package:unito_pandemic_decentralized/model/dao/saidDao.dart';
import 'package:unito_pandemic_decentralized/model/dao/simBeaconDao.dart';
import 'package:unito_pandemic_decentralized/model/db/simheard.dart';
import 'package:unito_pandemic_decentralized/model/db/simsaid.dart';
import 'package:unito_pandemic_decentralized/model/heard.dart';
import 'package:unito_pandemic_decentralized/model/said.dart';

part 'database.g.dart'; // the generated code will be there

/// Element for the local database
/// 
/// We keep track locally of various entity into an ecnrypted database, moreover
/// to enforce privacy we keep this information locally without sending them
/// to the central server
@Database(version: 1, entities: [Heard, Said, Contagion, Disease, News, SimHeard, SimSaid])
abstract class UnitoPandemicDatabase extends FloorDatabase {
  SaidDao get saidDao;
  HeardDao get heardDao;
  ContagionDao get contagionDao;
  DiseaseDao get diseaseDao;
  NewsDao get newsDao;
  SimBeaconDao get simBeaconDao;
}
