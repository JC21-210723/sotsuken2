import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogCompState extends StatefulWidget {
  const AlertDialogCompState({super.key,});

  @override
  State<AlertDialogCompState> createState() {
    return AlertDialogComp();
  }
}

class AlertDialogComp extends State<AlertDialogCompState>{
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('注意',style: TextStyle(fontSize: 20),),
      content: const Text('アレルゲンを一つ以上\n選択してください',style: TextStyle(fontSize: 18),),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK',style: TextStyle(fontSize: 23),),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}