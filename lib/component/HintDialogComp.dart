import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HintDialogCompState extends StatefulWidget {
  final String text;
  const HintDialogCompState({super.key, required this.text});

  @override
  State<HintDialogCompState> createState() {
    return HintDialogComp();
  }
}
class HintDialogComp extends State<HintDialogCompState>{
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Hint',style: TextStyle(fontSize: 22),),
      content: Text(widget.text,style: const TextStyle(fontSize: 20),),
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