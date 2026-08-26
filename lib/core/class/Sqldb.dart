import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> intialDb() async {
    String dataBais = await getDatabasesPath();
    String path = join(dataBais, 'Chafi.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 3,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldversion, int newVersion) async {
    print("_onUpgrade ===============");
    if (oldversion < 2) {
      await db.execute('''
        CREATE TABLE favorites(
          item_id INTEGER,
          item_type TEXT
        )
      ''');
    }
    if (oldversion < 3) {
      try {
        await db.execute('ALTER TABLE Post ADD COLUMN read_time TEXT');
      } catch (e) {
        print("Column read_time already exists: \$e");
      }
      try {
        await db.execute('ALTER TABLE Post ADD COLUMN chafi_advice TEXT');
      } catch (e) {
        print("Column chafi_advice already exists: \$e");
      }
      try {
        await db.execute('ALTER TABLE Post ADD COLUMN chafi_advice_fr TEXT');
      } catch (e) {
        print("Column chafi_advice_fr already exists: \$e");
      }
      try {
        await db.execute('ALTER TABLE Post ADD COLUMN legal_source TEXT');
      } catch (e) {
        print("Column legal_source already exists: \$e");
      }
      try {
        await db.execute('ALTER TABLE Post ADD COLUMN legal_source_fr TEXT');
      } catch (e) {
        print("Column legal_source_fr already exists: \$e");
      }
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    /// جدول التصنيفات
    batch.execute('''
    CREATE TABLE Post(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      image TEXT,
      type INTEGER NOT NULL,
      title TEXT,
      title2 TEXT,
      body TEXT,
      title_fr TEXT,
      title2_fr TEXT,
      body_fr TEXT,
      read_time TEXT,
      chafi_advice TEXT,
      chafi_advice_fr TEXT,
      legal_source TEXT,
      legal_source_fr TEXT,
      created_at TEXT,
      updated_at TEXT
    )
  ''');

    batch.execute('''
    CREATE TABLE read_institutions(
      institution_id INTEGER,
      id_read INTEGER DEFAULT 1
    )
  ''');

    batch.execute('''
    CREATE TABLE read_taxs_and_apps(
      tax_and_app_id INTEGER,
      id_read INTEGER DEFAULT 1
     )
  ''');

    batch.execute('''
    CREATE TABLE read_differents(
      different_id INTEGER,
      id_read INTEGER DEFAULT 1
    )
  ''');

    batch.execute('''
    CREATE TABLE favorites(
      item_id INTEGER,
      item_type TEXT
    )
  ''');

    await batch.commit();
    print(
      'Database and tables (with sync) created successfully ======================',
    );
  }

  // CRUD METHODS =============================================

  Future<List<Map<String, Object?>>> readData(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    Database? mydb = await db;
    return await mydb!.rawQuery(sql, arguments);
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql);
  }

  Future<int> updateData(String sql, List list) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql);
  }

  Future<void> mydeleteDatebase() async {
    String dataBais = await getDatabasesPath();
    String path = join(dataBais, 'Chafi.db');
    await deleteDatabase(path);
  }

  Future<List<Map>> read(String table) async {
    Database? mydb = await db;
    return await mydb!.query(table);
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    return await mydb!.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, Object?> values,
    String? where, [
    List<Object?>? whereArgs,
  ]) async {
    Database? mydb = await db;
    return await mydb!.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table,
    String? where, [
    List<Object?>? whereArgs,
  ]) async {
    Database? mydb = await db;
    return await mydb!.delete(table, where: where, whereArgs: whereArgs);
  }
}
