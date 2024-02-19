import 'package:envelope/db/models/account.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  final Future<Database> _database = Future(() async =>
      await openDatabase(join(await getDatabasesPath(), "envelope.db"),
          onCreate: (db, version) {
        return db.execute('''
          ${Account.create}
        ''');
      }));

  Future<void> addAccount(Account account) async {
    final db = await _database;
    await db.insert(Account.tableName, account.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Account>> getAccounts() async {
    final db = await _database;
    return (await db.query(Account.tableName)).map(Account.fromJson).toList();
  }

  Future<Account> getAccount(int id) async {
    final db = await _database;
    return Account.fromJson((await db.query(Account.tableName,
        where: 'id = ?', whereArgs: [id], limit: 1))[0]);
  }
}
