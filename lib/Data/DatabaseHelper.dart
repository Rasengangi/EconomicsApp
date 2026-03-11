import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import '../Model/Transaction.dart'; 

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static sqflite.Database? _database;

  DatabaseHelper._init();

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<sqflite.Database> _initDB(String filePath) async {
    // Tilføj sqflite. foran getDatabasesPath
    final dbPath = await sqflite.getDatabasesPath();
    final path = join(dbPath, filePath);

    // Tilføj sqflite. foran openDatabase
    return await sqflite.openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Tilføj sqflite. foran Database her
  Future _createDB(sqflite.Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        beloeb INTEGER,
        kategori TEXT,
        beskrivelse TEXT,
        dato TEXT
      )
    ''');
  }

  
  Future<int> insert(Transaction t) async {
    final db = await instance.database;
    return await db.insert('transactions', {
      'beloeb': t.beloeb,
      'kategori': t.kategori,
      'beskrivelse': t.beskrivelse,
      'dato': t.dato.toIso8601String(),
    });
  }

  Future<List<Transaction>> fetchAll() async {
    final db = await instance.database;

    // 1. Hent alle rækker fra tabellen
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    // 2. Konvertér hver række (Map) til et Transaction objekt
    return List.generate(maps.length, (i) {
      return Transaction(
        maps[i]['beloeb'] as int,
        maps[i]['kategori'] as String,
        DateTime.parse(maps[i]['dato'] as String),
        maps[i]['beskrivelse'] as String,
      );
    });
  }
  
  Future<int> delete(String beskrivelse, int beloeb) async {
    final db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'beskrivelse = ? AND beloeb = ?',
      whereArgs: [beskrivelse, beloeb],
    );
  } 
}