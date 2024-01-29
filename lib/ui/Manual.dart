import 'package:flutter/material.dart';

import '../ui/ManualAnotherAdd.dart';
import '../ui/ManualUserAdd.dart';
import '../ui/ManualAddChange.dart';
import '../ui/ManualDeleteUser.dart';

class Manual_Page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const  Text('ご利用方法について'),
      ),
      body: Center(
        child:SingleChildScrollView(
          child:Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange),
                ),
                child:Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange),
                  ),
                  child:const Text('ご利用方法',
                    style: TextStyle(fontSize: 30,color: Colors.deepOrange,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const FittedBox(
                  child: Text('-　-　-　-　-　-　-　-',style: TextStyle(color:Colors.orange,fontWeight:FontWeight.bold,fontSize: 30),),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: const FittedBox(
                  child:Text(
                    ' 本製品をご利用いただき、\nありがとうございます。'
                    '\n\n'
                    '本製品はAIを使用したアプリに\nなっており、登録成分の有無を\n検知します。'
                    '\n\n'
                    '「食品」と「美容」の２品目\n'
                    '   ご利用いただけますので、'
                    '\n用途に合わせて選択してください。',
                    style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const FittedBox(
                  child: Text('-　-　-　-　-　-　-　-',style: TextStyle(color:Colors.orange,fontWeight:FontWeight.bold,fontSize: 30),),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                alignment: Alignment.topLeft,
                child:FittedBox(
                  child:RichText(
                      text: const TextSpan(
                          style: TextStyle(color:Colors.black,),
                          children: [
                            TextSpan(
                                text:'<ご利用の際の注意事項>\n',
                                style: TextStyle(color:Colors.red,fontSize: 23,fontWeight: FontWeight.bold,height: 0.3)
                            ),
                          ]
                      )
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child:FittedBox(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color:Colors.black,),
                        children: [
                          TextSpan(
                              text:'・ネットワークの接続について\n',
                              style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold,height: 2)
                          ),
                          TextSpan(
                            text:'　AIサービスのご利用にあたって、\n　ネットワークが必要になります。\n'
                                  '',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                          ),

                          TextSpan(
                            text:'・ユーザーの登録について\n',
                            style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold,height: 2.5),
                          ),
                          TextSpan(
                            text:'　本製品はユーザー情報を登録して\n　ご利用いただけます。\n'
                                '　また、SKIPにて登録せずにご利用\n　いただくこともできます。\n',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                          ),

                          TextSpan(
                            text:'・追加成分の登録について\n',
                            style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold,height: 2.5),
                          ),
                          TextSpan(
                            text:'　既存の項目以外のアレルゲンや、\n　苦手な成分をご登録いただけます。\n',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                          ),

                          TextSpan(
                            text:'・写真のトリミングについて\n',
                            style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold,height: 2.5),
                          ),
                          TextSpan(
                            text:'　AIの精度を上げるため、原材料\n　または成分のみが映るように\n　トリミングを行ってください。',
                            style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                          ),
                        ]
                    ),

                  ),
                ),

              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: const FittedBox(
                  child: Text('-　-　-　-　-　-　-　-',style: TextStyle(color:Colors.orange,fontWeight:FontWeight.bold,fontSize: 30),),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                alignment: Alignment.topLeft,
                child:FittedBox(
                  child:RichText(
                    text: const TextSpan(
                      style: TextStyle(color:Colors.black,),
                      children: [
                        TextSpan(
                            text:'<その他の詳細説明>\n',
                            style: TextStyle(color:Colors.red,fontSize: 23,fontWeight: FontWeight.bold,height: 1)
                        ),
                      ]
                    )
                  ),
                ),
              ),

              Container(
                width:300,
                height:50,
                margin: const EdgeInsets.fromLTRB(10,0,10,10),
                child:OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.deepOrange
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return ManualAnotherAdd_Page();
                      })
                    );
                  },
                  child: const FittedBox(
                     child:Text('追加成分の登録について',style: TextStyle(color:Colors.deepOrange,fontSize: 23,fontWeight: FontWeight.bold),)
                  ),
                )
              ),
              Container(
                  width:300,
                  height:50,
                  margin: const EdgeInsets.all(10),
                  child:OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return ManualUserAdd_Page();
                            })
                        );
                      },
                      child: const FittedBox(
                          child:Text('ユーザーの登録について',style: TextStyle(color:Colors.deepOrange,fontSize: 23,fontWeight: FontWeight.bold),)
                      ),
                  )
              ),
              Container(
                  width:300,
                  height:50,
                  margin: const EdgeInsets.all(10),
                  child:OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return ManualAddChange_Page();
                            })
                        );
                      },
                      child:const FittedBox(
                          child: Text('登録内容の変更について',style: TextStyle(color:Colors.deepOrange,fontSize: 23,fontWeight: FontWeight.bold),)
                      ),
                  )
              ),
              Container(
                  width:300,
                  height:50,
                  margin: const EdgeInsets.fromLTRB(10,10,10,50),
                  child:OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return ManualDeleteUser_Page();
                            })
                        );
                      },
                      child:const FittedBox(
                          child: Text('ユーザーの削除について',style: TextStyle(color:Colors.deepOrange,fontSize: 23,fontWeight: FontWeight.bold),)
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
