import 'package:flutter/material.dart';

import '../DB/Food.dart';
import '../DB/List.dart';

class AllRecommendationData{

  static List<bool> boolList2 = List.filled(20, false);
  static List<String> valueList2 = ["あわび","いか","オレンジ","いくら","牛肉","ごま","さけ", "さば","大豆","鶏肉",
    "バナナ","豚肉","まつたけ","もも","やまいも","りんご","ゼラチン","アーモンド","カシューナッツ","キウイフルーツ"];
  static List<String> valueCheck2 = [];

  //みちるちゃんの
  static Map<String, String> Sui = {"SA1":"アーモンド", "SB1":"あわび", "SC1":"いか", "SD1":"いくら", "SE1":"カシューナッツ", "SF1":"オレンジ", "SG2":"キウイフルーツ", "SH2":"牛肉","SI1":"ごま","SJ1":"さけ","SK1":"さば","SL2":"大豆","SM2":"鶏肉","SN1":"バナナ","SO2":"豚肉","SP1":"まつたけ","SQ1":"もも","SR1":"やまいも","SS1":"りんご","ST1":"ゼラチン",};
  static List<String> CheckValue2 = []; // チェックされた食品名を格納
  static List<String> foodid2 = [];    // foodidをリストに格納


  //追加
  String getValueString(){
    debugPrint(valueList2.length.toString());
    return valueList2.toString();
  }

  List<String> getValue(){
    return valueList2;
  }

  List<bool> getBool2(){
    return boolList2;
  }



  void setRecommendationBool(List<bool> box){
    boolList2.clear();
    boolList2.addAll(box);
  }

  void HanteiRecommendation(){
    valueCheck2.clear();
    for(int x = 0;x < boolList2.length; x++){
      if(boolList2[x] == true){
        valueCheck2.add(valueList2[x]);
      }
    }
    debugPrint(valueCheck2.toString());
  }

  List<String> getValueCheck2(){
    return valueCheck2;
  }

  void setValueCheck2(List<String> dbValue){
    valueCheck2 =  dbValue;
  }

  void valueCheckClear2(){
    valueCheck2.clear();
  }

  void AllResetRecommendation(){
    boolList2 =  List.filled(20, false);
    valueCheck2 = [];
  }

  void valueChangeBool2(){
    int count = 0;
    for(String value in DBfood.Suilist){
      while(true){
        if(valueList2[count] == value){
          boolList2[count] = true;
          count++;
          break;
        }else{
          boolList2[count] = false;
        }
        count++;
      }
    }
  }

  DBfood dbFood = DBfood();//DBクラスのインスタンス生成
  DBlist dbList = DBlist();//DBクラスのインスタンス生成
  //追加した処理12/21
  //みちるちゃんの
  void insertHanteiRecommendation(String username) async {
    debugPrint('insertHanteiObligationに来ました');
    CheckValue2.clear();//foodidのクリア
    foodid2.clear();//追加した処理12/21
    debugPrint('valueCheck2を使用します：$valueCheck2');
    for (int x = 0; x < valueCheck2.length; x++) {
      Sui.forEach((key, value) { //foodidのみを出力
        if (value == valueCheck2[x]) { //もしSuiリストのfoodNameとCheckValueのfoodNameが一致したら
          foodid2.add(key as String); // foodidリストにSuiリストのfoodidを格納
        }
      });
    }
    debugPrint('最終的なfoodid2の内容:$foodid2');
    final int userid = await dbList.selectUserId(username);// ユーザーIDを非同期で取得
    debugPrint('useridの内容:$userid');
    for (int x = 0; x < foodid2.length; x++) {
      final result2 = await dbFood.insertfood2(userid, foodid2[x]);// ここでDBにuseridとCheckKeyを渡す（insert）
      debugPrint('foodid2の内容だよ2:$foodid2');
    }
    debugPrint('最終的なfoodid2の内容だよ2:$foodid2');
    debugPrint(CheckValue2.toString());
  }
}