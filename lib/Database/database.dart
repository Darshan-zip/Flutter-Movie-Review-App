import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'accounts.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS users(person_id INTEGER PRIMARY KEY AUTOINCREMENT,first_name TEXT, last_name TEXT, email TEXT, password TEXT )');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('users', row);
  }

  Future<List<Map<String, dynamic>>> queryUsers() async {
    Database db = await instance.database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> querySingleUser(
      String email, String password) async {
    Database db = await instance.database;
    return await db.query('users',
        where: 'email=? AND password=?', whereArgs: [email, password]);
  }
}


class ReviewsDatabase {
  static Database? _database;
  static final ReviewsDatabase instance = ReviewsDatabase._privateConstructor();
  ReviewsDatabase._privateConstructor();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'review.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS reviews(review_id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, name TEXT, rating INTEGER, content TEXT, title TEXT)');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('reviews', row);
  }

  Future<List<Map<String, dynamic>>> queryUsers() async {
    Database db = await instance.database;
    return await db.query('reviews');
  }

  Future<List<Map<String, dynamic>>> getAllReviews(int id) async {
    Database db = await instance.database;
    return await db.query('reviews',
        where: 'person_id=?', whereArgs: [id]);
  }

}


class FavouritesDatabase {
  static Database? _database;
  static final FavouritesDatabase instance = FavouritesDatabase._privateConstructor();
  FavouritesDatabase._privateConstructor();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favourites.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS favs(favourites_id INTEGER PRIMARY KEY AUTOINCREMENT, person_id INTEGER, movie_id INTEGER)');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('favs', row);
  }

  Future<List<Map<String, dynamic>>> queryUsers() async {
    Database db = await instance.database;
    return await db.query('favs');
  }

  Future<List<Map<String, dynamic>>> getFavourites(int personId) async {
    Database db = await instance.database;
    return await db.query('favs',
        where: 'person_id=?', whereArgs: [personId]);
  }

  Future<bool> isFavourite(int personId, int movieId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> ans = await db.query('favs', where: 'person_id=? AND movie_id=?', whereArgs: [personId, movieId]);
    return ans.isNotEmpty;
  }

  Future<void> deleteFavorite(int personId, int movieId) async {
    Database db = await instance.database;
    await db.delete(
      'favs',
      where: 'person_id = ? AND movie_id = ?',
      whereArgs: [personId, movieId],
    );
  }
}