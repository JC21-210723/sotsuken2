import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HintDialogComp.dart';
import 'NicochanEvent.dart';

class BottomNavbarCompState extends StatefulWidget{
  final String flagName;
  final String text;
  const BottomNavbarCompState({super.key, required this.flagName, required this.text});

  @override
  State<BottomNavbarCompState> createState() {
    return BottomNavbarComp();
  }
}

class BottomNavbarComp extends State<BottomNavbarCompState> {
  var titles = ['Home','User','Hint'];
  var navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight:  Radius.circular(40),
      ),
      child:Container(
        height: 55,
        child:BottomNavigationBar(
          backgroundColor: Colors.blue[400],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 12,
          //fixedColor: Colors.white,
          items:  [
            if(widget.flagName == 'main')...[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 25,color:Colors.white),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.sentiment_satisfied,size: 25,color:Colors.white),
                label: 'Hello',
              ),
            ],
            if(widget.flagName != 'main')...[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 25,color:Colors.white),
                label: 'Home',
              ),

              if(widget.flagName != 'ChooseUser')...[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.switch_account,size: 25,color:Colors.white),
                  label: 'User',
                ),
              ],
            ],
            const BottomNavigationBarItem(
              icon: Icon(Icons.help_outline,size: 25,color:Colors.white),
              label: 'Hint',
            ),
          ],
          onTap: (int index){
            switch(index){
              case 0:
                if(widget.flagName == 'main'){
                  showDialog(
                      context: context,
                      builder: (_){
                        return const HintDialogCompState(text:'ここのページに戻ってくるためのボタンです。覚えておきましょう。');
                      }
                  );
                }else{
                  Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst );
                }
                break;
              case 1:

                if(widget.flagName == 'ChooseUser'){
                  showDialog(
                      context: context,
                      builder: (_){
                        return HintDialogCompState(text:widget.text);
                      }
                  );
                }else if(widget.flagName == 'main'){
                  showDialog(
                      barrierColor:Colors.transparent,
                      context: context,
                      builder: (_){
                        return StateNicochanEvent();
                      }
                  );
                }else{
                  Navigator.popUntil(context,ModalRoute.withName('ChooseUser_page'));
                }
                break;
              case 2:
                showDialog(
                    context: context,
                    builder: (_){
                      return HintDialogCompState(text:widget.text);
                    }
                );
            }
          },
        ),
      ),
    );
  }
}

