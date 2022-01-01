import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:count/data/GoodsClass.dart';

class UseDatabase {
  static final UseDatabase instance = UseDatabase._init();
  static Database? _database;
  UseDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('owo.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE item( 
  ${GoodsField.id} $idType, 
  ${GoodsField.name} $textType, 
  ${GoodsField.type} $textType, 
  ${GoodsField.cost} $integerType, 
  ${GoodsField.other} TEXT, 
  ${GoodsField.date} $textType 
) 
''');
  }

  Future<LastGoods> create(LastGoods Data) async {
    final db = await instance.database;
    final id = await db.insert("item", Data.toMap());
    return Data.copy(id: id);
  }

  Future<List<LastGoods>> readAllitems() async {
    final db = await instance.database;
    final orderBy = 'id';
    final result = await db.query("item", orderBy: orderBy);
    return result.map((json) => LastGoods.formMap(json)).toList();
  }

}