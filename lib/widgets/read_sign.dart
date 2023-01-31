import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_lang_detect/main.dart';
import 'package:tflite/tflite.dart';
import 'package:dotted_border/dotted_border.dart';

class ReadSign extends StatefulWidget {
  const ReadSign({Key? key}) : super(key: key);

  @override
  State<ReadSign> createState() => _ReadSignState();
}

class _ReadSignState extends State<ReadSign> {

  bool isWorking = false;
  String result = "";
  CameraController? cameraController;
  CameraImage? imageCamera;

  initCamera(){
    cameraController = CameraController(cameras![0], ResolutionPreset.ultraHigh);
    cameraController!.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {
        cameraController?.startImageStream((imageFromStream){
          if(!isWorking){
            isWorking = true;
            imageCamera = imageFromStream;
            runModelOnStreamFrames();
          }
        });
      });
    });
  }

  runModelOnStreamFrames() async {
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: imageCamera!.planes.map((plane){
          return plane.bytes;
        }).toList(),

        imageHeight: imageCamera!.height,
        imageWidth: imageCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.8,
        asynch: true
    );

    result = "";

    recognitions!.forEach((response) {
      result += response['label'];
    });
    debugPrint(result);

    setState(() {
      result;
    });
    // print(result);
    isWorking = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: screen.height-100,
                    width: screen.width,
                    child: imageCamera==null ?
                    Container() :
                    AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
                  ),
                ),
                Positioned(
                  top: screen.height/2-175,
                  left: screen.width/2-100,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    color: Colors.blueAccent,
                    dashPattern: const [10,10],
                    radius: const Radius.circular(125),
                    strokeWidth: 2,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(125),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12
                    ),
                    child: SingleChildScrollView(
                      child: result == "."
                          ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5,),
                          Icon(CupertinoIcons.circle_fill,size: 15,color: Colors.grey[200],),
                          const SizedBox(width: 5,),
                          Icon(CupertinoIcons.circle_fill,size: 15,color: Colors.grey[200],),
                          const SizedBox(width: 5,),
                          Icon(CupertinoIcons.circle_fill,size: 15,color: Colors.grey[200],),
                          const SizedBox(width: 5,),
                        ],
                      )
                          : Text(
                        result,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[200],
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
