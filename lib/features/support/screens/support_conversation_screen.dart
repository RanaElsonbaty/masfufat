import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_reply_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../common/pick_photo_Screen.dart';
import '../../../main.dart';
import '../../../utill/images.dart';
import '../../camera/screen/camera_screen.dart';
import '../file catch/docx.dart';
import '../file catch/mp3.dart';
import '../file catch/mp4.dart';
import '../file catch/pdf.dart';

class SupportConversationScreen extends StatefulWidget {
  final SupportTicketModel supportTicketModel;

  const SupportConversationScreen(
      {super.key, required this.supportTicketModel});

  @override
  State<SupportConversationScreen> createState() =>
      _SupportConversationScreenState();
}

class _SupportConversationScreenState extends State<SupportConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Timer? _updateTimer;

  @override
  // payment_delayed
  void initState() {
    Provider.of<SupportTicketController>(context, listen: false)
        .getSupportTicketReplyList(context, widget.supportTicketModel.id);
    Provider.of<SupportTicketController>(context, listen: false)
        .initialiseControllers();
    Provider.of<SupportTicketController>(context, listen: false).getDir();
      _updateTimer = Timer.periodic(const Duration(seconds: 20), (_) {
        Provider.of<SupportTicketController>(context, listen: false)
            .getSupportTicketReplyList(context, widget.supportTicketModel.id);
      });

    super.initState();
     _askingPermission(false);

  }
  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.supportTicketModel.subject,
      ),
      body:
          Consumer<SupportTicketController>(builder: (context, support, child) {
        return Column(children: [
          Expanded(child: Consumer<SupportTicketController>(
              builder: (context, support, child) {
            return support.supportReplyList != null
                ? ListView.builder(
                    itemCount: support.supportReplyList!.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      bool isMe = (support.supportReplyList![index].adminId !=
                              '1' ||
                          support.supportReplyList![index].customerMessage !=
                              '');
                      String? message = isMe
                          ? support.supportReplyList![index].customerMessage
                          : support.supportReplyList![index].adminMessage;
                      String dateTime = DateConverter.localDateToIsoStringAMPM(
                          support.supportReplyList![index].createdAt);
                      return SupportTicketReplyWidget(
                          message: message,
                          dateTime: dateTime,
                          isMe: isMe,
                          replyModel: support.supportReplyList![index]);
                    },
                  )
                : const Center(child: CircularProgressIndicator());
          })),
          const SizedBox(
            height: 10,
          ),

          support.isLoading==false&&  support.pickedImageFileStored.isNotEmpty
              ? Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  // decoration: B,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          width:support.pickedImageFileStored[index].path
                              .endsWith('mp3') ||
                              support.pickedImageFileStored[index].path
                                  .endsWith('m4a')? 200 :100,
                          child: Stack(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: support
                                            .pickedImageFileStored[index].path
                                            .endsWith('pdf')
                                        ? PdfWidget(
                                            file: File(support
                                                .pickedImageFileStored[index]
                                                .path),
                                            isSend: false,
                                          )
                                        : support.pickedImageFileStored[index]
                                                .path
                                                .endsWith('docx')
                                            ? DocxAndXlsxFile(
                                                file: File(support
                                                    .pickedImageFileStored[
                                                        index]
                                                    .path),
                                                fileName: support
                                                    .pickedImageFileStored[
                                                        index]
                                                    .name,
                                                isSend: false,
                                              )
                                            : support.pickedImageFileStored[index].path
                                                        .endsWith('mp3') ||
                                                    support.pickedImageFileStored[index].path
                                                        .endsWith('m4a')
                                                ?WaveBubble(
                                      appDirectory: Directory(support.pickedImageFileStored[index].path),
                                      width: 100,
                                      index: index,
                                      isSender: true,
                                      ofline: true,
                                      path: support.pickedImageFileStored[index].path,
                                    )
                                                : support.pickedImageFileStored[index].path
                                                        .endsWith('temp')
                                                    ? Mp4Widget(
                                                        file: File(support
                                                            .pickedImageFileStored[
                                                                index]
                                                            .path),
                                                        isSend: true,
                                                        min: true,
                                                        height: 80,
                                                        width: 80,
                                                      )
                                                    : support.pickedImageFileStored[index].path
                                                            .endsWith('m4a')|| support.pickedImageFileStored[index].path
                                        .endsWith('mp3')
                                                        ? WaveBubble(
                                                            appDirectory:
                                                                Directory(support
                                                                    .pickedImageFileStored[
                                                                        index]
                                                                    .path),
                                                            width: 80,
                                                            index: index,
                                                            isSender: true,
                                                            ofline: true,
                                                            path: support
                                                                .pickedImageFileStored[
                                                                    index]
                                                                .path,
                                                          )
                                                        : SizedBox(
                                                            height: 80,
                                                            width: 80,
                                                            child: Image.file(
                                                                File(support.pickedImageFileStored[index].path),
                                                                fit: BoxFit.cover)))),
                            Positioned(
                                right: 5,
                                child: InkWell(
                                    child: const Icon(Icons.cancel_outlined,
                                        color: Colors.red),
                                    onTap: () => support.pickMultipleImage(true,
                                        index: index)))
                          ]),
                        );
                      },
                      itemCount: support.pickedImageFileStored.length))
              : const SizedBox(),
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: support.micOn? const Color(0xFFF0F5F5):null,

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12)
                ,topRight:  Radius.circular(12),

              ),
            ),
            child: Stack(
              children: [
                if(support.micOn==false)
                 TextField(
                    controller: _controller,
                    focusNode: focusNode,
                    style: GoogleFonts.tajawal(
                        fontSize: Dimensions.fontSizeDefault),
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 100,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF0F5F5),
                      alignLabelWithHint: true,
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12)
                        ),
                          borderSide: BorderSide(color:Color(0xFFF0F5F5),width: 0 )

                      ),
                      enabledBorder:const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12)
                                  ,topRight:  Radius.circular(12),

                          ),
                        borderSide: BorderSide(color:Color(0xFFF0F5F5),width: 0 )
                      ),
                      hintText: 'اكتب رسالتك هنا . . . ',

                      hintStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorResources.hintTextColor),
                      border: InputBorder.none,
                      labelStyle: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      )
                      // suffixIcon:
                    )),
                if(support.micOn)
                  Positioned(
                    bottom:20,
                    right: 30,

                    child: Text(support.formattedDuration.toString(),style: GoogleFonts.tajawal(

                        fontSize: 20,

                    ),),
                  ),
                Positioned(
                  left: 0,
                  bottom:20,
                  child: Row(
                    children: [

                      GestureDetector(

                       onLongPress: ()async{
                         print('onLongPress');

                         // bool permission =
                         // print(permission);
                         // if (permission == true) {
                           print('object');
                           support.  getMicOn(true);
                           support.startTimer();
                           support.refreshWave();
                           support.startOrStopRecording();


                         // }

                       },

                        onLongPressEnd: (vak)async{
                          print('onLongPressEnd');
                          support.startOrStopRecording();

                          support.  getMicOn(false);
                          support.stopTimer();




                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle
                          ),
                          child: const Icon(Icons.mic,color: Colors.white,size: 18,),
                        ),
                      ),
                      const SizedBox(width: 8,),

                      // Image.asset(Images.chatMic,width: 50,),
                      InkWell(
                          onTap: ()async{
                            bool permission =
                                                        await _askingPermission(true);
                                                    if (permission==true) {
                                                      final cameras = await availableCameras();
                                                      final firstCamera = cameras.first;
                                                      Navigator.push(Get.context!,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return CameraScreen(
                                                            camera: firstCamera,
                                                          );
                                                        },
                                                      ));
                                                    } else {

                                                    }
                          },
                          child: Image.asset(Images.chatCamera,width: 25 ,)),

            PullDownButton(

            itemBuilder: (context) => [
            PullDownMenuItem(
            title: getTranslated('photo', context)!,
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context) => GridGallery(index: 0, onTap: (File file){
              //   print('object -------> ${file.path}');
              //   support.pickMultipleImage(false,);
              //
              // }, video: false,),));
              support.pickMultipleImage(false,);

            },
            ),
            // const PullDownMenuDivider(),
            PullDownMenuItem(
            title: getTranslated('video', context)!,
            onTap: () {
              support.pickImageCamera();
            },
            ),
              PullDownMenuItem(
            title: getTranslated('Files', context)!,
            onTap: () {
              support.pickMultipleMedia(false);
            },
            ),
            ],
            buttonBuilder: (context, showMenu) => CupertinoButton(
            onPressed: showMenu,
            padding: EdgeInsets.zero,
            child: Image.asset(Images.chatFile,width: 25,)
            ),
            ),


                    // support.isLoading==false?
                    InkWell(
                          onTap: ()async{
                            if (_controller.text.isEmpty &&_controller.text=='') {
                                              } else {
                                               await support.sendReply(widget.supportTicketModel.id,
                                                    _controller.text);
                                         setState(() {
                                           _controller.text = '';
                                           _controller.clear();
                                         });
                                              }

                          },
                          child: Image.asset(Images.chatSend,width: 25,)),
                        // : CircularProgressIndicator(
                      // color: Theme.of(context).primaryColor,
                    // ),
                      const SizedBox(width: 10,),

                    ],
                  ),
                )
              ],
            ),
          )
        ]);
      }),
    );
  }

  Future<bool> _askingPermission(bool camera) async {
    if (camera) {
      await Permission.camera.request();
      if (await Permission.camera.isDenied) {
        return false;
      } else {
        return true;
      }
    } else {
      await Permission.microphone.request();
      if (await Permission.microphone.isDenied) {
        return false;
      } else {
        return true;
      }
    }
  }
}
