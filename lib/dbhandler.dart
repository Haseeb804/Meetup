import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBhandle {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE myTable (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );

    return _database!;
  }
}
