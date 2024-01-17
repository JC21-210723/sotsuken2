import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sotsuken2/Api/verification.dart';
import 'package:sotsuken2/ui/AllergyNotDetection.dart';
import 'dart:io';
import '../Api/api.dart';
import 'AllergyDetection.dart';
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
    print("Build method is called.");

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    margin: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Text(
                        '写真のスキャン',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Container(
                    width: 250,
                    child: imagepath ?? Image.file(File(widget.image.path)),
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
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          child: const Text(
                            'いいえ',
                            style: TextStyle(
                                color: Colors.deepOrange,
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
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.indigo,
                              )),
                          child: const Text(
                            'はい',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
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
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.crop,
                        color: Colors.white,
                      ),
                      label: Text(state),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue,
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
                ],
              ),
            ),

            // プログレスバーの表示
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
