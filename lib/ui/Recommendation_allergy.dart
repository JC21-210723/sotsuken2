import 'package:flutter/material.dart';

import '../DB/Add.dart';

import '../ui/Another_ingredient.dart';
import '../ui/ImageLoaderSelect.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllAnotherData.dart';
import '../Data/AllRecommendationData.dart';
import '../component/AppbarComp.dart';

class StateRecommendation_allergy extends StatefulWidget{
  final String PageFlag;
  int PageCount = 0;
  StateRecommendation_allergy({Key?key, required this.PageFlag,required this.PageCount});

  @override
  State<StateRecommendation_allergy> createState(){
    return Recommendation_allergy();
  }
}

class Recommendation_allergy extends State<StateRecommendation_allergy> {
//チェックボックスの数だけいる(20)
  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
  AllAnotherData aad = AllAnotherData();

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
        appBar: AppbarComp(),
        body: Center(
          child:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Column(
              children: [
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

                      child:RichText(
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                text:'表示推奨アレルギー',
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
                for(int n = 0 ; n < 18; n = n+2)...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int nn = 0 ; nn < 2  ; nn++)...[
                        if(nn == 0)...[
                          Container(
                              width:176,
                              margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:  BorderRadius.only(
                                    bottomLeft:Radius.circular(50),
                                    topLeft:Radius.circular(50),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                              ),
                              child:Transform.scale(
                                  scale:1.1,
                                  child:CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Transform.translate(
                                        offset: const Offset(-15,0),
                                        child:Text(ard.getValue()[n+nn],style: const TextStyle(fontSize: 19)),
                                      ),
                                      value: ard.getBool()[n+nn],
                                      onChanged: (value) {
                                        setState(() {
                                          ard.getBool()[n+nn] = value!;
                                        });
                                      }
                                  )
                              )
                          ),
                        ]else...[
                          if(n+1 == 17)...[
                            Container(
                              width: 157,
                            ),
                          ]else...[
                            Container(
                              width: 157,
                              margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:  BorderRadius.only(
                                    bottomLeft:Radius.circular(50),
                                    topLeft:Radius.circular(50),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )
                              ),
                              child:Transform.scale(
                                scale:1.1,
                                child: CheckboxListTile(
                                    controlAffinity: ListTileControlAffinity.leading,
                                    title: Transform.translate(
                                      offset: const Offset(-15,0),
                                      child:Text(ard.getValue()[n+nn],style: const TextStyle(fontSize: 20)),
                                    ),
                                    value: ard.getBool()[n+nn],
                                    onChanged: (value) {
                                      setState(() {
                                        ard.getBool()[n+nn] = value!;
                                      });
                                    }
                                ),
                              ),
                            ),
                          ],
                        ],
                      ],
                    ],
                  ),
                ],
                for(int n = 17 ; n < 20 ; n++ )...[
                  Container(
                    width: 320,
                    margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                          bottomLeft:Radius.circular(50),
                          topLeft:Radius.circular(50),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                    ),
                    child:Transform.scale(
                      scale:1.1,
                      child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Transform.translate(
                            offset: const Offset(-15,0),
                            child:Text(ard.getValue()[n],style: const TextStyle(fontSize: 20)),
                          ),
                          value: ard.getBool()[n],
                          onChanged: (value) {
                            setState(() {
                              ard.getBool()[n] = value!;
                            });
                          }
                      ),
                    ),
                  ),
                ],
                if(widget.PageFlag == 'ChooseUser' || widget.PageFlag =='SettingUser')...[
                  Container(
                    width: 290,
                    height: 70,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding:const EdgeInsets.fromLTRB(0, 7, 0, 7),
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 7
                      ),
                      onPressed:(){
                        _selectAdd();
                        Future.delayed(const Duration(seconds: 1)).then((_) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return StateAnother_ingredient(
                                    PageFlag: widget.PageFlag,PageCount: widget.PageCount+1);
                              })
                          );
                        });
                      },
                      child: const Text('登録済み成分を選択',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
                Container(
                  width: 290,
                  height: 70,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
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
                      }else if(widget.PageFlag == 'CreateUser' || widget.PageFlag =='SettingUser'){
                        //なおしたいNamdpush
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                      debugPrint(widget.PageFlag.toString());
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
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
  //追加した処理12/21
  DBadd dbAdd = DBadd();//DBクラスのインスタンス生成

//追加した処理12/24
//追加成分表示テストメソッド
  void _selectAdd() async {
    debugPrint('_selectAddにきました');
    final List<String> hiragana = await dbAdd.selectAdd();//ひらがなslectメソッド結果
    final List<String> import = DBadd.AddList;//import結果
    debugPrint('追加成分の内容:$hiragana');
    debugPrint('Addlistをimportした結果：$import');
    debugPrint(DBadd.AddList.toString());
  }
}
