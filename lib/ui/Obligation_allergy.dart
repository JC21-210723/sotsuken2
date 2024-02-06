import 'package:flutter/material.dart';
import 'dart:async';

import '../DB/Add.dart';

import '../ui/ImageLoaderSelect.dart';
import '../ui/Recommendation_allergy.dart';
import '../ui/Another_ingredient.dart';
import '../Data/AllAnotherData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../component/AppbarComp.dart';
import '../component/LoadingIndicator.dart';
import '../component/AlertDialogComp.dart';

class StateObligation_allergy extends StatefulWidget{
  final String PageFlag;
  const StateObligation_allergy({Key?key, required this.PageFlag}): super(key:key) ;

  @override
  State<StateObligation_allergy> createState(){
    return Obligation_allergy();
  }
}

class Obligation_allergy extends State<StateObligation_allergy>{
//チェックボックスの数だけいる(8)

  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
  AllAnotherData aad = AllAnotherData();
  final int pagecount = 1;

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
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
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
                                          color: Colors.orange
                                      )
                                  ),
                                ),

                                child:RichText(
                                  text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text:'表示義務アレルギー',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color:Colors.deepOrange,
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
                                for(int n = 0 ; n < 8; n = n+2)...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for(int nn = 0 ; nn < 2  ; nn++)...[
                                        if(nn == 0)...[
                                          //↓今テストで作ってる
                                          Container(
                                            height: 53,
                                            width:140,
                                            margin: const EdgeInsets.fromLTRB(0, 3, 7, 3),
                                            child:ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:  aod.getBool()[n+nn] ? Colors.lightBlueAccent : Colors.white,
                                                  foregroundColor: aod.getBool()[n+nn] ? Colors.white : Colors.black,
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
                                                  aod.getBool()[n+nn] = !aod.getBool()[n+nn];
                                                });

                                              },
                                              child: Text(aod.getValue()[n+nn],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                            ),
                                            //↑今テストで作ってる
                                          ),

                                        ]else...[
                                          Container(
                                            height: 53,
                                            width:140,
                                            margin: const EdgeInsets.fromLTRB(7, 3, 0, 3),
                                            child:ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:  aod.getBool()[n+nn] ? Colors.lightBlueAccent : Colors.white,
                                                foregroundColor: aod.getBool()[n+nn] ? Colors.white : Colors.black,
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
                                                  aod.getBool()[n+nn] = !aod.getBool()[n+nn];
                                                });

                                              },
                                              child: Text(aod.getValue()[n+nn],style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                            ),
                                            //↑今テストで作ってる
                                          ),
                                        ]
                                      ],
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(widget.PageFlag == 'CreateUser')...[
                                  Container(
                                    height: 55,
                                    width: 290,
                                    margin: const EdgeInsets.fromLTRB(5, 15, 5, 10),
                                    child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape:RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 7
                                      ),
                                      onPressed:(){
                                        aod.HanteiObligation();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context){
                                              return StateRecommendation_allergy(PageFlag: widget.PageFlag, PageCount : pagecount);
                                            })
                                        );
                                      },
                                      child: const FittedBox(
                                        child: Text('表示推奨アレルギー',
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                                if(widget.PageFlag == 'ChooseUser' || widget.PageFlag =='SettingUser')...[
                                  Container(
                                    height: 85,
                                    width: 150,
                                    margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
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
                                        aod.HanteiObligation();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context){
                                              return StateRecommendation_allergy(PageFlag: widget.PageFlag, PageCount : pagecount);
                                            })
                                        );
                                      },
                                      child: const FittedBox(
                                        child: Text('表示推奨\nアレルギー',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center
                                        ),
                                      ),

                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    height: 85,
                                    margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
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
                                        StartTimer();
                                        _selectAdd();
                                        Future.delayed(const Duration(seconds: 1)).then((_){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context){
                                                return StateAnother_ingredient(PageFlag: widget.PageFlag, PageCount : pagecount);
                                              })
                                          );
                                          isLoading = false;
                                          setState(() {});
                                        });
                                      },
                                      child: const Text('登録済み\n成分',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            Container(
                              height: 55,
                              width: 290,
                              margin:const EdgeInsets.fromLTRB(0, 3, 0, 12),
                              child:  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[700],
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 7
                                ),
                                onPressed:(){
                                  aod.HanteiObligation();
                                  ard.HanteiRecommendation();
                                  aad.HanteiAnother();
                                  if(widget.PageFlag == 'ChooseUser'){
                                    if(aod.getValueCheck().isEmpty && ard.getValueCheck2().isEmpty && aad.getValueCheck3().isEmpty){
                                      showDialog(
                                          context: context,
                                          builder: (_){
                                            return const  AlertDialogCompState();
                                          }
                                      );
                                    }else{
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return const StateImageLoderSelect();
                                          })
                                      );
                                    }
                                  }else if(widget.PageFlag == 'CreateUser' || widget.PageFlag =='SettingUser'){
                                    Navigator.of(context).pop();
                                  }

                                },
                                child: const Text('決定',style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        )
                      ),

                      ],
                    ),
                  )
              )
            ),
        ),
        if (isLoading)...[
          StateLoadingIndicator(value: _value,)
        ],
      ],
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