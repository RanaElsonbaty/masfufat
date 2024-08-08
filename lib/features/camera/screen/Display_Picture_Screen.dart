import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:provider/provider.dart';

import '../../support/file catch/mp4.dart';


class DisplayPictureScreen extends StatefulWidget {
  final String? imagePath;
  final List<XFile> image;
  const DisplayPictureScreen(
      {super.key, this.imagePath, required this.image, });

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  int selectIndex = 0;
  String name = '';

  @override
  // show photo after take it by camera
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChatController>(
        builder: (context, chat, child) => Consumer<SupportTicketController>(
          builder: (context, support, child) {
            // print('asdasdaddsa${ support.pickImageOrVideoCam[selectIndex].path}');
            return Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height-120,
                  width: MediaQuery.of(context).size.width,
                  child: support.pickImageOrVideoCam[selectIndex].path.endsWith('temp')?Mp4Widget(file:File( support.pickImageOrVideoCam[selectIndex].path),
                    isSend: true, min: false,
                     height: MediaQuery.of(context).size.height-120, width: double.infinity,

                  ):Image.file(
                        File(support.pickImageOrVideoCam[selectIndex].path),
                    fit: BoxFit.fill,
                  )),
              Container(
                color: Colors.black,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:support.pickImageOrVideoCam.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectIndex = index;
                                        name = support.pickImageOrVideoCam[index].name
                                            .toString();
                                      });
                                    },
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 0.5, color: Colors.grey)),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        child: support.pickImageOrVideoCam[index].path.endsWith('temp')?Mp4Widget(file:File( support.pickImageOrVideoCam[index].path),
                                           isSend: true, min: true,
                                           height: 80, width: 80,

                                        ):Image.file(
                                          File(support.pickImageOrVideoCam[index].path),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: InkWell(
                                    onTap: () {
                                      support.removePickImageOrVideoCamera(index);

                                      setState(() {
                                        selectIndex = 0;
                                      });

                                    },
                                    child: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {


                            Navigator.pop(context);
                            Navigator.pop(context);

                            support.addPickCameraToList();


                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(13),
                                color: Theme.of(context).primaryColor),
                            child: const Center(
                                child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 30  ,
                                    ))),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            // value.addPhoto(
                            //     [File(widget.imagePath!)], false, false);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
          },
        ),
      ),
    );
  }
}
