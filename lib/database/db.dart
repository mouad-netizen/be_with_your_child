import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import '../utility/User.dart';



class SqlDb{

  static int parentMessages=0;
  static int childMessages=0;
  static Future<void> createTables(sql.Database database) async{

    await database.execute("""
     CREATE TABLE data (
     id INTEGER  PRIMARY KEY AUTOINCREMENT,
     title TEXT,
     desc TEXT,
     imagePath TEXT,
     createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
     
     ) 
   
  
  """);
    await database.execute("""
     CREATE TABLE "user" (
                  "id_user" INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT,
                  "firstName" Text NOT NULL ,
                  "lastName" Text NOT NULL ,
                  "email" Text NOT NULL ,
                  "phoneNumber" Text NOT NULL ,
                  "password" Text NOT NULL ,
                  "image" Text
              )
   
  
  """);

    await database.execute("""
          CREATE TABLE "message" (
        "id_message" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "content" TEXT NOT NULL,
        "author" TEXT NOT NULL,
        "createdAt" TEXT NOT NULL DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
      )

   
  
  """);



  print('the table mouad et data have successfuly created ');

  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
        "database_name.db",
        version: 1,
        onCreate: (sql.Database database,int version) async{

          await createTables(database);
        }
    );

  }



  static Future<int> createData(String item,String? desc,String? image) async{
    final db =await SqlDb.db();
    final data = {'title':item,'desc':desc,'imagePath':image};
    final id = await db.insert('data', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;

  }


  static Future<List<Map<String,dynamic>>> getAllData() async {
    final db = await SqlDb.db();
    return db.query('data',orderBy: 'id');
  }

  static Future<List<Map<String,dynamic>>> getSingleData(int id) async {
    final db = await SqlDb.db();
    return db.query('data',where: 'id = ?',whereArgs: [id],limit: 1);
  }


  static Future<int>  updateData(int id , String title , String? desc, String? image) async{
    final db = await SqlDb.db();
    final data={
      'title' :title,
      'desc':desc,
      'imagePath':image,
      'createdAt':DateTime.now().toString()
    };
    final result = await db.update('data',data,where: 'id = ?',whereArgs: [id]);
    return result;

  }


  static Future<void> deleteData (int id) async {
    final db = await SqlDb.db();
    try{
      await db.delete('data',where:  'id = ?',whereArgs: [id]);
    }catch(e){
      print('la suppression ne peut pas s\'effectuer en succées $e');
    }
  }

  static Future<void> deletDatabase() async{
    final db =await SqlDb.db();
    String databasePath =await sql.getDatabasesPath();//to get the database path
    String path =join(databasePath,"database_name.db");
    await sql.deleteDatabase(path);
    print('=================================>database deleted seccessfuly');
  }

  //user functions

  static Future<int> createDatauser(User user ) async{
    final db =await SqlDb.db();
    final id = await db.insert('user', user.UserTomap(user),conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print('data of user added successfuly =======================>');
    return id;

  }
  static Future<List<Map<String,dynamic>>> getAllUserData() async {
    final db = await SqlDb.db();
    return db.query('user',orderBy: 'id_user');
  }

  static Future<User> getSingleUserData(int id) async {
    final db = await SqlDb.db();
    List<Map<String,dynamic>> userList =await db.query('user',where: 'id_user = ?',whereArgs: [id],limit: 1);
    return User(firstName:userList[1]['firstName'], lastName:userList[1]['lastName'] , email:userList[1]['email'] , phoneNumber:userList[1]['phoneNumber']  , password:userList[1]['password'],image: userList[1]['image'] );

  }

  static Future<int>  updateUserData(User user,int id) async{
    final db = await SqlDb.db();
    final result = await db.update('user',user.UserTomap(user),where: 'id = ?',whereArgs: [id]);
    return result;

  }


  // MESSAGES

  static Future<List<Map<String,dynamic>>> getAllMessages() async {
    final db = await SqlDb.db();
    return db.query('message',orderBy: 'id_message');
  }

  static Future<int> createMessage(String author,String content) async{
    if(author == 'child')
      childMessages++;
    else
      parentMessages++;

    print('the perent messages is $parentMessages');
    print('the child messages is  $childMessages');
    final db =await SqlDb.db();
    final data = {'content':content,'author':author};

    print('message $content has added succesfuly');
    final id = await db.insert('message', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;

  }



}