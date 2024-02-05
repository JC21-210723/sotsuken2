import 'package:flutter/material.dart';

import '../DB/Add.dart';

import '../main.dart';
import '../ui/AddAnotherIngredient.dart';
import '../ui/ImageLoaderSelect.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../Data/AllAnotherData.dart';
import '../component/AppbarComp.dart';

class StateAnother_ingredient extends StatefulWidget{
  final String PageFlag;
  int PageCount = 0;
  StateAnother_ingredient({super.key, required this.PageFlag,required this.PageCount});

  @override
  State<StateAnother_ingredient> createState(){
    return Another_ingredient();
  }
}

class Another_ingredient extends State<StateAnother_ingredient>{
  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
  AllAnotherData aad = AllAnotherData();
  DBadd dbAdd = DBadd();//DBクラスのインスタンス生成

  int forMethod(List<String> list){
    int forCount;
    if(list.length % 2 == 1){
      forCount = list.length+1;
    }else{
      forCount = list.length;
    }
    return forCount;
  }

  int allCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[Colors.white,Color(0xFF90D4FA)],
        )
      ),
      child:Scaffold(
        backgroundColor: Colors.transparent,
          appBar:AppbarComp(),
          body: Center(
              child:SingleChildScrollView(
                  child:Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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

                              child:RichText(
                                text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text:'その他の登録した成分',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color:Colors.indigo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(DBadd.AddList.isEmpty)...[
                              Container(
                                margin: const EdgeInsets.all(30),
                                child:const FittedBox(
                                  child:Text('何も登録されていません',style: TextStyle(fontSize: 25),),
                                ),
                              ),
                            ]else...[
                              if(DBadd.shortAddList.isNotEmpty)...[
                                for(int n = 0 ; n < forMethod(DBadd.shortAddList); n = n+2)...[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for(int nn = 0 ; nn < 2  ; nn++)...[
                                          if(nn == 0)...[
                                            Container(
                                              height: 53,
                                              width:140,
                                              margin: const EdgeInsets.fromLTRB(0, 3, 7, 3),
                                              child:ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:  aad.getBool3()[n+nn] ? Colors.lightBlueAccent : Colors.white,
                                                  foregroundColor: aad.getBool3()[n+nn] ? Colors.white : Colors.black,
                                                  shape:const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft:Radius.circular(50),
                                                        topLeft:Radius.circular(50),
                                                        topRight: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                      )
                                                  ),
                                                ),
                                                onPressed: (){
                                                  setState(() {
                                                    aad.getBool3()[n+nn] = !aad.getBool3()[n+nn];
                                                  });

                                                },
                                                child: Text(DBadd.shortAddList[n+nn],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                              ),
                                              //↑今テストで作ってる
                                            ),

                                          ]else...[

                                            if(DBadd.shortAddList.length % 2 == 1 && DBadd.shortAddList.length == n+1)...[
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(7, 3, 0, 3),
                                                width:140,
                                              ),
                                            ]else...[
                                              Container(
                                                height: 53,
                                                width:140,
                                                margin: const EdgeInsets.fromLTRB(7, 3, 0, 3),
                                                child:ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:  aad.getBool3()[n+nn] ? Colors.lightBlueAccent : Colors.white,
                                                    foregroundColor: aad.getBool3()[n+nn] ? Colors.white : Colors.black,
                                                    shape:const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft:Radius.circular(50),
                                                          topLeft:Radius.circular(50),
                                                          topRight: Radius.circular(10),
                                                          bottomRight: Radius.circular(10),
                                                        )
                                                    ),
                                                  ),
                                                  onPressed: (){
                                                    setState(() {
                                                      aad.getBool3()[n+nn] = !aad.getBool3()[n+nn];
                                                    });

                                                  },
                                                  child: Text(DBadd.shortAddList[n+nn],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                                ),
                                                //↑今テストで作ってる
                                              ),

                                            ]

                                          ]
                                        ],
                                      ]
                                  )

                                ],
                              ],
                              if(DBadd.shortAddList.isNotEmpty)...[
                                for(int n = 0 ; n < DBadd.longAddList.length; n++)...[
                                  Container(
                                    height: 53,
                                    width:300,
                                    margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  aad.getBool3()[DBadd.shortAddList.length+n] ? Colors.lightBlueAccent : Colors.white,
                                        foregroundColor: aad.getBool3()[DBadd.shortAddList.length+n] ? Colors.white : Colors.black,
                                        shape:const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:Radius.circular(50),
                                              topLeft:Radius.circular(50),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )
                                        ),
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          aad.getBool3()[DBadd.shortAddList.length+n] = !aad.getBool3()[DBadd.shortAddList.length+n];
                                        });

                                      },
                                      child: Text(DBadd.longAddList[n],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                    ),
                                  ),

                                ],


                              ]
                            ],
                          ],
                        )
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          width: 320,
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
                        child:Column(
                          children: [
                            Container(
                              width: 290,
                              height: 90,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding:const EdgeInsets.fromLTRB(0, 7, 0, 7),
                              child:  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 7
                                ),
                                onPressed:(){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context){
                                        return StateAddAnotherIngredient(widget.PageFlag,widget.PageCount);
                                      })
                                  ).then((value){
                                    setState(() {});
                                  });
                                },
                                child: const Text('その他の追加成分を\n新規登録',style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            if(widget.PageFlag != 'Manual')...[
                              Container(
                                width: 290,
                                height: 70,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                padding:const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                child:  ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange[700],
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 7
                                  ),
                                  onPressed:(){
                                    if(widget.PageFlag == 'ChooseUser'){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return const StateImageLoderSelect();
                                          })
                                      );

                                    }else if(widget.PageFlag == 'CreateUser'){
                                      Navigator.of(context).pop();
                                    }else if(widget.PageFlag == 'SettingUser'){
                                      debugPrint(widget.PageCount.toString());
                                      for(int n = 0 ; n <= widget.PageCount; n++){
                                        Navigator.of(context).pop();
                                      }
                                    }
                                    if(Home_Page.flagCategory == 'food'){
                                      aod.HanteiObligation();
                                      ard.HanteiRecommendation();
                                      aad.HanteiAnother();
                                    }else{
                                      aad.HanteiAnother();
                                    }
                                  },
                                  child: const Text('決定',style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                            if(widget.PageFlag == 'Manual')...[
                              Container(
                                width: 290,
                                height: 70,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                padding:const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                child:  ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[400],
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 7
                                  ),
                                  onPressed:(){
                                    _deleteAdd();
                                    _selectAdd();
                                    Future.delayed(Duration(seconds: 1)).then((_){
                                      aad.AllResetAnother();
                                      setState(() {});
                                    });
                                  },
                                  child: const Text('選択した項目を削除',style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                      textAlign: TextAlign.center),
                                ),
                              )
                            ],
                          ],
                        )
                      ),
                    ]
                  )
              )
          )
      ),
    );
  }

  void _selectAdd() async {
    debugPrint('_selectAddにきました');
    final List<String> hiragana = await dbAdd.selectAdd();//ひらがなslectメソッド結果
    final List<String> import = DBadd.AddList;//import結果
    debugPrint('追加成分の内容:$hiragana');
    debugPrint('Addlistをimportした結果：$import');
    debugPrint(DBadd.AddList.toString());
  }

//追加成分の削除
  void _deleteAdd() async {
    debugPrint('_deleteAddにきました');
    aad.HanteiAnother();
    final deleteData = AllAnotherData.valueCheck3;
    debugPrint('削除対象でーたは$deleteDataです');
    //リスト表から削除される項目を登録しているaddidを特定
    for(int x = 0; x < AllAnotherData.valueCheck3.length; x++) {
      final int addid = await dbAdd.selectAddId(AllAnotherData.valueCheck3[x]);//checkaddに格納されている追加名を1つずつ引数で渡す
      debugPrint('削除したいaddidは:$addid');

      debugPrint('リスト表に登録されている削除項目を削除します');
      final deleteAddlist = await dbAdd.deletelistAdd(addid);
      debugPrint('$deleteAddlistを削除しました');

      //チェックがついたひらがなを条件にk_add表から削除する
      final deleteAdd = await dbAdd.deleteAdd(AllAnotherData.valueCheck3[x]);
      debugPrint('個人追加表から削除した内容:$deleteAdd');

      debugPrint('AddListを再更新します');
      final List<String> hiragana = await dbAdd.selectAdd();//ひらがなselectメソッド結果
      debugPrint('AddListの中身は$hiraganaです');
    }
  }
}