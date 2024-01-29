import 'package:flutter/material.dart';

import '../component/AppbarComp.dart';
import '../ui/ReadIngredient.dart';
import '../component/BottomNavbarComp.dart';

class StateAllergyNotDetection extends StatefulWidget{
  const StateAllergyNotDetection({super.key});
  @override
  State<StateAllergyNotDetection> createState(){
    return AllergyNotDetection_Page();
  }
}

class AllergyNotDetection_Page extends State<StateAllergyNotDetection>{

  @override
  Widget build(BuildContext context){
    print("AllergyNotDetectionにきた");
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
        bottomNavigationBar: const BottomNavbarCompState(flagName: 'none', text: '選択したアレルゲンが含まれていないようです。閲覧後、移動したいページのボタンをクリックしてください。',),
        body: Center(
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child:  Container(
                    alignment: Alignment.center,
                    width: 200,
                    padding: const EdgeInsets.fromLTRB(0, 12, 0, 7),
                    decoration: const BoxDecoration(
                      border:Border(
                          bottom: BorderSide(
                              color: Colors.blue
                          )
                      ),
                    ),

                    child:RichText(
                      text: const TextSpan(
                          children: [
                            TextSpan(
                              text:'読み込み結果',
                              style: TextStyle(
                                fontSize: 28,
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
                    children:<Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child:const FittedBox(
                          child:Text('指定されたアレルゲンは\n見つかりませんでした。',
                            style: TextStyle(
                                color:Colors.indigo,
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      Container(
                        width: 250,
                        margin:const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child:Image.asset('images/duck.png'),
                      ),

                      Container(
                        height: 55,
                        width: 260,
                        margin: const EdgeInsets.all(10),
                        child:ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              elevation: 7
                          ),
                          onPressed: (){
                            for(int n = 0; n < 2 ; n++ ){
                              Navigator.pop(context);
                            }
                          },
                          child: const FittedBox(
                            child: Text('他の商品をスキャンする',
                              style:TextStyle(
                                fontSize: 24,
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 260,
                        margin: const EdgeInsets.fromLTRB(10,10,10,20),
                        child:ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              elevation: 7
                          ),
                          onPressed: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context){
                                  return ReadIngredient();
                                })
                            );
                          },
                          child: const FittedBox(
                            child: Text('読み取った成分を見る',
                              style:TextStyle(
                                fontSize: 24,
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}