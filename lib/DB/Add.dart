import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';
import 'Database.dart';

class DBadd{

  //追加成分の新規登録処理(登録ボタンを押したときに実行)
  Future insertAdd(String hiragana, String kanji, String eigo,String otherName) async {
    debugPrint("insertAddにきました");
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      return await db.insert('k_add', {'userid': 0, 'hiragana': hiragana, 'kanji': kanji, 'eigo': eigo, 'otherName': otherName, 'categoryid': 'TS'});
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      return await db.insert('beauty', {'beautyname': hiragana, 'kanji': kanji, 'eigo': eigo, 'otherName': otherName, 'categoryid': 'BH'});
    }
  }

  static int addid = 0; //AddIDセレクト用
  List<Map<String, dynamic>> Addid = [];
  Future<int> selectAddId(String checkadd) async {
    debugPrint("selectAddIdにきました");
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      Addid = await db.rawQuery('select addid from k_add where hiragana = ? and categoryid = ?',[checkadd,'TS']);
      debugPrint('Addidをselectした内容：$Addid');
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      Addid = await db.rawQuery('select beautyid from beauty where beautyname = ?',[checkadd]);
      debugPrint('beautyidをselectした内容：$Addid');
    }
    for (Map<String, dynamic?> ADD in Addid) {//foodidはある
      ADD.forEach((key, value) {
        addid = value! as int; // foodidを1件ずつ格納
        debugPrint('追加されたaddid：$addid');
      });
    }
    return addid;
  }

  static List<String> AddList = [];//登録された追加成分hiraganaの全表示
  static List<String> shortAddList = [];
  static List<String> longAddList = [];
  List<Map<String, dynamic>> hiragana2 = [];
  //追加登録成分の参照処理
  Future<List<String>> selectAdd() async {
    debugPrint("selectAddにきました");
    Database db = await DBProvider.instance.database;
    AddList.clear(); //前回のデータのクリア処理
    debugPrint('AddListをクリアしました：$AddList');
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      //すべてのhiragana(食品）
      hiragana2 = await db.rawQuery('SELECT hiragana FROM k_add where categoryid = ?',['TS']);
      debugPrint('hiraganaの内容：$hiragana2');
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      hiragana2 = await db.rawQuery('SELECT beautyname FROM beauty');
      debugPrint('hiraganaの内容：$hiragana2');
    }
    for (Map<String, dynamic?> ad in hiragana2) {
      ad.forEach((key, value) {
        for (int x = 0; x < ad.length; x++) {
          if (key == 'hiragana') {
            AddList.add(value as String); // hiraganaを1件ずつ格納
          }if(key == 'beautyname'){
            AddList.add(value as String); // hiraganaを1件ずつ格納
          }
        }
      });
    }
    AddList.sort((a,b) => a.length.compareTo(b.length));
    debugPrint('最終的にAddListに入れた内容：$AddList');

    //勝手に書いたごめん
    shortAddList = [];
    longAddList = [];
    for(String adl in AddList){
      if(adl.length <= 4){
        shortAddList.add(adl);
      }else if(adl.length > 4){
        longAddList.add(adl);
      }
    }

    return AddList;
  }

  //とあるユーザが登録した成分の表示
  static List<int> addvalue = [];//とあるユーザが登録したaddidのリスト
  static List<String> userAddList = [];//とあるユーザが登録したhiraganaのリスト
  List<Map<String,dynamic>> addidlist = [];
  List<Map<String,dynamic>> hiragana = [];
  Future<List<String>> selectUserADD(int userid) async {
    debugPrint("selectUserADDにきました");
    Database db = await DBProvider.instance.database;
    addvalue.clear();//前回データのクリア処理
    userAddList.clear();
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      //とあるユーザがリスト表に登録した全てのaddid
      addidlist = await db.rawQuery('select addid from list where userid = ?', [userid]);
      debugPrint('addidlistの内容：$addidlist');
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      addidlist = await db.rawQuery('select beautyid from list where userid2 = ?', [userid]);
      debugPrint("beautyidは：$addidlistです");
    }
    for (Map<String, dynamic?> add in addidlist) {
      add.forEach((key, value) {
        addvalue.add(value as int); // 登録されたaddidを1件ずつ格納
      });
    }
    debugPrint('最終的にaddvalueに入れた内容：$addvalue');
    for (int x = 0; x < addvalue.length; x++) {
      if(addvalue[x] != 0) { //addidが1以上なら、登録されているidと一致するhiraganaをもってくる
        if(Home_Page.flagCategory == 'food'){
          debugPrint("foodです");
          hiragana = await db.rawQuery('SELECT hiragana FROM k_add where addid = ? and categoryid = ?', [addvalue[x],'TS']); //addidと一致するhiraganaを参照
          debugPrint('addidと一致したhiraganaの内容：$hiragana');
        }else if(Home_Page.flagCategory == 'beauty') {
          debugPrint("beautyです");
          hiragana = await db.rawQuery('SELECT beautyname FROM beauty where beautyid = ?', [addvalue[x]]); //addidと一致するhiraganaを参照
          debugPrint('beautyidと一致したbeautynameの内容：$hiragana');
        }
        for (Map<String, dynamic?> Hlist in hiragana) {//hiraganaの参照情報をMap<String, dynamic?>にいれる
          Hlist.forEach((key, value) {
            userAddList.add(value); //userAddListにhiraganaの情報をいれる
            debugPrint('userAddListとってこれているかな：$userAddList');
          });
        }
      }
    }
    userAddList.sort((a,b) => a.length.compareTo(b.length));
    debugPrint('最終的にuserAddListに入れた内容：$userAddList');
    return userAddList;
  }

  Future deleteAdd(String hiragana) async {//追加成分を削除する
    debugPrint('deleteAddにきました');
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      return await db.delete('K_add', where: 'hiragana = ?', whereArgs: [hiragana],);
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      return await db.delete('beauty', where: 'beautyname = ?', whereArgs: [hiragana],);
    }
  }

  Future deletelistAdd(int addid) async {
    debugPrint('deletelistAddにきました');
    Database db = await DBProvider.instance.database;
    if(Home_Page.flagCategory == 'food'){
      debugPrint("foodです");
      return await db.delete('list', where: 'addid = ?', whereArgs: [addid],);
    }else if(Home_Page.flagCategory == 'beauty') {
      debugPrint("beautyです");
      return await db.delete('list', where: 'beautyid = ?', whereArgs: [addid],);
    }
  }
}