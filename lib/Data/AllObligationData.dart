import 'package:flutter/material.dart';
import '../DB/Food.dart';
import '../DB/List.dart';

class AllObligationData{

  static List<bool> boolList = List.filled(8, false);
  static List<String> valueList = ["えび","かに","くるみ","小麦","そば","卵","乳","落花生",];
  static List<String> valueCheck = [];  //trueの名前

  //みちるちゃんの
  static Map<String, String> Gimu = {"GA1":"えび", "GC1":"かに", "GB1":"くるみ", "GD2":"小麦", "GE1":"そば", "GF2":"卵", "GG1":"乳", "GH2":"落花生",};
  static List<String> CheckValue = []; // チェックされた食品名を格納
  static List<String> foodid = [];    // foodidをリストに格納

  //追加
  String getValueString(){
    debugPrint(valueList.length.toString());
    return valueList.toString();
  }

  List<String> getValue(){
    return valueList;
  }

  List<bool> getBool(){
    return boolList;
  }



  void setObligationBool(List<bool> box){
    boolList.clear();
    boolList.addAll(box);
  }

  void HanteiObligation(){
    valueCheck.clear();
    for(int x = 0;x < boolList.length; x++){
      if(boolList[x] == true){
        valueCheck.add(valueList[x]);
      }
    }
    debugPrint(valueCheck.toString());
  }

  List<String> getValueCheck(){
    debugPrint("valueCheckのなかみ$valueCheck");
    return valueCheck;
  }

  void setValueCheck(List<String> dbValue){
    debugPrint("setvalueCheckのなかみ$dbValue");
    valueCheck =  dbValue;
  }

  void valueCheckClear(){
    valueCheck.clear();
  }

  void AllResetObligation(){
    boolList = List.filled(8, false);
    valueCheck = [];
  }

  void valueChangeBool1(){
    int count = 0;
    for(String value in DBfood.Gimulist){
      debugPrint('valueChangeBool1とおった$valueList');
      while(true){
        if(valueList[count] == value){
          boolList[count] = true;
          count++;
          break;
        }else{
          boolList[count] = false;
        }
        count++;
      }
    }
  }

  DBfood dbFood = DBfood();//DBクラスのインスタンス生成
  DBlist dbList = DBlist();//DBクラスのインスタンス生成

  //追加した処理12/21
  //みちるちゃんの
  void insertHanteiObligation(String username) async {
    debugPrint('insertHanteiObligationに来ました');
    CheckValue.clear();//foodidのクリア
    foodid.clear();//追加した処理12/21
    debugPrint('valueCheckを使用します：$valueCheck');
    for (int x = 0; x < valueCheck.length; x++) {
      Gimu.forEach((key, value) { //foodidのみを出力
        if (value == valueCheck[x]) { //もしGimuリストのfoodNameとCheckValueのfoodNameが一致したら
          foodid.add(key as String); // foodidリストにGimuリストのfoodidを格納
        }
      });
    }
    debugPrint('最終的なfoodidの内容:$foodid');
    final int userid = await dbList.selectUserId(username);// ユーザーIDを非同期で取得
    debugPrint('useridの内容:$userid');
    for (int x = 0; x < foodid.length; x++) {
      await dbFood.insertfood(userid, foodid[x]);// ここでDBにuseridとCheckKeyを渡す（insert）
      debugPrint('foodidの内容だよ:$foodid');
    }
    debugPrint(CheckValue.toString());
  }
}