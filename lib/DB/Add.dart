import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'Database.dart';

class DBadd{

  //-追加成分の処理-
  //追加成分の新規登録処理(登録ボタンを押したときに実行)
  //個人追加表の追加処理
  Future<int> insertAdd(String hiragana, String kanji, String eigo,String otherName) async {
    debugPrint("insertAddにきました");
    Database db = await DBProvider.instance.database;
    return await db.insert('k_add', {'userid': 0, 'hiragana': hiragana, 'kanji': kanji, 'eigo': eigo, 'otherName': otherName, 'categoryid': 'TS'});
  }


  //AddIDセレクト用(食品)
  static int addid = 0; // 単一のint型変数として宣言
  Future<int> selectAddId(String checkadd) async {
    debugPrint("selectAddIdにきました");
    Database db = await DBProvider.instance.database;;

    final Addid = await db.rawQuery('select addid from k_add where hiragana = ? and categoryid = ?',[checkadd,'TS']);//変更1/12
    debugPrint('Addidをselectした内容：$Addid');

    for (Map<String, dynamic?> ADD in Addid) {//foodidはある
      ADD.forEach((key, value) {
        addid = value! as int; // foodidを1件ずつ格納
        debugPrint('追加されたaddid：$addid');
      });
    }
    return addid;
  }


  static List<String> AddList = [];//登録された追加成分hiraganaの全表示

  //追加登録成分の参照処理
  Future<List<String>> selectAdd() async {
    debugPrint("selectAddにきました");
    Database db = await DBProvider.instance.database;
    AddList.clear(); //前回のデータのクリア処理
    debugPrint('AddListをクリアしました：$AddList');

    //すべてのhiragana(食品）
    final hiragana = await db.rawQuery('SELECT hiragana FROM k_add where categoryid = ?',['TS']);//変更1/12
    debugPrint('hiraganaの内容：$hiragana');

    for (Map<String, dynamic?> ad in hiragana) {
      ad.forEach((key, value) {
        for (int x = 0; x < ad.length; x++) {
          if (key == 'hiragana') {
            AddList.add(value as String); // hiraganaを1件ずつ格納
            debugPrint('AddListの内容：$AddList');
          }
        }
      });
    }
    debugPrint('最終的にAddListに入れた内容：$AddList');
    return AddList;
  }




  //とあるユーザがリスト表に登録した追加成分の表示
  //アレルゲンの変更画面の表示に使用する
  static List<int> addvalue = [];//とあるユーザが登録したaddidのリスト
  static List<String> userAddList = [];//とあるユーザが登録したhiraganaのリスト

  Future<List<String>> selectUserADD(int userid) async {
    debugPrint("selectUserADDにきました");
    Database db = await DBProvider.instance.database;
    addvalue.clear();//前回データのクリア処理
    userAddList.clear();

    //とあるユーザがリスト表に登録した全てのaddid
    final addidlist = await db.rawQuery('select addid from list where userid = ?', [userid]);
    debugPrint('addidlistの内容：$addidlist');

    for (Map<String, dynamic?> add in addidlist) {
      add.forEach((key, value) {
        addvalue.add(value as int); // 登録されたaddidを1件ずつ格納
        debugPrint('addvalueの内容：$addvalue');
      });
    }
    debugPrint('最終的にaddvalueに入れた内容：$addvalue');

    for (int x = 0; x < addvalue.length; x++) {
      if(addvalue[x] != 0) { //addidが1以上なら、個人追加表に登録されているaddidと一致するhiraganaをもってくる 変更1/12　↓
        final hiragana = await db.rawQuery('SELECT hiragana FROM k_add where addid = ? and categoryid = ?', [addvalue[x],'TS']); //addidと一致するhiraganaを参照
        debugPrint('addidと一致したhiraganaの内容：$hiragana');
        for (Map<String, dynamic?> Hlist in hiragana) {//hiraganaの参照情報をMap<String, dynamic?>にいれる
          Hlist.forEach((key, value) {
            userAddList.add(value); //userAddListにhiraganaの情報をいれる
            debugPrint('userAddListとってこれているかな：$userAddList');
          });
        }
      }
    }
    debugPrint('最終的にuserAddListに入れた内容：$userAddList');
    return userAddList;
  }
  //追加1/15
  //追加成分を削除する
  Future deleteAdd(String hiragana) async {
    debugPrint('deleteAddにきました');
    Database db = await DBProvider.instance.database;
    return await db.delete('K_add', where: 'hiragana = ?', whereArgs: [hiragana],);
  }
  Future deletelistAdd(int addid) async {
    debugPrint('deletelistAddにきました');
    Database db = await DBProvider.instance.database;
    return await db.delete('list', where: 'addid = ?', whereArgs: [addid],);
  }

}