import 'package:exam_project/data/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDbService {
  final String _transactionTable = "incomes";

  /// DB Singleton
  TransactionDbService._();

  static final _singleTon = TransactionDbService._();

  factory TransactionDbService() => _singleTon;

  Database? _database;

  Future<void> _createDb(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $_transactionTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      type TEXT NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      categoryType TEXT NOT NULL,
      categoryTitle TEXT NOT NULL
    )
    """);
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    final path = "$dbPath/appDatabase.db";
    final db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    } else {
      final db = await _initDb();
      return db;
    }
  }

  /// GET Transactions
  Future<List<TransactionModel>> getAllTransactions() async {
    final dbInstance = await db;
    final result =
        await dbInstance.rawQuery("SELECT * FROM $_transactionTable");
    return result.map((e) => TransactionModel.fromMap(e)).toList();
  }

  /// ADD Transaction
  Future<void> addTransaction({required TransactionModel income}) async {
    final dbInstance = await db;
    try {
      dbInstance.insert(_transactionTable, income.toMap());
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE Transaction
  Future<void> deleteTransaction(int id) async {
    final dbInstance = await db;
    try {
      await dbInstance
          .delete(_transactionTable, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }

  /// UPDATE Transaction
  Future<void> updateTransaction(int id, TransactionModel newIncome) async {
    final dbInstance = await db;
    try {
      dbInstance.update(
        _transactionTable,
        newIncome.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      rethrow;
    }
  }
}
