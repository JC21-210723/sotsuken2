import 'package:flutter/material.dart';

import '../DB/User.dart';

import '../ui/CreateUser2.dart';
import '../Data/AllUserData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../Data/AllAnotherData.dart';
import '../component/AppbarComp.dart';

class StateCreateUser1 extends StatefulWidget{
  const StateCreateUser1({super.key});

  @override
  State<StateCreateUser1> createState(){
    return CreateUser1_Page();
  }
}

class CreateUser1_Page extends State<StateCreateUser1>{
  String UN = "";
  String ErrorMessage = "";
  AllUserData aud = AllUserData(username: AllUserData.sUserName);
  AllObligationData aod = AllObligationData();
  AllRecommendationData ard = AllRecommendationData();
  AllAnotherData aad = AllAnotherData();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppbarComp(),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Container(
                            margin:const EdgeInsets.fromLTRB(0,30,0,10),
                            child:const Text('ユーザー名を\n入力してください',
                              style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.all(10),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo)
                            ),
                            child:SizedBox(
                              width:200,
                              child:TextField (
                                style:const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                                maxLength: 7,
                                onChanged: (value){
                                  UN = value;
                                },
                              ),
                            ),
                          ),
                          Text(ErrorMessage,style:const TextStyle(fontSize: 18,color:Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          Container(
                              width: 180,
                              height:55,
                              margin: const EdgeInsets.fromLTRB(0, 15, 0, 30),
                              child:ElevatedButton(
                                style:ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  elevation: 7
                                ),
                                child:const Text('次へ',style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                                onPressed: (){
                                  if(UN == "") {
                                    setState(() {
                                      ErrorMessage = "名前が入力されていません";
                                    });
                                  }else if(DBuser.userName.contains(UN)){
                                    setState((){
                                      ErrorMessage = 'この名前は使われています';
                                    });
                                  }else if(UN.contains(' ')){
                                    setState((){
                                      ErrorMessage = '空白「 」は\nご利用いただけません';
                                    });
                                  }else if(UN.contains('　')){
                                    setState((){
                                      ErrorMessage = '空白「 」は\nご利用いただけません';
                                    });
                                  }else{
                                    setState(() {
                                      aud.setUserName(UN);
                                      aod.AllResetObligation();
                                      ard.AllResetRecommendation();
                                      aad.AllResetAnother();
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context){
                                          return StateCreateUser2(aud.getUserName());
                                        })
                                    );
                                    setState(() {
                                      ErrorMessage = "";
                                    });

                                  }
                                },
                              )
                          ),
                        ]
                    ),
                  )

              ],
            ),
          ),
        ),
      ),
    );
  }
}