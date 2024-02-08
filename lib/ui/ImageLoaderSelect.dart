import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../ui/ImageCheck.dart';
import '../component/AppbarComp.dart';
import '../component/BottomNavbarComp.dart';

class StateImageLoderSelect extends StatefulWidget{
  const StateImageLoderSelect({super.key});

  @override
  State<StateImageLoderSelect> createState(){
    return ImageLoderSelect();
  }
}

class ImageLoderSelect extends State<StateImageLoderSelect> {

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
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
        bottomNavigationBar: const BottomNavbarCompState(flagName: 'none', text: '読み取りたい画像を選択してください。',),
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
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding: const EdgeInsets.fromLTRB(10, 7, 0, 7),
                  child:  FittedBox(
                    child:RichText(
                      text:const TextSpan(
                          children: [
                            TextSpan(
                              text:'| ',
                              style: TextStyle(
                                  fontSize: 35,
                                  color:Colors.indigo,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            TextSpan(
                              text:'写真のスキャン',
                              style: TextStyle(
                                  fontSize: 27,
                                  color:Colors.indigo,
                                  fontWeight: FontWeight.bold
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
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                child:SingleChildScrollView(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 30, 10, 25),
                        width: 230,
                        height: 70,
                        child:ElevatedButton.icon(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ) ,
                              elevation: 7
                          ),
                          icon: const Icon(Icons.photo_library,size: 30,),
                          label: const FittedBox(
                            child:Text('メディアから取得',
                              style:TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () async {
                            var imageSource = ImageSource.gallery;
                            final XFile? image = await _picker.pickImage(
                                source: imageSource
                            );
                            if (image != null){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCheck(image),),);
                            }else{
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: Colors.yellow,
                                      ),
                                      Text('エラー'),
                                    ],
                                  ),
                                  content: const Text('読み込みができませんでした。\n他の画像を選択してください'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('OK')),
                                  ],
                                );
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                        width: 230,
                        height: 70,
                        child:ElevatedButton.icon(
                          style:ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ) ,
                              elevation: 7
                          ),
                          icon: Icon(Icons.photo_camera,size: 30),
                          label:const FittedBox(
                            child:Text('カメラで撮影する',
                              style:TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () async {
                            final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (image != null)
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageCheck(image),),);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}