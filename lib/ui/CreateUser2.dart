import 'package:flutter/material.dart';
import 'dart:async';

import '../ui/CreateUserCheck.dart';
import '../ui/Obligation_allergy.dart';
import '../ui/Another_ingredient.dart';
import '../main.dart';
import '../Data/AllAnotherData.dart';
import '../component/AppbarComp.dart';
import '../component/LoadingIndicator.dart';
import '../Data/AllRecommendationData.dart';
import '../Data/AllObligationData.dart';

import '../DB/Add.dart';

class StateCreateUser2 extends StatefulWidget{
  final String sUserName;
  StateCreateUser2(this.sUserName);

  @override
  State<StateCreateUser2> createState(){
    return CreateUser2_Page();
  }
}

//String UserName = "";

class CreateUser2_Page extends State<StateCreateUser2> {

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
                colors:[Colors.white,Color(0xFF90D4FA)],
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppbarComp(),
            body: Center(
              child:SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width: 300,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                                        color:Colors.indigo,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text:'ユーザーの登録',
                                    style: TextStyle(
                                        fontSize: 27,
                                        color:Colors.indigo,
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
                      width: 320,
                      height:400,
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

                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                width: 260,
                                height: 60,
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:Colors.indigo
                                      )
                                  ),
                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width:60,
                                      child:Icon(
                                        Icons.account_box,
                                        color: Colors.indigo,
                                        size:45,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child:Text(widget.sUserName,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView(
                                    children: <Widget>[
                                      if(Home_Page.flagCategory != 'beauty')...[
                                        Container(
                                            width:270,
                                            height: 85,
                                            margin: const EdgeInsets.fromLTRB(20,20,20,10),
                                            child:ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:Colors.lightBlue[400],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  elevation: 7
                                              ),
                                              child:const Text('アレルゲンの選択\n(テンプレート)',
                                                style: TextStyle(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context){
                                                      return const StateObligation_allergy(PageFlag : 'CreateUser');
                                                    })
                                                );
                                              },
                                            )
                                        ),
                                        Container(
                                          margin:const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: const FittedBox(
                                            child: Text('表示義務・推奨のアレルゲンを\nお選びいただけます。',
                                              style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],

                                      Container(
                                          width:260,
                                          height: 85,
                                          margin: const EdgeInsets.fromLTRB(20,20,20,10),
                                          child:ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:Colors.lightBlue[600],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              elevation: 7
                                            ),
                                            child:const Text('その他の成分を\n新規追加',
                                              style: TextStyle(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                            onPressed: (){
                                              StartTimer();
                                              _selectAdd();
                                              aad.setValueList3();//移動した。お試し
                                              Future.delayed(const Duration(seconds: 1)).then((_){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context){
                                                      return StateAnother_ingredient(PageFlag:'CreateUser', PageCount: 0);
                                                    })
                                                );
                                                isLoading = false;
                                                setState(() {});
                                              });
                                            },
                                          )
                                      ),
                                      Container(
                                        margin:const EdgeInsets.fromLTRB(0, 0, 0, 15),
                                        child:const Text('テンプレート外の成分を\nご登録いただけます。',
                                          style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                          height:70,
                                          margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
                                          padding:const EdgeInsets.fromLTRB(5,5,5,10),
                                          child:ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.indigo,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                elevation: 7
                                            ),
                                            child:const Text('登録内容を確認',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
                                            onPressed: (){
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context){
                                                    return StateCreateUserCheck(widget.sUserName);
                                                  })
                                              );
                                            },
                                          )
                                      )
                                    ]
                                  )
                              )
                            ],
                      )
                    )
                 ],
                ),
              ),
            )
          )
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