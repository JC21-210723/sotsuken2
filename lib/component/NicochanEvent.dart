import 'package:flutter/material.dart';
import 'dart:math';

class StateNicochanEvent extends StatefulWidget{

  @override
  State<StateNicochanEvent> createState() {
    return NicochanEvent();
  }
}

class NicochanEvent extends State<StateNicochanEvent> {
  double x = (Random().nextInt (16).toDouble()-8)/10;
  double y = (Random().nextInt (16).toDouble()-8)/10;
  double rotate = Random().nextInt (4).toDouble()-2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Stack(
        children: [
          GestureDetector(
            onTap: (){
              showDialog(
                  barrierColor:Colors.transparent,
                  context: context,
                  builder: (_){
                    return StateNicochanEvent();
                  }
              );
            },
            child: Container(
              alignment:  Alignment(x,y),
              child: Transform.rotate(
                  angle: rotate,
                  child: const Image(
                    image: AssetImage('images/nicochan.png',),
                    width: 100,
                    height: 100,
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child:Container(
              margin: const  EdgeInsets.fromLTRB(0, 10, 20, 0),
              child:GestureDetector(
                onTap: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            )
          ),
        ],
      )

    );
  }
}


