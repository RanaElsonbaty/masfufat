import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/widgets/support_ticket_reply_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
FocusNode focusNode =FocusNode();
  @override
  void initState() {

    Provider.of<SupportTicketController>(context, listen: false)
        .initialiseControllers();
    Provider.of<SupportTicketController>(context, listen: false).getDir();
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<SupportTicketController>(context, listen: false)
          .getSupportTicketReplyList(context, widget.supportTicketModel.id);
    }
    super.initState();
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
                          support.supportReplyList![index].customerMessage !='');
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
          const SizedBox(height: 10,),

          support.pickedImageFileStored.isNotEmpty
              ? Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Stack(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:support
                            .pickedImageFileStored[index].path
                            .endsWith('pdf')
                        ?PdfWidget(file: File( support
                                      .pickedImageFileStored[index].path),isSend: false,):
                        support
                            .pickedImageFileStored[index].path.endsWith('docx')?DocxAndXlsxFile(file: File(support
                            .pickedImageFileStored[index].path), fileName: support
                            .pickedImageFileStored[index].name,isSend: false,):
                        support
                            .pickedImageFileStored[index].path
                            .endsWith('mp3')||support
                            .pickedImageFileStored[index].path
                            .endsWith('m4a')?WaveBubble(
                          appDirectory: Directory(support
                              .pickedImageFileStored[index]
                              .path),
                          width: 80,
                          index: index,
                          isSender: false,
                          ofline: false,
                          path: support
                              .pickedImageFileStored[index]
                              .path,
                        ):
                                  support
                            .pickedImageFileStored[index].path
                            .endsWith('temp')? Mp4Widget(file:File( support.pickedImageFileStored[index].path),
                                      isSend: true, min: true, height: 80, width: 80,


                                  ):support
                                          .pickedImageFileStored[index].path
                                          .endsWith('m4a')
                                      ? WaveBubble(
                                          appDirectory: Directory(support
                                              .pickedImageFileStored[index]
                                              .path),
                                          width: 80,
                                          index: index,
                                          isSender: true,
                                          ofline: true,
                                          path: support
                                              .pickedImageFileStored[index]
                                              .path,
                                        )
                                      : SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: Image.file(
                                              File(support
                                                  .pickedImageFileStored[index]
                                                  .path),
                                              fit: BoxFit.cover)))),
                          Positioned(
                              right: 5,
                              child: InkWell(
                                  child: const Icon(Icons.cancel_outlined,
                                      color: Colors.red),
                                  onTap: () => support.pickMultipleImage(true,
                                      index: index)))
                        ]);
                      },
                      itemCount: support.pickedImageFileStored.length))
              : const SizedBox(),
          SizedBox(
            height: 70,
            child: Card(
              color: Theme.of(context).highlightColor,
              shadowColor: Colors.grey[200],
              elevation: 2,
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  support.isRecording == false
                      ? Expanded(
                          child: TextField(
                              controller: _controller,
                              focusNode: focusNode,
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,

                              maxLines: 1,
                              decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: 'Type here...',

                                  hintStyle: titilliumRegular.copyWith(
                                      color: ColorResources.hintTextColor),
                                  border: InputBorder.none,
                                  // suffixIcon:
                              )
                          ))
                      : Expanded(
                        child: AudioWaveforms(
                            enableGesture: true,
                            size:
                                Size(MediaQuery.of(context).size.width / 1.9, 45),
                            // backgroundColor: Theme.of(context).primaryColor,
                            recorderController: support.recorderController,
                            waveStyle: const WaveStyle(
                              waveColor: Colors.white,
                              extendWaveform: true,
                              showMiddleLine: false,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.only(left: 18),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                      ),
                  if (focusNode.hasFocus) InkWell(
                          onTap: () {
                            if (_controller.text.isEmpty &&
                                support.pickedImageFileStored.isEmpty) {
                            } else {
                              support.sendReply(widget.supportTicketModel.id,
                                  _controller.text);
                              _controller.text = '';
                            }
                          },
                          child: support.isLoading
                              ? const CircularProgressIndicator()
                              : Icon(Icons.send,
                                  color: Theme.of(context).primaryColor,
                                  size: Dimensions.iconSizeDefault),
                        ) else
                          Row(
                          children: [
                            InkWell(
                                onTap: () =>
                                    support.pickMultipleImage(false),
                                child: Image.asset(
                                  Images.attachment,
                                  color:
                                  Colors.grey,
                                  width: 30,
                                )),
                            InkWell(
                                onTap: () =>
                                    support.pickMultipleMedia(false),
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.file_copy_outlined,
                                      size: 30,
                                      color:
                                      Colors.grey,

                                    ))),
                            InkWell(
                                onTap: () async {
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
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey,
                                  size: 25,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onLongPress: () async {
                                  bool permission =
                                      await _askingPermission(false);
                                  if (permission == true) {
                                    support.refreshWave();
                                    support.startOrStopRecording();
                                  }
                                },
                                onLongPressEnd: (_) async {
                                  support.startOrStopRecording();
                                },
                                child: Icon(
                                  support.isRecording ? Icons.stop : Icons.mic,
                                  color: Colors.grey,
                                  size: 25,
                                )),
                          ],
                        ),
                ]),
              ),
            ),
          ),
          focusNode.hasFocus? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () =>
                        support.pickMultipleImage(false),
                    child: Image.asset(
                      Images.attachment,
                      color:
                      Colors.grey,
                      width: 30,
                    )),
                InkWell(
                    onTap: () =>
                        support.pickMultipleMedia(false),
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.file_copy_outlined,
                          size: 30,
                          color:
                          Colors.grey,

                        ))),
                InkWell(
                    onTap: () async {
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
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.grey,
                      size: 25,
                    )),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onLongPress: () async {
                      bool permission =
                      await _askingPermission(false);
                      if (permission == true) {
                        support.refreshWave();
                        support.startOrStopRecording();
                      }
                    },
                    onLongPressEnd: (_) async {
                      support.startOrStopRecording();
                    },
                    child: Icon(
                      support.isRecording ? Icons.stop : Icons.mic,
                      color: Colors.grey,
                      size: 25,
                    )),
              ],
            ),
          ):const SizedBox(),
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
