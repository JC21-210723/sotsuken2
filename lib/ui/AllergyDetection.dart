import 'package:flutter/material.dart';

import '../ui/ReadIngredient.dart';
import '../component/AppbarComp.dart';
import '../component/BottomNavbarComp.dart';

import '../Api/verification.dart';

class StateAllergyDetection extends StatefulWidget{
 const StateAllergyDetection({super.key});
  @override
  AllergyDetection_Page createState() => AllergyDetection_Page();
}

class AllergyDetection_Page extends State<StateAllergyDetection>{
  List<String>vals = ["読み込み中"];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (!_isInitialized) {
      // 非同期処理を直接行わず、Future.delayedを使用して非同期処理が完了後にsetStateを呼ぶ
      Future.delayed(Duration.zero, () {
        postData();
        _isInitialized = true;
      });
    }
  }

  void postData() async {
    List<String> contentList = await verifications.instance.verification();
    if (mounted) {
      setState(() {
        print("セットステートするで");
        vals = contentList;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    print("AllergyDetectionにきた");
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
        bottomNavigationBar: const BottomNavbarCompState(flagName:'none',text: '選択したアレルゲンと\n一致したものを表示しています。閲覧後、移動したいページのボタンをクリックしてください。',),
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
                              text:'検出されたアレルゲン',
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
                        margin:const EdgeInsets.fromLTRB(10, 25, 10, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color:Colors.deepOrange,width: 1)
                        ),
                        child:Container(
                          decoration: BoxDecoration(
                              border: Border.all(color:Colors.deepOrange,width: 1)
                          ),
                          margin: const EdgeInsets.all(5),
                          width: 240,
                          height: 180,

                          //ここが表示部分
                          child:ListView.builder(
                            itemCount: vals.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0)
                                    .copyWith(left: 5.0),
                                child: Text('・${vals[index]}',style:const TextStyle(fontSize: 23,fontWeight: FontWeight.bold,height: 1.3)),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 55,
                        width: 260,
                        margin: const EdgeInsets.fromLTRB(8,10,8,5),
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
          )
        ),
      ),
    );
  }
}