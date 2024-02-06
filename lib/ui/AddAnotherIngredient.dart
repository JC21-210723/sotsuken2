import 'package:flutter/material.dart';
import 'dart:async';

import '../DB/Add.dart';

import '../Data/AllAnotherData.dart';
import '../component/AppbarComp.dart';
import '../component/LoadingIndicator.dart';



class StateAddAnotherIngredient extends StatefulWidget{
  final String PageFlag;
   int pagecount = 0;
  StateAddAnotherIngredient(this.PageFlag,this.pagecount);


  @override
  State<StateAddAnotherIngredient> createState(){
    return AddAnotherIngredient();
  }
}

class AddAnotherIngredient extends State<StateAddAnotherIngredient>{
  String ingredientName = "";
  String kanji = "";
  String english = "";
  String otherName = "";

  String ErrorMessage = "";
  AllAnotherData aad = AllAnotherData();

  double _value = 0.0;
  bool isLoading = false;

  void StartTimer(){
    isLoading = true;
    _value = 0;
    int counter = 0;
    Timer.periodic(Duration(milliseconds: 25), (Timer timer) {
      setState(() {
        ++counter;
        if(counter < 12){
          _value += (0.005 * counter/2);
        }else if(counter > 20){
          _value += 0.005 * (28-counter);
        }else{
          _value += 0.087;
        }
        if(counter == 28){
          counter = 0;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[Colors.white,Color(0xFF90D4FA)],
        )
      ),
      child:Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar:AppbarComp(),
            body: Center(
                child:SingleChildScrollView(
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                          width: 300,
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color:Colors.black12,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: Offset(4,4)
                              )
                            ],
                          ),
                          child:Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child:  Container(
                              alignment: Alignment.center,
                              width: 250,
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 7),
                              decoration: const BoxDecoration(
                                border:Border(
                                    bottom: BorderSide(
                                        color: Colors.indigo
                                    )
                                ),
                              ),

                              child: const Text(
                                'その他の成分を\n新規追加',
                                style: TextStyle(
                                  fontSize: 25,
                                  color:Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            width: 322,
                            decoration: BoxDecoration(
                              border: Border.all(color:Colors.white30),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          child:Column(
                            children: [



                              Container(
                                margin:const EdgeInsets.fromLTRB(10, 5, 10, 3),
                                child:const FittedBox(
                                  child: Text('下記情報を入力してください。',
                                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                margin:const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child:const FittedBox(
                                  child:Text('※成分名はひらがな または カタカナ',
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding:EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:Colors.white,
                                        border: Border.all(
                                          color: Colors.indigo,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: const Text('成分名\n(必須)',
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                        color:Colors.white,
                                        border: Border.all(
                                          color: Colors.indigo,
                                          width: 1.5,
                                        ),
                                      ),
                                      margin: EdgeInsets.all(10),
                                      width: 190,
                                      child: TextField(
                                        style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                        onChanged: (value){
                                          ingredientName = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin:const EdgeInsets.fromLTRB(10, 15, 10, 3),
                                child:const FittedBox(
                                  child:Text('成分名の漢字、英語、別名を\n入力してください。(任意)',
                                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:90,
                                    padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text('漢字\n(任意)',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    width: 190,
                                    child: TextField(
                                      style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                      onChanged: (value){
                                        kanji = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:90,
                                    padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text('英語\n(任意)',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    width: 190,
                                    child: TextField(
                                      style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                      onChanged: (value){
                                        english = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:90,
                                    padding:EdgeInsets.fromLTRB(7, 3, 7, 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text('別名\n(任意)',
                                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    padding:EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(
                                      color:Colors.white,
                                      border: Border.all(
                                        color: Colors.indigo,
                                        width: 1,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    width: 190,
                                    child: TextField(
                                      style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                      onChanged: (value){
                                        otherName = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(ErrorMessage,style:const TextStyle(fontSize: 18,color:Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Container(
                            width: 200,
                            height:60,
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                            child:ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 7
                              ),
                              child:const Text('登録',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              onPressed: (){
                                if(ingredientName == "") {
                                  setState(() {
                                    ErrorMessage = "名前が入力されていません";
                                  });
                                }else if(DBadd.AddList.contains(ingredientName)){
                                  setState((){
                                    ErrorMessage = 'この名前は使われています';
                                  });
                                }else if(ingredientName.contains(' ')){
                                  setState((){
                                    ErrorMessage = '空白「 」は\nご利用いただけません';
                                  });
                                }else if(ingredientName.contains('　')){
                                  setState((){
                                    ErrorMessage = '空白「 」は\nご利用いただけません';
                                  });
                                }else {
                                  StartTimer();
                                  _insertAdd();//追加した処理12/21
                                  aad.addMethod3(ingredientName);
                                  Future.delayed(const Duration(seconds: 1)).then((_) {
                                    Navigator.pop(context);
                                    isLoading = false;
                                    setState(() {});
                                  });
                                }
                              },
                            )
                        ),
                      ]
                  ),
                )

            ),
          ),
          if (isLoading)...[
            StateLoadingIndicator(value: _value,)
          ],
        ],
      ),
    );
  }



  DBadd dbAdd = DBadd();//DBクラスのインスタンス生成
  //個人追加表へ追加処理
  void _insertAdd() async {
    debugPrint('_insertAddにきました');
    final AddList = await dbAdd.insertAdd(ingredientName ,kanji ,english,otherName);
    print('個人追加表にinsertしました: $AddList');
    _selectAdd();//テスト用で追加した処理12/24 登録ボタンでselect使用とすると処理が早すぎて、ワンテンポ表示が遅れたので、insert処理後にselect処理実行されるように調整
  }

  //追加した処理12/24
  //追加成分表示テストメソッド
  void _selectAdd() async {
    debugPrint('_selectAddにきました');
    final List<String> hiragana = await dbAdd.selectAdd();//ひらがなselectメソッド結果
    final List<String> import = DBadd.AddList;//import結果
    final addlength = DBadd.AddList[0];
    final addlength1 = DBadd.AddList.length;
    debugPrint('addlength[0]:$addlength');
    debugPrint('addlength1[1]:$addlength1');
    debugPrint('追加成分の内容:$hiragana');
    debugPrint('Addlistをimportした結果：$import');
  }


}