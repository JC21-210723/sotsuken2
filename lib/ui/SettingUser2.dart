import 'package:flutter/material.dart';
import 'dart:async';

import '../DB/Add.dart';
import '../DB/Food.dart';
import '../DB/List.dart';

import '../ui/SettingUserNameChange.dart';
import '../ui/SettingUserDelete.dart';
import '../ui/SettingUserAllergy.dart';
import '../main.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../Data/AllAnotherData.dart';
import '../component/AppbarComp.dart';
import '../component/BottomNavbarComp.dart';
import '../component/LoadingIndicator.dart';

class StateUserSettings2 extends StatefulWidget{
  final String UserName;
  const StateUserSettings2(this.UserName, {super.key});

  @override
  State<StateUserSettings2> createState(){
    return UserSettings2();
  }
}

class UserSettings2 extends State<StateUserSettings2> {

  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
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
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:[Colors.white,Color(0xFFFAAC90)],
            )
          ),
          child:Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppbarComp(),
            bottomNavigationBar: const BottomNavbarCompState(flagName: 'none', text: 'ユーザーごとの設定が行えます。変更したい項目を選択してください。',),
            body: Center(
              child:SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        padding: const EdgeInsets.fromLTRB(10, 7, 0, 7),
                        child:  FittedBox(
                          child:RichText(
                            text:const TextSpan(
                                children: [
                                  TextSpan(
                                    text:'| ',
                                    style: TextStyle(
                                        fontSize: 35,
                                        color:Colors.deepOrange,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text:'ユーザー設定',
                                    style: TextStyle(
                                        fontSize: 27,
                                        color:Colors.deepOrange,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                        width: 300,
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
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 280,
                                  height: 60,
                                  margin: const EdgeInsets.fromLTRB(5,10,5,5),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:Colors.deepOrangeAccent
                                        )
                                    ),
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width:60,
                                        child: Icon(
                                          Icons.account_box,
                                          color: Colors.redAccent,
                                          size:45,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 220,
                                        child:Text(widget.UserName,style: const TextStyle(fontSize: 22),textAlign: TextAlign.center,),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  width:250,
                                  height:50,
                                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  child:ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        elevation: 7
                                    ),
                                    child: const Text('ユーザー名の変更',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                                    onPressed: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return StateSettingUserNameChange(widget.UserName);
                                          })
                                      );
                                    },
                                  ),

                                ),
                                Container(
                                  width:250,
                                  height:50,
                                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                                  child:ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrangeAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        elevation: 7
                                    ),
                                    child: const Text('アレルゲンの変更',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                                    onPressed: (){
                                      StartTimer();
                                      _selectGimu();//追加した処理12/21
                                      aod.valueCheckClear();
                                      ard.valueCheckClear2();
                                      aad.valueCheckClear3();
                                      aod.AllResetObligation();
                                      ard.AllResetRecommendation();
                                      aad.AllResetAnother();
                                      if(Home_Page.flagCategory == 'food'){
                                        aod.setValueCheck(DBfood.Gimulist);
                                        ard.setValueCheck2(DBfood.Suilist);
                                        aad.setValueCheck3(DBadd.userAddList);
                                      }else{
                                        aad.setValueCheck3(DBadd.userAddList);
                                      }
                                      Future.delayed(const Duration(seconds: 1)).then((_){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context){
                                              return StateSettingAllergy(widget.UserName);
                                            })
                                        );
                                        isLoading = false;
                                        setState(() {});
                                      });
                                    },
                                  ),

                                ),
                                Container(
                                  width:250,
                                  height:50,
                                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                                  child:ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        elevation: 7
                                    ),
                                    child: const Text('ユーザーの削除',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                                    onPressed: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return StateSettingUserDelete(widget.UserName);
                                          })
                                      );
                                    },
                                  ),
                                ),
                              ]
                          )
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isLoading)...[
          StateLoadingIndicator(value: _value,)
        ],
      ],
    );
  }

  //追加した処理12/21
  DBlist dbList = DBlist();//DBクラスのインスタンス生成
  DBfood dbFood = DBfood();//DBクラスのインスタンス生成
  DBadd dbAdd = DBadd();//DBクラスのインスタンス生成
  void _selectGimu() async {
    debugPrint('_selectGimuにきました');
    final int userid = await dbList.selectUserId(widget.UserName);
    debugPrint('これから調べるユーザはuserid：$useridです');
    await dbFood.selectGimu(userid);//表示義務
    await dbFood.selectSui(userid);//表示推奨
    //await dbProvider.selectAdd();
    await dbAdd.selectUserADD(userid);//←ここついかした

  }
}