import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_keeper/models/note.dart';



class DatabaseHelper {

  //Singleton DatabaseHelper
  static DatabaseHelper _databaseHelper;

  //Singleton Database
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  //Nameed constructor to create instance of DatabaseHelper
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    //This will only execute once, single object
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  Future initDatabase() async {
    //Get the directory path for both Android and iOS to store database
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + 'notes.db';

    //Open/Create the DB at a given path
    var notesDataBase = await openDatabase(path, version: 1, onCreate: _createDb); 

    return notesDataBase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //Fetch OPeration: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    //var result = await db.rawQuery('SELECT * FROM $noteTable ORDER BY $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  //Insert Operation: Insert a note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());

    return result;
  }

  //Update Operation: Update a note object and save it to database
  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);

    return result;
  }

  //Delete Operation: Delete a note object from database
  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');

    return result;
  }

  //Get number of note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


}