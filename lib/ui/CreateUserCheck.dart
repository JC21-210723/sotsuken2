import 'package:flutter/material.dart';
import 'dart:async';

import '../Data/AllAnotherData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../Data/AllUserData.dart';
import '../component/AppbarComp.dart';
import '../component/LoadingIndicator.dart';

import '../DB/User.dart';

class StateCreateUserCheck extends StatefulWidget{
  final String UserName;
  StateCreateUserCheck(this.UserName);

  @override
  State<StateCreateUserCheck> createState(){
    return CreateUserCheck();
  }
}

class CreateUserCheck extends State<StateCreateUserCheck>{

  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
  AllAnotherData aad = AllAnotherData();

  double _value = 0.0;
  bool isLoading = false;

  void StartTimer(){
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
          child: Scaffold(
            backgroundColor:Colors.transparent,
            appBar: AppbarComp(),
            body:  Center(
              child:Container(
                width: 320,
                height:430,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color:Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(7,7)
                    )
                  ],
                ),
                child:SingleChildScrollView(
                    child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Container(
                            margin:const  EdgeInsets.all(7),
                          ),
                          //表示義務
                          if(aod.getValueCheck().isNotEmpty)...[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 120, 0),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.red,width:1),
                              ),

                              child: Container(
                                margin:const EdgeInsets.all(2),
                                padding:const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                decoration:BoxDecoration(
                                    border:Border.all(color:Colors.red,width:1)
                                ),
                                child:const Text('表示義務',
                                    style:TextStyle(
                                        fontSize:25,
                                        fontWeight: FontWeight.bold,
                                        color:Colors.deepOrange
                                    )
                                ),
                              ),
                            ),
                            Container(
                              width: 280,
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              padding:const EdgeInsets.fromLTRB(25, 10, 25, 10),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.red,width:1),
                                  borderRadius: BorderRadius.circular(5),
                              ),
                              //テキスト表示させるやつがいる↓

                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(String obligation in aod.getValueCheck())...[
                                    Text('・$obligation',
                                      style:const TextStyle(
                                        height: 1.5,
                                        fontSize:25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            ),
                          ],

                          //表示推奨
                          if(ard.getValueCheck2().isNotEmpty)...[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 120, 0),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.blue,width:1)
                              ),
                              child:Container(
                                margin:const EdgeInsets.all(2),
                                padding:const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                decoration:BoxDecoration(
                                    border:Border.all(color:Colors.blue,width:1)
                                ),
                                child:const Text('表示推奨',style:TextStyle(fontSize:25,fontWeight: FontWeight.bold,color:Colors.indigo)),
                              ),
                            ),
                            Container(
                              width: 280,
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              padding:const EdgeInsets.fromLTRB(25, 10, 25, 10),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.blue,width:1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              //テキスト表示させるやつがいる↓
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(String recommendation in ard.getValueCheck2())...[
                                    Text('・$recommendation',
                                      style:const TextStyle(
                                        height: 1.5,
                                        fontSize:25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            ),
                          ],

                          //追加成分
                          if(aad.getValueCheck3().isNotEmpty)...[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 70, 0),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.amber,width:1)
                              ),
                              child:Container(
                                margin:const EdgeInsets.all(2),
                                padding:const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                decoration:BoxDecoration(
                                    border:Border.all(color:Colors.amber,width:1),

                                ),
                                child:const Text('その他の成分',style:TextStyle(fontSize:25,fontWeight: FontWeight.bold,color:Colors.orange)),
                              ),
                            ),
                            Container(
                              width: 280,
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                              padding:const EdgeInsets.fromLTRB(25, 10, 25, 10),
                              decoration:BoxDecoration(
                                  border:Border.all(color:Colors.amber,width:1),
                                  borderRadius: BorderRadius.circular(5),
                              ),
                              //テキスト表示させるやつがいる↓
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(String another in aad.getValueCheck3())...[
                                    Text('・$another',
                                      style:const TextStyle(
                                        height: 1.5,
                                        fontSize:25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            ),
                          ],
                          if(aod.getValueCheck().isEmpty && ard.getValueCheck2().isEmpty && aad.getValueCheck3().isEmpty)...[
                            Container(
                                margin: const EdgeInsets.fromLTRB(10, 150, 10, 50),
                                child:const FittedBox(
                                    child:Text('何も登録されていません',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                                )
                            ),
                            Container(
                              width:200,
                              height:55,
                              child: ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    elevation: 7
                                ),
                                child:const Text('戻る',style:TextStyle(fontSize:27,fontWeight: FontWeight.bold)),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                          Container(
                            margin:const  EdgeInsets.all(7),
                          ),
                          if(aod.getValueCheck().isNotEmpty || ard.getValueCheck2().isNotEmpty || aad.getValueCheck3().isNotEmpty)...[
                            Container(
                                width:230,
                                height:60,
                                margin:const EdgeInsets.fromLTRB(15, 0, 15, 30),
                                child:ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      elevation: 7
                                  ),
                                    child:const Text('登録',style:TextStyle(fontSize:30,fontWeight: FontWeight.bold)),
                                    onPressed:(){
                                      setState(() {
                                        isLoading = true;
                                        StartTimer();
                                        _insertUser();
                                        _selectlistUser();
                                        aod.insertHanteiObligation(widget.UserName);//追加
                                        ard.insertHanteiRecommendation(widget.UserName);//追加
                                        aad.insertAllResetAnother(widget.UserName);//追加した処理12/21
                                      });
                                      //ユ－ザー選択画面(ChooseUser)
                                      Future.delayed(const Duration(seconds: 1)).then((_){
                                        Navigator.popUntil(context,ModalRoute.withName('ChooseUser_page'));
                                        aod.AllResetObligation();
                                        ard.AllResetRecommendation();
                                        aad.AllResetAnother();
                                        isLoading = false;
                                        setState(() {});
                                      });
                                    }
                                )
                            )
                          ],
                        ]
                    )
                ),
              ),
            ),
          )
        ),
        if (isLoading)...[
          StateLoadingIndicator(value: _value,)
        ],
      ],
    );
  }

  DBuser dbUser = DBuser();//DBクラスのインスタンス生成
  //ユーザの追加処理
  void _insertUser() async {
    AllUserData row = AllUserData.newAllUserData();
    row.username = AllUserData.sUserName;
    final username = await dbUser.insertUser(row);
    print('ユーザ表にinsertしました: $username');
  }
  void _selectlistUser() async {
    debugPrint('_selectAllUserにきました');
    final result = await dbUser.selectlistUser();
    debugPrint('userNameの中身$result');
  }
}