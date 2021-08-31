// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorUnitoPandemicDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UnitoPandemicDatabaseBuilder databaseBuilder(String name) =>
      _$UnitoPandemicDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UnitoPandemicDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$UnitoPandemicDatabaseBuilder(null);
}

class _$UnitoPandemicDatabaseBuilder {
  _$UnitoPandemicDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$UnitoPandemicDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$UnitoPandemicDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<UnitoPandemicDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$UnitoPandemicDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UnitoPandemicDatabase extends UnitoPandemicDatabase {
  _$UnitoPandemicDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SaidDao _saidDaoInstance;

  HeardDao _heardDaoInstance;

  ContagionDao _contagionDaoInstance;

  DiseaseDao _diseaseDaoInstance;

  NewsDao _newsDaoInstance;

  SimBeaconDao _simBeaconDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Heard` (`id` INTEGER, `contact` TEXT, `timestamp` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Said` (`id` INTEGER, `contact` TEXT, `timestamp` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Contagion` (`id` INTEGER, `infected` TEXT, `timestamp` INTEGER, `diseaseId` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Disease` (`id` INTEGER, `name` TEXT, `contagionProbability` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `News` (`id` INTEGER, `body` TEXT, `timestamp` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SimHeard` (`simId` INTEGER, `id` INTEGER, `contact` TEXT, `timestamp` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SimSaid` (`simId` INTEGER, `id` INTEGER, `contact` TEXT, `timestamp` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SaidDao get saidDao {
    return _saidDaoInstance ??= _$SaidDao(database, changeListener);
  }

  @override
  HeardDao get heardDao {
    return _heardDaoInstance ??= _$HeardDao(database, changeListener);
  }

  @override
  ContagionDao get contagionDao {
    return _contagionDaoInstance ??= _$ContagionDao(database, changeListener);
  }

  @override
  DiseaseDao get diseaseDao {
    return _diseaseDaoInstance ??= _$DiseaseDao(database, changeListener);
  }

  @override
  NewsDao get newsDao {
    return _newsDaoInstance ??= _$NewsDao(database, changeListener);
  }

  @override
  SimBeaconDao get simBeaconDao {
    return _simBeaconDaoInstance ??= _$SimBeaconDao(database, changeListener);
  }
}

class _$SaidDao extends SaidDao {
  _$SaidDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _saidInsertionAdapter = InsertionAdapter(
            database,
            'Said',
            (Said item) => <String, dynamic>{
                  'id': item.id,
                  'contact': item.contact,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _saidMapper = (Map<String, dynamic> row) =>
      Said(row['contact'] as String, row['timestamp'] as int);

  final InsertionAdapter<Said> _saidInsertionAdapter;

  @override
  Stream<List<Said>> findAllHeards() {
    return _queryAdapter.queryListStream('SELECT * FROM Heard',
        queryableName: 'Said', isView: false, mapper: _saidMapper);
  }

  @override
  Future<void> insertSaid(Said said) async {
    await _saidInsertionAdapter.insert(said, OnConflictStrategy.abort);
  }
}

class _$HeardDao extends HeardDao {
  _$HeardDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _heardInsertionAdapter = InsertionAdapter(
            database,
            'Heard',
            (Heard item) => <String, dynamic>{
                  'id': item.id,
                  'contact': item.contact,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _heardMapper = (Map<String, dynamic> row) =>
      Heard(row['contact'] as String, row['timestamp'] as int);

  final InsertionAdapter<Heard> _heardInsertionAdapter;

  @override
  Stream<List<Heard>> findAllHeards() {
    return _queryAdapter.queryListStream('SELECT * FROM Heard',
        queryableName: 'Heard', isView: false, mapper: _heardMapper);
  }

  @override
  Future<List<Heard>> findAllHeardsSync() async {
    return _queryAdapter.queryList('SELECT * FROM Heard', mapper: _heardMapper);
  }

  @override
  Future<void> insertHeard(Heard heard) async {
    await _heardInsertionAdapter.insert(heard, OnConflictStrategy.abort);
  }
}

class _$ContagionDao extends ContagionDao {
  _$ContagionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _contagionInsertionAdapter = InsertionAdapter(
            database,
            'Contagion',
            (Contagion item) => <String, dynamic>{
                  'id': item.id,
                  'infected': item.infected,
                  'timestamp': item.timestamp,
                  'diseaseId': item.diseaseId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _contagionMapper = (Map<String, dynamic> row) => Contagion(
      row['id'] as int,
      row['infected'] as String,
      row['timestamp'] as int,
      row['diseaseId'] as int);

  final InsertionAdapter<Contagion> _contagionInsertionAdapter;

  @override
  Stream<List<Contagion>> findAllContagions() {
    return _queryAdapter.queryListStream('SELECT * FROM Contagion',
        queryableName: 'Contagion', isView: false, mapper: _contagionMapper);
  }

  @override
  Future<void> clearTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Contagion');
  }

  @override
  Future<List<Contagion>> allContagions() async {
    return _queryAdapter.queryList('SELECT * FROM Contagion',
        mapper: _contagionMapper);
  }

  @override
  Future<void> insertContagion(Contagion contagion) async {
    await _contagionInsertionAdapter.insert(
        contagion, OnConflictStrategy.abort);
  }
}

class _$DiseaseDao extends DiseaseDao {
  _$DiseaseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _diseaseInsertionAdapter = InsertionAdapter(
            database,
            'Disease',
            (Disease item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'contagionProbability': item.contagionProbability
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _diseaseMapper = (Map<String, dynamic> row) => Disease(
      id: row['id'] as int,
      name: row['name'] as String,
      contagionProbability: row['contagionProbability'] as double);

  final InsertionAdapter<Disease> _diseaseInsertionAdapter;

  @override
  Future<void> clearTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Disease');
  }

  @override
  Future<List<Disease>> allDiseases() async {
    return _queryAdapter.queryList('SELECT * FROM Disease',
        mapper: _diseaseMapper);
  }

  @override
  Future<void> insertDisease(Disease disease) async {
    await _diseaseInsertionAdapter.insert(disease, OnConflictStrategy.abort);
  }
}

class _$NewsDao extends NewsDao {
  _$NewsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _newsInsertionAdapter = InsertionAdapter(
            database,
            'News',
            (News item) => <String, dynamic>{
                  'id': item.id,
                  'body': item.body,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _newsMapper = (Map<String, dynamic> row) =>
      News(row['body'] as String, row['timestamp'] as int);

  final InsertionAdapter<News> _newsInsertionAdapter;

  @override
  Stream<List<News>> findAllNews() {
    return _queryAdapter.queryListStream('SELECT * FROM News',
        queryableName: 'News', isView: false, mapper: _newsMapper);
  }

  @override
  Future<void> clearTable() async {
    await _queryAdapter.queryNoReturn('DELETE FROM News');
  }

  @override
  Future<void> insertNews(News news) async {
    await _newsInsertionAdapter.insert(news, OnConflictStrategy.abort);
  }
}

class _$SimBeaconDao extends SimBeaconDao {
  _$SimBeaconDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _simHeardInsertionAdapter = InsertionAdapter(
            database,
            'SimHeard',
            (SimHeard item) => <String, dynamic>{
                  'simId': item.simId,
                  'id': item.id,
                  'contact': item.contact,
                  'timestamp': item.timestamp
                },
            changeListener),
        _simSaidInsertionAdapter = InsertionAdapter(
            database,
            'SimSaid',
            (SimSaid item) => <String, dynamic>{
                  'simId': item.simId,
                  'id': item.id,
                  'contact': item.contact,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _simSaidMapper = (Map<String, dynamic> row) => SimSaid(
      row['contact'] as String, row['timestamp'] as int, row['simId'] as int);

  static final _simHeardMapper = (Map<String, dynamic> row) => SimHeard(
      row['contact'] as String, row['timestamp'] as int, row['simId'] as int);

  final InsertionAdapter<SimHeard> _simHeardInsertionAdapter;

  final InsertionAdapter<SimSaid> _simSaidInsertionAdapter;

  @override
  Stream<List<SimSaid>> findAllSimSaids() {
    return _queryAdapter.queryListStream('SELECT * FROM SimSaid',
        queryableName: 'SimSaid', isView: false, mapper: _simSaidMapper);
  }

  @override
  Stream<List<SimHeard>> findAllSimHeards() {
    return _queryAdapter.queryListStream('SELECT * FROM SimHeard',
        queryableName: 'SimHeard', isView: false, mapper: _simHeardMapper);
  }

  @override
  Future<void> insertSimHeard(SimHeard item) async {
    await _simHeardInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertSimSaid(SimSaid item) async {
    await _simSaidInsertionAdapter.insert(item, OnConflictStrategy.abort);
  }
}
