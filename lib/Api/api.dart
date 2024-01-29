import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sotsuken2/DB/Food.dart';
import 'package:sqflite/sqflite.dart';

import '../DB/Database.dart';

class Api{
  static List<String> contentList = [""];
  Api._();
  static final Api instance = Api._();

  Future<void> postData(XFile img) async {
    print("パス：" + img.path);
    File file = File(img.path);
    // 画像のバイナリデータを読み込みます.
    ByteData data = await file.readAsBytes().then((bytes) =>
        ByteData.sublistView(Uint8List.fromList(bytes)));
    List<int> imageBytes = data.buffer.asUint8List(); // 修正

    var response = await http
        .post(Uri.parse(
        'https://r05-jk3a15cognitive.cognitiveservices.azure.com/computervision/imageanalysis:analyze?language=ja&api-version=2023-02-01-preview&features=read'),
        headers: {
          'Ocp-Apim-Subscription-Key': '2a4e99f274a14a94a4b5f26077b97cf0',
          'Content-Type': 'application/octet-stream',
        },
        body: imageBytes
    );
    Map<String, dynamic> jsonDataMap = json.decode(response.body);
    // "content"フィールドの値を取得
    String content = jsonDataMap['readResult']['content'];

    //contentの値を1行にする
    String contentMoji = content.replaceAll('\n', '');

    print(contentMoji);

    String genStr = "";

    if (contentMoji.contains("原材料")) {
      //原材料後、内容量までを保持
      RegExp genNai = RegExp(r"原材料名(.*?)[內内]容量(.*)");
      RegExp gen = RegExp(r"原材料名(.*)");
      RegExpMatch? matchGenNai = genNai.firstMatch(contentMoji);
      RegExpMatch? matchGen = gen.firstMatch(contentMoji);

      debugPrint("マッチしたか1:$matchGenNai");
      debugPrint("マッチしたか2:$matchGen");

      if (matchGenNai != null) {
        genStr = matchGenNai.group(1)!.trim();
        debugPrint("原材料後1：$genStr");
      } else if (matchGen != null) {
        genStr = matchGen.group(1)!.trim();
        debugPrint("原材料後2：$genStr");
      }
    } else {
      print("else");
      genStr = contentMoji;
    }

    //、を見つけるまでを1要素として配列に格納する
    contentList = genStr.split('、');
    debugPrint("読み込んだ文字：$contentList");
  }
  List<String> getContentList(){
    return contentList;
  }

  DBfood dbFood = DBfood();//DBクラスのインスタンス生成

  Future<List<String>> result() async {
    print("resultきた");
    List<String> values = [];
    List<String> result = [];
    List<String> ocrResult = getContentList();

    Database db = await DBProvider.instance.database;

    //データ全部持ってくる
    List<Map<String, dynamic>> databaseContent = await db.rawQuery("SELECT foodname FROM food");
    //追加成分データ持ってくる
    List<Map<String, dynamic>> selectList = await db.rawQuery('SELECT hiragana,kanji,eigo,otherName FROM k_add where categoryid = ? ',['TS']);
    print("databaseContent：$databaseContent");
    print("selectList：$selectList");

    //Map→list変換
    List<String> foodNames = List<String>.from(databaseContent.map((map) => map['foodname']));
    List<dynamic> addFoodDynamic = selectList
        .map((map) => [map['hiragana'], map['kanji'], map['eigo']])
        .expand((element) => element)
        .where((element) => element != null)
        .toList();

    //List<dynamic>→List<String>変換
    List<String> addFood = addFoodDynamic.cast<String>();

    print("追加成分結合前:$foodNames");
    foodNames.addAll(addFood);
    //list型結合 nullでないとき
    print("追加成分結合後:$foodNames");


    for(String foods in foodNames){
      for(String s in ocrResult) {
        if (s.contains(foods)) {
          if(!values.contains(foods)){
            values.add(s);
            debugPrint("追加：　$s");
            break;
          }
        }
      }
    }
    if(values.isEmpty){
      values.add("No");
      return values;
    }
    else{
      result = values;
      print("表示：$result");
      return result;
    }
  }
}