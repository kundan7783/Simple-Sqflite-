import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? myDB;

  static final String TABLE_NOTE="note";
  static final String COLUMN_NOTE_ID="id";
  static final String COLUMN_NOTE_NAME="name";
  static final String COLUMN_NOTE_PHONE="phone";

   Future<Database> getDB() async {
    if(myDB != null){
      return myDB!;
    }else{
      myDB= await openDB();
      return myDB!;
    }

  }

   Future<Database> openDB() async {
    Directory directory= await getApplicationDocumentsDirectory();
    String dbPath=join(directory.path,"myDB.db");
    return openDatabase(dbPath,onCreate: (db, version) {
      db.execute("create table $TABLE_NOTE ($COLUMN_NOTE_ID integer primary key autoincrement,$COLUMN_NOTE_NAME text,$COLUMN_NOTE_PHONE text)");
    },version: 1);
  }

  Future<bool> setData({ required String name, required String number}) async {
    var db = await getDB();
    int insert = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_NAME: name,
      COLUMN_NOTE_PHONE: number
    });
    return insert > 0;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    var db = await openDB();
    List<Map<String, dynamic>> getData = await db.query(TABLE_NOTE);
    return getData;
  }

  Future<bool> updateData({ required int id, required String name, required String number}) async {
    var db = await openDB();
    var update = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_NAME: name,
      COLUMN_NOTE_PHONE: number
    },
      where: "$COLUMN_NOTE_ID = ?",
      whereArgs: [id],
    );
    return update > 0;
  }

  Future<bool> deleteData({ required int id}) async {
    var db = await openDB();
    int delete= await db.delete(TABLE_NOTE,where: "$COLUMN_NOTE_ID = ?", whereArgs: [id],);
    return delete>0;
  }

}