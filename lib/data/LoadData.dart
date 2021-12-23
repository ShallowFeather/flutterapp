import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/widgets.dart';

class InitData {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        """
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT,
            type TEXT,
            cost INTEGER,
            date TEXT,
            other TEXT,
          )
      """
    );

  }


}