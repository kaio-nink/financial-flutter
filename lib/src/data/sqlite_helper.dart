import 'package:financial_flutter/src/data/financial_entity.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqliteHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS financial(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        description TEXT,
        value REAL,
        receivement INTEGER
      )
      """);
  }

  static Future<sql.Database> dbConnection() async {
    var factory = databaseFactoryFfiWeb;
    return factory.openDatabase('financial.db');
  }

  static Future<void> dbClose(sql.Database db) async {
    db.close();
  }

  static Future<int> insertFinancial(
      sql.Database db, FinancialEntity financialEntity) async {
    var date = financialEntity.date;
    var description = financialEntity.description;
    var value = financialEntity.value;
    var receivement = financialEntity.receivement ? 1 : 0;
    return db.insert('financial', {
      'date': date,
      'description': description,
      'value': value,
      'receivement': receivement,
    });
  }

  static Future<List<FinancialEntity>> listFinancials(sql.Database db) async {
    try {
      List<Map<String, Object?>> financials = await db.query('financial');
      print(financials);
      List<FinancialEntity> financialEntities = [];
      // for (var element in financials) {
      //   // print(element);
        
      // }

      return financialEntities;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
