import 'package:flutter/material.dart';
import 'ManualAnotherAdd.dart';
import 'ManualUserAdd.dart';
import 'ManualAddChange.dart';
import 'ManualDeleteUser.dart';


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
                margin: EdgeInsets.fromLTRB(15, 20, 15, 30),
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
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                alignment: Alignment.topLeft,
                  /*
                  child:  const Column(
                    children: [
                      Text('・ユーザーの登録について\n',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
                        ,textAlign: TextAlign.start,
                      ),Text('本製品はユーザー情報を登録して\nご利用いただけます。\n'
                        'また、SKIPにて登録せずにご利用\nいただくこともできます。',
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                      ),

                    ]
                  ),

                   */


              ),
              Container(
                width:330,
                height:55,
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
                        return ManualAnotherAdd_Page();
                      })
                    );
                  },
                  child: const Text('追加成分の登録について',style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold),)
                )
              ),
              Container(
                  width:330,
                  height:55,
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
                      child: const Text('ユーザーの登録について',style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold),)
                  )
              ),
              Container(
                  width:330,
                  height:55,
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
                      child: const Text('登録内容の変更について',style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold),)
                  )
              ),
              Container(
                  width:330,
                  height:55,
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
                      child: const Text('ユーザーの削除について',style: TextStyle(color:Colors.deepOrange,fontSize: 25,fontWeight: FontWeight.bold),)
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
