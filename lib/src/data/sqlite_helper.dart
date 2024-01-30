import 'dart:developer';
import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteHelper {
  // static final SqliteHelper sqliteHelper = SqliteHelper._initDb();
  static Database? _database;
  static const tableName = 'financials';

  // SqliteHelper._initDb();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('financial.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    try {
      sqfliteFfiInit();
      final dbPath = await getDatabasesPath();
      final path = dbPath + filePath;
      return await openDatabase(path,
          version: 1,
          onCreate: (db, version) => _initTable(db, version));
    } on Exception catch (e) {
        log(e.toString());
      rethrow;
    }
  }

  static Future<void> _initTable(Database database, int version) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        description TEXT,
        value REAL,
        receivement INTEGER
      )
      """);
  }

  static Future<void> _dropTable(Database database, int version) async {
    await database.execute("""DROP TABLE financials""");
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
    // log(dbConnection.toString());
    return await dbConnection.insert(tableName, financialEntity.toMap());
  }

  Future<List<FinancialEntity>> findAll() async {
    final dbConnection = await database;
    final financialsMap =
        await dbConnection.query(tableName, orderBy: 'date ASC');
    return financialsMap.map((item) => FinancialEntity.fromMap(item)).toList();
  }

  Future<int> remove(List<dynamic>? queryArgs) async {
    final dbConnection = await database;
    return dbConnection.delete(tableName);
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
