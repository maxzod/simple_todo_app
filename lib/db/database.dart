import 'package:path/path.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  static Database? _instance;
  static Future<Database> get instance async {
    return _instance ??= await AppDatabase._init();
  }

  AppDatabase._();

  static Future<Database> _init() async {
    final path = await getDownloadsDirectory();
    final dbPath = join(path!.path, 'todo.db');
    return await databaseFactoryFfi.openDatabase(dbPath,
        options: OpenDatabaseOptions(
          onCreate: _onCreate,
          version: 1,
        ));
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE "todos" (
	"id"		INTEGER,
	"text"		TEXT,
	"isDone"	INTEGER, 
	"createdAt"	TEXT,
	"updatedAt"	TEXT,
	"priority"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);''',
    );

    print('database created ! version: $version');
  }
}
