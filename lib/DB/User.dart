import 'package:flutter/cupertino.dart';
import 'package:sotsuken2/main.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/AllUserData.dart';
import 'Database.dart';

class DBuser{

  //-ユーザ処理一覧-
  //ユーザの追加処理
  Future insertUser(AllUserData row) async {
    debugPrint("insertUserにきました");
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      return await db.insert('user', row.toMap());
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      return await db.insert('user2', row.toMap());
    }
  }

  //usernameを削除する
  Future deleteUser(String username) async {
    debugPrint('deleteUserにきました');
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      return await db.delete('user', where: 'username = ?', whereArgs: [username],);
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      return await db.delete('user2', where: 'username2 = ?', whereArgs: [username],);
    }

  }

  //usernameを更新する
  Future updateUser(String UserName,String afterName) async {
    debugPrint('updateUserにきました');
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      final values = <String, String>{"username": afterName,};
      await db.update("user", values, where: "username=?", whereArgs: [UserName],);
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      final values = <String, String>{"username2": afterName,};
      await db.update("user2", values, where: "username2=?", whereArgs: [UserName],);
    }
  }

  //userId,userNameをlistに格納する処理
  static List<int> userId = [];
  static List<String> userName = [];
  Future<List<String>> selectlistUser() async {
    debugPrint("selectUserにきました");
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      final userData = await db.query('user');
      userId.clear(); // リストを再度使用する前にクリアする
      userName.clear();
      for (Map<String, dynamic?> userMap in userData) {
        userMap.forEach((key, value) {
          if (key == 'userid') {
            userId.add(value as int);
          } else if (key == 'username') {
            userName.add(value as String);
          }
        });
      }
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      final userData = await db.query('user2');
      userId.clear(); // リストを再度使用する前にクリアする
      userName.clear();
      for (Map<String, dynamic?> userMap in userData) {
        userMap.forEach((key, value) {
          if (key == 'userid2') {
            userId.add(value as int);
          } else if (key == 'username2') {
            userName.add(value as String);
          }
        });
      }
    }
    return userName;
  }
}