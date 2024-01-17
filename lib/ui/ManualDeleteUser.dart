import 'package:flutter/material.dart';

//追加成分登録についてのページ用
class ManualDeleteUser_Page extends StatelessWidget{
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
                margin: const EdgeInsets.fromLTRB(10,40,10,10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange),
                ),
                child:Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange),
                  ),
                  child:const Text('ユーザーの削除について',
                    style: TextStyle(fontSize: 25,color: Colors.deepOrange,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Image.asset('images/ManualDeleteUser1.png'),
              ),
              Container(

                margin:const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:Image.asset('images/ManualDeleteUser2.png'),
              ),
              Container(
                  width: 200,
                  height:50,
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('戻る',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
