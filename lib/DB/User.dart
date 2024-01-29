import 'package:flutter/cupertino.dart';
import 'package:sotsuken2/main.dart';
import 'package:sqflite/sqflite.dart';
import '../Data/AllUserData.dart';
import 'Database.dart';

class DBuser{

  //ユーザの追加処理
  Future insertUser(AllUserData row) async {
    debugPrint("insertUserにきました");
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      return await db.insert('user', row.toMap());
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      Map<String, String> toMap = {
        "username2":AllUserData.sUserName,
      };
      return await db.insert('user2',toMap);
    }
  }

  //usernameを削除する
  Future deleteUser(String username) async {
    debugPrint('deleteUserにきました');
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      return await db.delete('user', where: 'username = ?', whereArgs: [username],);
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      return await db.delete('user2', where: 'username2 = ?', whereArgs: [username],);
    }

  }

  //usernameを更新する
  Future updateUser(String UserName,String afterName) async {
    debugPrint('updateUserにきました');
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      final values = <String, String>{"username": afterName,};
      await db.update("user", values, where: "username=?", whereArgs: [UserName],);
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      final values = <String, String>{"username2": afterName,};
      await db.update("user2", values, where: "username2=?", whereArgs: [UserName],);
    }
  }

  //userId,userNameをlistに格納する処理
  static List<int> userId = [];
  static List<String> userName = [];
  List<Map<String,dynamic>> userData = [];
  Future<List<String>> selectlistUser() async {
    debugPrint("selectUserにきました");
    Database db = await DBProvider.instance.database;
    userId.clear(); // リストを再度使用する前にクリアする
    userName.clear();
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      userData = await db.query('user');
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      userData = await db.query('user2');
    }
    for (Map<String, dynamic?> userMap in userData) {
      userMap.forEach((key, value) {
        if (key == 'userid') {
          userId.add(value as int);
        } else if (key == 'username') {
          userName.add(value as String);
        }else if (key == 'userid2') {
          userId.add(value as int);
        }else if (key == 'username2') {
          userName.add(value as String);
        }
      });
    }
    return userName;
  }
}