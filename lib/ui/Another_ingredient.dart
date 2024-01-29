import 'package:flutter/material.dart';

import '../DB/Add.dart';

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
  //test
  bool sushi = false;

  int forMethod(){
    int forCount;
    if(DBadd.AddList.length % 2 == 1){
      forCount = DBadd.AddList.length+1;
    }else{
      forCount = DBadd.AddList.length;
    }
    return forCount;
  }

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
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:Colors.indigo,
                              width: 1,
                            ),
                          ),
                          child: const Text('その他の登録した成分',
                              style: TextStyle(
                                  fontSize: 24,
                                  color:Colors.indigo,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),

                        if(DBadd.AddList.isEmpty)...[
                          Container(
                            margin: const EdgeInsets.all(30),
                            child:const FittedBox(
                              child:Text('何も登録されていません',style: TextStyle(fontSize: 25),),
                            ),
                          ),
                        ]else...[
                          for(int n = 0 ; n < forMethod(); n = n+2)...[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for(int nn = 0 ; nn < 2  ; nn++)...[
                                    if(nn == 0)...[

                                      Container(
                                        width: 167,
                                        child:Transform.scale(
                                          scale:1.1,
                                          child: CheckboxListTile(
                                              controlAffinity: ListTileControlAffinity.leading,
                                              title: Transform.translate(
                                                offset: const Offset(-15,0),
                                                child:Text(DBadd.AddList[n+nn],style: TextStyle(fontSize: 17)),
                                              ),
                                              value: aad.getBool3()[n+nn],
                                              onChanged: (value) {
                                                setState(() {
                                                  aad.getBool3()[n+nn] = value!;
                                                });
                                              }
                                          ),
                                        ),
                                      ),

                                    ]else...[

                                      if(DBadd.AddList.length % 2 == 1 && DBadd.AddList.length == n+1)...[
                                        Container(
                                          width: 167,
                                        ),
                                      ]else...[
                                        Container(
                                          width: 167,
                                          child:Transform.scale(
                                            scale:1.1,
                                            child: CheckboxListTile(
                                                controlAffinity: ListTileControlAffinity.leading,
                                                title: Transform.translate(
                                                  offset: const Offset(-15,0),
                                                  child:Text(DBadd.AddList[n+nn],style: TextStyle(fontSize: 18)),
                                                ),
                                                value: aad.getBool3()[n+nn],
                                                onChanged: (value) {
                                                  setState(() {
                                                    aad.getBool3()[n+nn] = value!;
                                                  });
                                                }
                                            ),
                                          ),
                                        ),
                                      ]

                                    ]
                                  ],
                                ]
                            )

                          ],
                        ],

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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                                }else if(widget.PageFlag == 'ChooseUser' || widget.PageFlag == 'SettingUser'){
                                  debugPrint(widget.PageCount.toString());
                                  for(int n = 0 ; n <= widget.PageCount; n++){
                                    Navigator.of(context).pop();
                                  }
                                }
                                aod.HanteiObligation();
                                ard.HanteiRecommendation();
                                aad.HanteiAnother();
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
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
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