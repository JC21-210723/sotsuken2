import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'Database.dart';

class DBlist{

  //-list処理一覧-
  //ユーザIDセレクト用
  int selectid = 0; // 単一のint型変数として宣言
  Future<int> selectUserId(String sUserName) async {
    debugPrint("selectUserIdにきました");
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
    return selectid;
  }

  //特定ユーザのlist表を削除する
  Future deletelist(int userid) async {
    debugPrint('deletelistにきました');
    Database db = await DBProvider.instance.database;
    return await db.delete('list', where: 'userid = ?', whereArgs: [userid],);
  }


  //リスト表に個人追加成分の追加処理
  Future<int> insertlistAdd(int userid ,int addid) async {
    debugPrint("insertlistAddにきました");
    Database db = await DBProvider.instance.database;
    return await db.insert('list', {'userid': userid,'foodid': '--','beautyid': '--', 'addid': addid});
  }



  //変更処理1-09
  int deleteid = 0; // 単一のint型変数として宣言
  Future Deletelist(String username) async {
    debugPrint("deletelistにきました");
    Database db = await DBProvider.instance.database;

    //削除対象のuseridの特定
    final List<Map<String, dynamic>> deleteuserid = await db.query('user', where: 'username = ?', whereArgs: [username]);
    debugPrint('削除するユーザのidを特定しました$deleteuserid');

    for (Map<String, dynamic?> userMap in deleteuserid) {
      if (userMap.containsKey('userid')) {
        deleteid = userMap['userid'] as int;
        print('useridを出力：$deleteid');
        break; // ループを抜ける
      }
      return deleteid;
    }
    //ユーザidと一致するリストデータの削除
    debugPrint('リスト削除する対象ユーザidは$deleteidです');
    await db.delete('list', where: 'userid = ?', whereArgs: [deleteid],);
    debugPrint('リストを削除しました');
  }


}