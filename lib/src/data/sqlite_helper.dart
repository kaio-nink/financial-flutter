import 'dart:developer';
import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteHelper {
  // static final SqliteHelper sqliteHelper = SqliteHelper._initDb();
  static Database? _database;
  // SqliteHelper._initDb();
  Future<Database> get database async {
    if (_database != null) return _database!;
    print('adwadwadwad');
    _database = await _initDb('financial.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    try {
      sqfliteFfiInit();
      final dbPath = await getDatabasesPath();
      final path = dbPath + filePath;
      // final databaseFactory = databaseFactoryFfi;
      // return await databaseFactory.openDatabase(path,
      //     options:
      //         OpenDatabaseOptions(onCreate: (db, version) => _initTable(db)));
      return await openDatabase(path,
          onCreate: (db, version) => _initTable(db));
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> _initTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS financials(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        description TEXT,
        value REAL,
        receivement INTEGER
      )
      """);
  }

  // static Future<Database> dbConnection() async {
  //   var factory = databaseFactoryFfiWeb;
  //   return factory.openDatabase('financial.db');
  // }

  // static Future<void> dbClose(sql.Database db) async {
  //   db.close();
  // }

  Future<int> create(FinancialEntity financialEntity) async {
    final dbConnection = await database;
    log(dbConnection.toString());
    return await dbConnection.insert('financial', financialEntity.toMap());
  }

  Future<List<FinancialEntity>> findAll() async {
    final dbConnection = await database;
    final financialsMap =
        await dbConnection.query('financials', orderBy: 'date ASC');
    return financialsMap.map((item) => FinancialEntity.fromMap(item)).toList();
  }

  // static Future<List<FinancialEntity>> listFinancials(sql.Database db) async {
  //   try {
  //     List<Map<String, Object?>> financials = await db.query('financial');
  //     // print(financials);
  //     List<FinancialEntity> financialEntities = [];
  //     for (var element in financials) {
  //       // log(element['description'].toString());
  //       FinancialEntity fin = FinancialEntity(element['id'] as int, element['date'] as String,
  //           element['description'] as String, element['value'] as double, element['receivement'] as bool);
  //       log('$fin\n');
  //     }
  //     return financialEntities;
  //   } on Exception {
  //     rethrow;
  //   }
  // }
}
