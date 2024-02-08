import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../DB/Database.dart';
import '../DB/List.dart';
import '../DB/User.dart';
import '../Data/AllAnotherData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../main.dart';
import 'api.dart';

class verifications{
  verifications._();
  static final verifications instance = verifications._();

  List<String> select = [];
  int userid = 0;
  List<String> resultVal = [];
  // 文字認識結果とユーザ選択成分の照合
  Future<List<String>> verification() async{
    select.clear();
    resultVal.clear();
    Database db = await DBProvider.instance.database;

    if(Home_Page.flagCategory == 'food'){
      print("食品が選択されたよ");

      List<String> foodNameValue = [];  //表示義務・推奨
      List<String> addNameValue = [];   //追加成分

      print("これからユーザ検証");
      if((DBuser.userId.contains(userid))){
        print("ユーザ居た");

        final foodId = await db.rawQuery('SELECT foodid FROM list where userid = ?', [userid]);
        //foodidのvalueのみ抽出
        List<String> foodIDValue = foodId.map((e) => e['foodid'].toString()).toList();

        //foodidからfoodnameをセレクト
        for (String id in foodIDValue) {
          final foodId2 = await db.rawQuery('SELECT foodname FROM food where foodid = ?', [id]);
          foodNameValue.addAll(foodId2.map((e) => e['foodname'].toString()));
        }

        select.addAll(foodNameValue);
        print("義務/推奨を入れたselect：$select");

        //とあるユーザがリスト表に登録しているaddidを取得
        final addid = await db.rawQuery('SELECT addid FROM list where userid = ?', [userid]);
        print("addid確認：$addid");

        //addidをもとにname
        for (Map<String, dynamic?> ADD in addid) {
          ADD.forEach((key, value) async {
            for (int x = 0; x < ADD.length; x++) {
              final addId2 = await db.rawQuery('SELECT hiragana,kanji,eigo,otherName FROM k_add where addid = ?', [value]);
              debugPrint('addId2の内容：$addId2');
              for (Map<String, dynamic?> value2 in addId2) {
                value2.forEach((key, value) {
                  addNameValue.add(value as String);
                  debugPrint('addNameValueの内容：$addNameValue');

                  select.addAll(addNameValue);
                  print("リストの追加成分結合した結果：$select");
                });
              }
            }
          });
        }
      }else{
        select = await AllObligationData().getValueCheck();
        select.addAll(await AllRecommendationData().getValueCheck2());
        select.addAll(await AllAnotherData().getValueCheck3());

        print("Foodselect呼び出す");
        List<String> foodSelect = await Foodselect();
        select.addAll(foodSelect);
        print("呼出し後のセレクト：$select");
      }
    }else{
      print("美容が選択されたよ");
      List<String> beautyNameValue = [];

      print("これからユーザ検証");
      if((DBuser.userId.contains(userid))){
        print("ユーザ居た");


        //useridに紐づくbeautyidをセレクト
        final beautyid = await db.rawQuery('SELECT beautyid FROM list where userid2 = ?', [userid]);

        List<String> beautyIDValue = beautyid.map((e) => e['beautyid'].toString()).toList();

        //beautyidに紐づくbeautyname,kanji,eigo,otherNameをセレクト
        for (String id in beautyIDValue) {
          final beautyname = await db.rawQuery('SELECT beautyname,kanji,eigo,otherName FROM beauty where beautyid = ?', [id]);
          beautyNameValue.addAll(beautyname.map((e) => e['beautyname'].toString()));
        }

        select.addAll(beautyNameValue);
        print("選択された美容成分を追加した結果：$select");

      }else{
        select.addAll(await AllAnotherData().getValueCheck3());

        print("選択された美容成分を追加した結果：$select");
      }
    }

    //文字認識結果格納変数
    List<String> resultvalues = await Api.instance.getContentList();

    print("verificationのresultvalues：$resultvalues");
    print("verificationのselect：$select");

    List<String> result = [];

    select = select.where((element) => element.isNotEmpty).toList();
    print("空箱排除後のセレクト：$select");
    select = select.toSet().toList();
    print("重複排除後のセレクト：$select");

    for(String str in select){
      for(String s in resultvalues) {
        if (s.contains(str)) {
          if(!result.contains(str)){
            result.add(str);
            debugPrint("追加2：　$str");
          }
          break;
        }
      }
    }if(result.isEmpty){
      result.add("No");
      return result;
    }else{
      print("これからチェックボックスに表示されている文字を抽出するよ：$result");

      List<String> selectVal = [];

      //追加成分
      for (int i = 0; i < result.length; i++) {
        //Foodだったら
        if(Home_Page.flagCategory == 'food'){
          final selHiraQuery = await db.rawQuery('''SELECT hiragana FROM k_add WHERE hiragana = ? OR kanji = ? OR eigo = ? OR otherName = ?''', [result[i], result[i], result[i], result[i]]);
          for (Map<String, dynamic> row in selHiraQuery) {
            if (!selectVal.contains(row['hiragana'].toString())) {
              selectVal.add(row['hiragana'].toString());
            }
          }
          final foodName = result[i];
          final foodQuery = await db.rawQuery('SELECT foodid FROM food WHERE foodname = ?', [foodName]);

          //表示義務推奨
          for (Map<String, dynamic> row in foodQuery) {
            final foodId = row['foodid'].toString();
            final selId = foodId.substring(0, 2); // 左側二文字を抽出

            Map<String, String> id = {};
            id.addAll(AllObligationData.Gimu);
            id.addAll(AllRecommendationData.Sui);
            final targetId = id.keys.firstWhere((key) => id[key] == foodName, orElse: () => '');

            if (targetId.contains(selId)) { // targetId に selId が含まれているか確認
              resultVal.add(foodName);
            }
            print("現状のresultfood$resultVal");
          }
        //Beautyだったら
        }else{
          final selQuery = await db.rawQuery('''SELECT beautyname FROM beauty WHERE beautyname = ? OR kanji = ? OR eigo = ? OR otherName = ?''', [result[i], result[i], result[i], result[i]]);
          for (Map<String, dynamic> row in selQuery) {
            if (!selectVal.contains(row['beautyname'].toString())) {
              selectVal.add(row['beautyname'].toString());
            }
          }
        }
      }

      resultVal.addAll(selectVal);
      resultVal = resultVal.toSet().toList();

      print("これをかえすよ$resultVal");
      return resultVal;
    }
  }

  List<String> getResultfood(){
    return resultVal;
  }

  //ユーザ選択された時
  void selectName(String UserName) async{
    print("selectNameにきた");
    DBlist dbList = DBlist();
    userid = await dbList.selectUserId(UserName);
    debugPrint("取得対象のユーザは$useridです");
  }

  //データ取得部分
  Future <List<String>> Foodselect()async {
    Database db = await DBProvider.instance.database;
    List<Map<String, dynamic>> gimu = [];
    List<Map<String, dynamic>> g = [];
    List<String> All = [];
    List<String> hira = [];

    if (select.isNotEmpty) {
      print("if文に入った");
      Map<String, String> obligationMappings = {
        //表示義務
        'えび': 'GA%',
        'くるみ': 'GB%',
        'かに': 'GC%',
        '小麦': 'GD%',
        'そば': 'GE%',
        '卵': 'GF%',
        '乳': 'GG%',
        '落花生': 'GH%',
        //ここから表示推奨
        'あわび': 'SB%',
        'いか': 'SC%',
        'オレンジ': 'SF%',
        'いくら': 'SD%',
        'ごま': 'SI%',
        'さけ': 'SJ%',
        'さば': 'SK%',
        '大豆': 'SL%',
        '鶏肉': 'SM%',
        'バナナ': 'NB%',
        '豚肉': 'SO%',
        'まつたけ': 'SP%',
        'もも': 'SQ%',
        'やまいも': 'SR%',
        'りんご': 'SS%',
        'ゼラチン': 'ST%',
        'アーモンド': 'SA%',
        'カシューナッツ': 'SE%',
        'キウイフルーツ': 'SG%',
      };

      //追加成分
      if (AllAnotherData.valueCheck3.isNotEmpty) {
        List<Map<String, dynamic>> hiragana = await db.rawQuery('SELECT hiragana FROM k_add WHERE categoryid = ?', ['TS']);
        debugPrint('ひらがなだけ取得：$hiragana');
        for (Map<String, dynamic?> data in hiragana) {
          data.forEach((key, value) {
            if (value != "" && value != null) {
              hira.add(value as String);
            }
          });
        }
        debugPrint("ひらがなだけ取ってきた$hira");

        for (int x = 0; x <
            AllAnotherData.boolList3.length; x++) { //可変長の文だけ回ります
          //ひらがなと一致した他データを取ってくる
          if (select.contains(hira[x])) { //もしひらがなリストにselectがふくまれていたら
            //ひらがなが一致する他データをとってくる
            gimu = await db.rawQuery('SELECT kanji,eigo,otherName FROM k_add WHERE categoryid = ? AND hiragana = ?', ['TS', hira[x]]);
          }

          debugPrint('追加成分の漢字と英語をその他を空白込みで取得：$gimu');

          for (Map<String, dynamic?> data in gimu) {
            data.forEach((key, value) {
              if (value != "" && value != null) {
                All.add(value as String);
              }
            });
          }
        }
      }

      for (var value in select) {
        if (obligationMappings.containsKey(value)) {
          gimu = await db.rawQuery('SELECT foodname FROM food WHERE foodid LIKE ?', [obligationMappings[value]]);
          g.addAll(gimu);
        }
      }
    }
    print("これからわけます：$g");
    for (Map<String, dynamic> data in g) {
      data.forEach((key, value) {
        All.add(value as String);
      });
    }

    debugPrint('名前だけをとってきました：$All');
    return All;
  }
}