import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';
import 'Database.dart';

class DBlist{

  //ユーザIDセレクト用
  int selectid = 0;
  Future<int> selectUserId(String sUserName) async {
    debugPrint("selectUserIdにきました");
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      final List<Map<String, dynamic>> userid =
      await db.query('user', where: 'username = ?', whereArgs: [sUserName]);
      for (Map<String, dynamic?> userMap in userid) {
        if (userMap.containsKey('userid')) {
          selectid = userMap['userid'] as int;
          print('useridを出力：$selectid');
          break; // ループを抜ける
        }
      }
    }else if(Home_Page.flagCategory == 'beauty'){
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      final List<Map<String, dynamic>> userid =
      await db.query('user2', where: 'username2 = ?', whereArgs: [sUserName]);
      for (Map<String, dynamic?> userMap in userid) {
        if (userMap.containsKey('userid2')) {
          selectid = userMap['userid2'] as int;
          print('userid2を出力：$selectid');
          break; // ループを抜ける
        }
      }
    }
    return selectid;
  }

  //特定ユーザのlist表を削除する
  Future deletelist(int userid) async {
    debugPrint('deletelistにきました');
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      return await db.delete('list', where: 'userid = ?', whereArgs: [userid],);

    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      return await db.delete('list', where: 'userid2 = ?', whereArgs: [userid],);
    }
  }

  //リスト表に個人追加成分の追加処理
  Future insertlistAdd(int userid ,int addid) async {
    debugPrint("insertlistAddにきました");
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      return await db.insert('list', {'userid': userid,'userid2': '--','foodid': '--','beautyid': '--', 'addid': addid});
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      return await db.insert('list', {'userid': '--','userid2': userid,'foodid': '--','beautyid': '--', 'addid': addid});
    }
  }

  int deleteid = 0; // 単一のint型変数として宣言
  Future Deletelist(String username) async {
    debugPrint("deletelistにきました");
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Database db = await DBProvider.instance.database;
      //削除対象のuseridの特定
      final List<Map<String, dynamic>> deleteuserid = await db.query('user', where: 'username = ?', whereArgs: [username]);
      debugPrint('削除する食品ユーザのidを特定$deleteuserid');
      for (Map<String, dynamic?> userMap in deleteuserid) {
        if (userMap.containsKey('userid')) {
          deleteid = userMap['userid'] as int;
          print('useridを出力：$deleteid');
          break; // ループを抜ける
        }
        return deleteid;
      }
      //ユーザidと一致するリストデータの削除
      debugPrint('リスト削除対象の食品ユーザidは$deleteidです');
      await db.delete('list', where: 'userid = ?', whereArgs: [deleteid],);
      debugPrint('食品ユーザのリストを削除');
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      Database db = await DBProvider.instance.database;
      //削除対象のuseridの特定
      final List<Map<String, dynamic>> deleteuserid = await db.query('user2', where: 'username2 = ?', whereArgs: [username]);
      debugPrint('削除する美容ユーザのidを特定$deleteuserid');
      for (Map<String, dynamic?> userMap in deleteuserid) {
        if (userMap.containsKey('userid2')) {
          deleteid = userMap['userid2'] as int;
          print('userid2を出力：$deleteid');
          break; // ループを抜ける
        }
      return deleteid;
      }
      //ユーザidと一致するリストデータの削除
      debugPrint('リスト削除対象の美容ユーザidは$deleteidです');
      await db.delete('list', where: 'userid2 = ?', whereArgs: [deleteid],);
      debugPrint('美容ユーザのリストを削除');
    }
  }
}