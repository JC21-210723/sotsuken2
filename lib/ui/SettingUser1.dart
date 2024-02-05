import 'package:flutter/material.dart';

import '../DB/User.dart';

import '../ui/SettingUser2.dart';
import '../component/AppbarComp.dart';
import '../component/BottomNavbarComp.dart';

class StateUserSettings1 extends StatefulWidget{
  const StateUserSettings1({super.key});

  @override
  State<StateUserSettings1> createState(){
    return UserSettings1();
  }
}

class UserSettings1 extends State<StateUserSettings1>{

  void PageRoute(String name) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return StateUserSettings2(name);
        })
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
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
        bottomNavigationBar: BottomNavbarCompState(flagName: 'none', text: 'ユーザーごとの設定が行えます。ユーザー名をクリックすることで選択できます。',),
        body: Center(
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
                  child:Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(15,20,15,15),
                        child: const FittedBox(
                          child: Text('登録内容を変更する\nユーザーを選択してください',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:Colors.deepOrange)
                                ),
                                child:Container(
                                  width:265,
                                  height:200,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:Colors.deepOrange)
                                  ),
                                  child:Column(
                                    children: [
                                      Expanded(
                                        child:Scrollbar(
                                          child: ListView(
                                            children: [
                                              if(DBuser.userName.isEmpty)...[
                                                Container(
                                                  margin:const EdgeInsets.fromLTRB(0, 40, 0, 20),
                                                  child:const FittedBox(
                                                    child:Center(
                                                      child:Text('ユーザーが\n登録されていません',
                                                        style:TextStyle(
                                                          fontSize: 25,color:Colors.black87,
                                                          fontWeight: FontWeight.bold,
                                                        ),textAlign: TextAlign.center,
                                                      ),
                                                    ),

                                                  ),
                                                ),
                                              ],
                                              for(String n in DBuser.userName)...[
                                                Container(
                                                  width: 240,
                                                  height: 50,
                                                  margin: const EdgeInsets.all(2),
                                                  child:OutlinedButton(
                                                    style:OutlinedButton.styleFrom(
                                                        side:const BorderSide(
                                                            color: Colors.deepOrangeAccent
                                                        )
                                                    ),
                                                    child:Text(n,style:const TextStyle(fontSize: 25,color:Colors.black87)),
                                                    onPressed: (){
                                                      PageRoute(n);
                                                    },
                                                  ),
                                                ),
                                              ]
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      )

                    ],
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}