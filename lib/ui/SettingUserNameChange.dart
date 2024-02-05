import 'package:flutter/material.dart';
import 'dart:async';

import '../DB/User.dart';

import '../component/AppbarComp.dart';
import '../component/LoadingIndhicator.dart';

class StateSettingUserNameChange extends StatefulWidget{
  final String UserName;
  const StateSettingUserNameChange(this.UserName);

  @override
  State<StateSettingUserNameChange> createState(){
    return SettingUserNameChange();
  }
}

class SettingUserNameChange extends State<StateSettingUserNameChange>{
  String afterName = "";

  double _value = 0.0;
  bool isLoading = false;

  void StartTimer(){
    _value = 0;
    int counter = 0;
    Timer.periodic(Duration(milliseconds: 25), (Timer timer) {
      setState(() {
        ++counter;
        debugPrint('counterのなかみ$counter');
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
              colors:[Colors.white,Color(0xFFFAAC90)],
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
                                        color:Colors.deepOrange,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  TextSpan(
                                    text:'ユーザー名の変更',
                                    style: TextStyle(
                                        fontSize: 25,
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
                      child:SingleChildScrollView(
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Container(
                                child:Container(
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
                                      Container(
                                        width:60,
                                        child: const Icon(
                                          Icons.account_box,
                                          color: Colors.redAccent,
                                          size:45,
                                        ),
                                      ),
                                      Container(
                                        width: 220,
                                        child:Text(widget.UserName,style: const TextStyle(fontSize: 22),textAlign: TextAlign.center,),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                margin:const EdgeInsets.fromLTRB(10,20,10,5),
                                child:const Text('新しいユーザー名を\n入力してください',
                                  style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin:const EdgeInsets.fromLTRB(10,10,10,10),
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red)
                                ),
                                child:SizedBox(
                                  width:200,
                                  child:TextField (
                                    style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                    maxLength: 7,
                                    onChanged: (value){
                                      afterName = value;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                  width: 180,
                                  height:55,
                                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                  child:ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      elevation: 7
                                    ),
                                    child:const Text('更新',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                                    onPressed: (){
                                      isLoading = true;
                                      StartTimer();
                                      setState(() {
                                        _updateUser();
                                        _selectlistUser();
                                      });
                                      //ユ－ザー選択画面(ChooseUser)
                                      Future.delayed(const Duration(seconds: 1)).then((_){
                                        Navigator.popUntil(context,ModalRoute.withName('ChooseUser_page'));
                                        isLoading = false;
                                        setState(() {});
                                      });
                                    },
                                  )
                              ),
                            ]
                        ),
                      )
                    ),
                  ],
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
  void _updateUser() async {
    debugPrint("_updateUserにきました");
    await dbUser.updateUser(widget.UserName,afterName);
    debugPrint('ユーザを更新しました');
  }

  void _selectlistUser() async {
    debugPrint('_selectAllUserにきました');
    final result = await dbUser.selectlistUser();
    debugPrint('userNameの中身$result');
  }


}