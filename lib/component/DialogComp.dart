import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogCompState extends StatefulWidget {
  final String text;
  const DialogCompState({super.key, required this.text});

  @override
  State<DialogCompState> createState() {
    return DialogComp();
  }
}
class DialogComp extends State<DialogCompState>{
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Hint',style: TextStyle(fontSize: 25),),
      content: Text(widget.text,style: const TextStyle(fontSize: 20),),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK',style: TextStyle(fontSize: 25),),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}