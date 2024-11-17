
import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import 'Display_Picture_Screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key,

    this.camera, this.chat=false,
  });
  final bool? chat;

  final CameraDescription? camera;
  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera!,

      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                InkWell(
                  onTap: () async {
                    // _controller.value
                    //     .
                    if (_controller!.value.flashMode == FlashMode.off) {
                      await _controller!.setFlashMode(FlashMode.always);
                    }
                    else if (_controller!.value.flashMode ==
                        FlashMode.always) {
                      await _controller!.setFlashMode(FlashMode.auto);
                    }
                    else {
                      await _controller!.setFlashMode(FlashMode.off);
                    }

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _controller!.value.flashMode == FlashMode.off
                        ? const Icon(Icons.flash_off,color: Colors.white,)
                        : _controller!.value.flashMode == FlashMode.auto
                        ? const Icon(Icons.flash_auto,color: Colors.white,)
                        : const Icon(Icons.flash_on,color: Colors.white,),
                  ),
                ),
              ],),
            ),
          ),
          // camera screen
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height-150,
                  child: CameraPreview(
                    _controller!,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // take photo , save to send and flash
          Container(
            color: Colors.black,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Consumer<ChatController>(
                    builder: (context, chat, child) =>
                        Consumer<SupportTicketController>(
                          builder: (context, support, child) => GestureDetector(
//                             onLongPress: ()async{
//                            await _controller!.startVideoRecording();
//                             },
//                             onLongPressEnd: (val)async{
//                               final XFile image = await _controller!.stopVideoRecording();
//                               final path = await OpenDocument.getPathDocument();
//
//                               XFile? fileMp4=XFile(path);
//                              await convertTempToMp4(image.path,fileMp4.path);
// print('asdasdasdadadssada${fileMp4.path}');
//                               // support.pickImageOrVideoCamera(image);
//                               //
//                               // Navigator.push(context,MaterialPageRoute(builder: (context) {
//                               //   return DisplayPictureScreen(image: [image],);
//                               // },));
//                           },
                            onTap: () async {
                              // _controller.
                              try {
                                await _initializeControllerFuture;
                                // value.takePhoto.delete();
                                final image = await _controller!.takePicture();
                                support.pickImageOrVideoCamera(image);
                                chat.pickImageOrVideoCamera(image);
                                // value.takePhoto = File(image.path);
                                // if (widget.seller) {
                                //   print('camera seller');
                                //   chat.addPhoto([value.takePhoto!], false, true);
                                // } else {
                                //   print('camera support');
                                //
                                //   value.addPhoto([value.takePhoto!], false, true);
                                // }
                                // if (!mounted) return;
                                Navigator.push(Get.context!,MaterialPageRoute(builder: (context) {
                                  return DisplayPictureScreen(image: [image],chat: widget.chat,);
                                },));
                                // await Navigator.of(context).push(
                                //   CustomPageRouteBuilder(
                                //     pageBuilder:
                                //         (context, animation, secondaryAnimation) =>
                                //         DisplayPictureScreen(
                                //           id: widget.id!,
                                //           seller: widget.seller,
                                //           controller: widget.controller,
                                //           // Pass the automatically generated path to
                                //           // the DisplayPictureScreen widget.
                                //           imagePath: image.path,
                                //         ),
                                //   ),
                                // );
                                // Navigator.pop(context);
                                // );
                                print('image =>${image.path}');
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.camera,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                )),
                          ),
                        ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> convertTempToMp4(String tempFilePath, String outputPath) async {
    final command = [
      '-i',
      tempFilePath,
      '-c:v',
      // -c:v mpeg4
      'mpeg4', // Replace with desired codec
      // '-crf',
      // '23', // Replace with desired quality
      outputPath,
    ];

    final session = await FFmpegKit.executeWithArguments(command);
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      print('Conversion successful');
    } else {
      print('Conversion failed: ${await session.getLogs()}');
    }
  }
}
