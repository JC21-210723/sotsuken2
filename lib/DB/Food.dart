
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import 'Database.dart';

class DBfood{

  //表示義務の追加処理
  Future<int> insertfood(int userid ,String checkKey) async {
    debugPrint("insertfoodにきました");
    Database db = await DBProvider.instance.database;
    return await db.insert('list', {'userid': userid, 'userid2': '--', 'foodid': checkKey,'beautyid': '--', 'addid': 0});
  }

  //表示推奨の追加処理
  Future<int> insertfood2(int userid ,String checkKey) async {
    debugPrint("insertfood2にきました");
    Database db = await DBProvider.instance.database;
    return await db.insert('list', {'userid': userid, 'userid2': '--', 'foodid': checkKey,'beautyid': '--', 'addid': 0});
  }


  //-アレルゲン変更処理表示用-
  //あるユーザの表示義務登録情報を参照し、GimuListに格納する処理
  static List<String> Gimuvalue = [];//とあるユーザが登録したfoodidのリスト
  static List<String> Gimulist = [];//とあるユーザが登録したfoodNameのリスト

  //表示義務
  Future<List<String>> selectGimu(int userid) async {
    debugPrint("selectGimuにきました");
    Database db = await DBProvider.instance.database;

    Gimuvalue.clear();
    Gimulist.clear();

    //すべてのfoodid
    final foodidlist = await db.rawQuery('select foodid from list where userid = ?', [userid]);
    debugPrint('foodidlistの内容：$foodidlist');

    final gim = AllObligationData.Gimu;
    debugPrint('表示義務の内容：$gim');

    for (Map<String, dynamic?> gimu in foodidlist) {
      gimu.forEach((key, value) {
        Gimuvalue.add(value as String); // foodidを1件ずつ格納
        debugPrint('Gimuvalueの内容：$Gimuvalue');
      });
    }

    debugPrint('最終的にGimuvalueに入れた内容：$Gimuvalue');

    for (int x = 0; x < Gimuvalue.length; x++) {
      gim.forEach((key, value) {
        if (Gimuvalue[x] == key) {
          Gimulist.add(value as String);
          debugPrint('Gimulistの内容：$Gimulist');
        }
      });
    }
    debugPrint('最終的にGimulistに入れた内容：$Gimulist');
    return Gimulist;
  }


  //表示推奨
  //あるユーザの表示推奨登録情報を参照し、SuiListに格納する処理
  static List<String> Suivalue = [];//とあるユーザが登録したfoodidのリスト
  static List<String> Suilist = [];//とあるユーザが登録したfoodNameのリスト

  //表示推奨
  Future<List<String>> selectSui(int userid) async {
    debugPrint("selectSuiにきました");
    Database db = await DBProvider.instance.database;

    Suivalue.clear();
    Suilist.clear();

    //すべてのfoodid
    final foodidlist = await db.rawQuery('select foodid from list where userid = ?', [userid]);
    debugPrint('foodidlistの内容：$foodidlist');

    final sui = AllRecommendationData.Sui;
    debugPrint('表示推奨の内容：$sui');

    for (Map<String, dynamic?> sui in foodidlist) { //foodidはある
      sui.forEach((key, value) {
        Suivalue.add(value as String); // foodidを1件ずつ格納
        debugPrint('Suivalueの内容：$Suivalue');
      });
    }

    debugPrint('最終的にSuivalueに入れた内容：$Suivalue');

    for (int x = 0; x < Suivalue.length; x++) {
      sui.forEach((key, value) {
        if (Suivalue[x] == key) {
          Suilist.add(value as String);
          debugPrint('Suilistの内容：$Suilist');
        }
      });
    }
    debugPrint('最終的にSuilistに入れた内容：$Suilist');
    return Suilist;
  }
}