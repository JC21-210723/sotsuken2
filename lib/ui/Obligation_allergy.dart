import 'package:flutter/material.dart';

import '../DB/Add.dart';

import '../ui/ImageLoaderSelect.dart';
import '../ui/Recommendation_allergy.dart';
import '../ui/Another_ingredient.dart';
import '../Data/AllAnotherData.dart';
import '../Data/AllObligationData.dart';
import '../Data/AllRecommendationData.dart';
import '../component/AppbarComp.dart';

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
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
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
                          color: Colors.blue.shade200,
                          boxShadow: const [
                            BoxShadow(
                                color:Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(4,4)
                            )
                          ],
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
                                      Container(
                                          width:160,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.blue.shade200,width: 3),
                                              borderRadius: const BorderRadius.only(
                                                bottomLeft:Radius.circular(50),
                                                topLeft:Radius.circular(50),
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              )
                                          ),
                                          child:Transform.scale(
                                              scale:1.05,
                                              child:CheckboxListTile(
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  title: Transform.translate(
                                                    offset: const Offset(-15,0),
                                                    child:Text(aod.getValue()[n+nn],style: const TextStyle(fontSize: 20)),
                                                  ),
                                                  value: aod.getBool()[n+nn],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      aod.getBool()[n+nn] = value!;
                                                    });
                                                  }
                                              )
                                          )
                                      ),
                                    ]else...[
                                      Container(
                                        width: 160,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:Radius.circular(50),
                                              topLeft:Radius.circular(50),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )
                                        ),
                                        child:Transform.scale(
                                          scale:1.05,
                                          child: CheckboxListTile(
                                              controlAffinity: ListTileControlAffinity.leading,
                                              title: Transform.translate(
                                                offset: const Offset(-15,0),
                                                child:Text(aod.getValue()[n+nn],style: const TextStyle(fontSize: 20)),
                                              ),
                                              value: aod.getBool()[n+nn],
                                              onChanged: (value) {
                                                setState(() {
                                                  aod.getBool()[n+nn] = value!;
                                                });
                                              }
                                          ),
                                        ),
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
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                            Container(
                              height: 90,
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
                            if(widget.PageFlag == 'ChooseUser' || widget.PageFlag =='SettingUser')...[
                              Container(
                                width: 150,
                                height: 90,
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
                                    _selectAdd();
                                    Future.delayed(const Duration(seconds: 1)).then((_){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context){
                                            return StateAnother_ingredient(PageFlag: widget.PageFlag, PageCount : pagecount);
                                          })
                                      );
                                    });
                                  },
                                  child: const Text('登録済み成分',
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
                          height: 70,
                          width: 290,
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
                    )
                  ),

                  ],
                ),
              )
          )
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