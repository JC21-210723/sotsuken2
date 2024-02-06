import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/AppbarComp.dart';
import '../component/BottomNavbarComp.dart';
import '../ui/AllergyNotDetection.dart';
import '../ui/AllergyDetection.dart';

import 'dart:io';
import '../Api/api.dart';
import '../Api/verification.dart';
import '../Api/crop.dart';

class ImageCheck extends StatefulWidget {
  const ImageCheck(this.image, {Key? key}) : super(key: key);
  final XFile image;

  @override
  _ImageCheckState createState() => _ImageCheckState();
}

class _ImageCheckState extends State<ImageCheck> {
  bool isLoading = false;
  String state = "トリミング";
  XFile? cropimage;
  Image? imagepath;

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:[Colors.white,Color(0xFF90D4FA)],
              ),
            )
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppbarComp(),
          bottomNavigationBar: const BottomNavbarCompState(flagName: 'none', text: '画像を選択したら、成分表のみが映るようにトリミングをしてください。',),
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
                  height: 300,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 170,
                          height: 40,
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.crop,
                              color: Colors.white,
                            ),
                            label: Text(state,style: TextStyle(fontSize: 18),),
                            style: ElevatedButton.styleFrom(
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ) ,
                              elevation: 7,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () async {
                              print("ボタン押されたよ:$state");
                              if (state == "トリミング") {
                                await Crop.cropImage(widget.image, (croppedFile) {
                                  print("トリミングだった：$croppedFile");
                                  if (croppedFile != null) {
                                    setState(() {
                                      cropimage = XFile(croppedFile.path);
                                      imagepath = Image.file(File(cropimage!.path));
                                      state = "クリア";
                                      print("cropimage:$cropimage");
                                      print("imagepath:$imagepath");
                                      print("state:$state");
                                    });
                                  }
                                });
                              } else if (state == "クリア") {
                                Crop.clearImage((clearedImage) {
                                  print("クリアだった：$clearedImage");
                                  if (clearedImage == null) {
                                    setState(() {
                                      cropimage = null;
                                      imagepath = null;
                                      state = "トリミング";
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                            width: 220,
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: imagepath ?? Image.file(File(widget.image.path)),
                            )
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            'この画像でよろしいですか？',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.fromLTRB(7, 5, 20, 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[400],
                                    shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ) ,
                                    elevation: 7
                                ),
                                child: const Text(
                                  'いいえ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.fromLTRB(7, 5, 20, 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange[700],
                                    shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ) ,
                                    elevation: 7
                                ),
                                child: const Text(
                                  'はい',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  try{
                                    setState(() {
                                      isLoading = true;
                                    });
                                    XFile xFileimage = cropimage ?? widget.image;
                                    await Api.instance.postData(xFileimage);
                                    List<String> content = await verifications.instance.verification();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (!content.contains("No")) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return StateAllergyDetection();
                                        }),
                                      );
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return StateAllergyNotDetection();
                                        }),
                                      );
                                    }
                                  }catch(error){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                            Text('ネットワークエラー'),
                                          ],
                                        ),
                                        content: const Text('接続状況を確認してください'),
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
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),// プログレスバーの表示
        if (isLoading)
          Container(
            color: Colors.white54,
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child:Text('NowLoading',style: TextStyle(fontSize: 15,color: Colors.blue.shade600,decoration: TextDecoration.none),),
                  ),
                  const SizedBox(
                    width:70,
                    height: 70,
                      child:CircularProgressIndicator(strokeWidth: 7),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}