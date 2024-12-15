import 'dart:io';

import 'package:camera/camera.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/message_body.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/paginated_list_view_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/chat_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/message_bubble_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../../../main.dart';
import '../../../utill/color_resources.dart';
import '../../camera/screen/camera_screen.dart';
import '../../support/file catch/docx.dart';
import '../../support/file catch/mp3.dart';
import '../../support/file catch/mp4.dart';
import '../../support/file catch/pdf.dart';

class ChatScreen extends StatefulWidget {
  final int? id;
  final String? name;
  final bool isDelivery;
  final String? image;
  final String? phone;
  final bool shopClose;
  final int? userType;
  const ChatScreen({super.key,  this.id, required this.name,  this.isDelivery = false,  this.image, this.phone, this.shopClose = false, this.userType=1});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool emojiPicker = false;
FocusNode focusNode =FocusNode();
  bool isClosed = false;
  void clickedOnClose(){
    setState(() {
      isClosed = true;
    });
  }


  @override
  void initState() {
    loadDaa();
     _askingPermission(false);

    super.initState();
  }

  Future<void> loadDaa() async{
    print('name ${widget.name} / image ${widget.image}');
    Provider.of<ChatController>(context, listen: false)
        .initialiseControllers();
    Provider.of<ChatController>(context, listen: false).getDir();
   await Provider.of<ChatController>(context, listen: false).getMessageList( context, widget.id, 1, userType: widget.userType);
  }


  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: ()async{
        loadDaa();
      },
      child: Scaffold(

        appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
          titleSpacing: 0,
          elevation: 1,
          leading: InkWell(onTap: ()=> Navigator.pop(context),
              child: Icon(CupertinoIcons.back, color: Theme.of(context).textTheme.bodyLarge?.color)),
          title: Row(children: [

            ClipRRect(borderRadius: BorderRadius.circular(100),
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.125))),
                  height: 40, width: 40,child: CustomImageWidget(image: widget.image??''))),


            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: Text(widget.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge?.color)))]),

        ),

        body: Stack(
          children: [
            Consumer<ChatController>(
                builder: (context, chatProvider,child) {

                return Column(children: [
                  chatProvider.messageModel != null? (chatProvider.messageModel!.message.isNotEmpty)?
                  Expanded(child:  SingleChildScrollView(controller: scrollController,
                    reverse: true,
                    child: Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      child: PaginatedListView(
                        reverse: false,
                        scrollController: scrollController,
                        onPaginate: (int? offset) => chatProvider.getMessageList(context,widget.id,offset!, reload: false),
                        totalSize: chatProvider.messageModel!.totalSize,
                        offset: int.parse(chatProvider.messageModel!.offset),
                        enabledPagination: chatProvider.messageModel == null,
                        itemView: ListView.builder(
                          itemCount: chatProvider.dateList.length,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return  Column(mainAxisSize: MainAxisSize.min, children: [
                              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall,
                                vertical: Dimensions.paddingSizeSmall),
                                child: Text(chatProvider.dateList[index].toString(),
                                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),
                                  textDirection: TextDirection.ltr)),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: chatProvider.messageList[index].length,
                                  itemBuilder: (context, subIndex){
                                  if(subIndex !=0){
                                    return MessageBubbleWidget(
                                      message: chatProvider.messageList[index][subIndex],
                                      previous: subIndex == (chatProvider.messageList[index].length -1) ?  null :
                                      chatProvider.messageList[index].elementAt(subIndex+1),
                                      next: chatProvider.messageList[index][subIndex-1],
                                    );
                                  }else{
                                    return MessageBubbleWidget(
                                      message: chatProvider.messageList[index][subIndex],
                                      previous: subIndex == (chatProvider.messageList[index].length -1) ?  null :
                                      chatProvider.messageList[index].elementAt(subIndex+1),
                                    );
                                  }
                              })
                            ],);
                          },
                        ),
                      ),
                    )),
                  ) : const Expanded(child: NoInternetOrDataScreenWidget(isNoInternet: false)):
                  const Expanded(child: ChatShimmerWidget()),



                  Container(
                    color:  chatProvider.isLoading == false && ((chatProvider.pickedImageFileStored.isNotEmpty) || (chatProvider.objFile != null && chatProvider.objFile!.isNotEmpty)) ?
                    Theme.of(context).primaryColor.withOpacity(0.1) : null,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ((chatProvider.pickedImageFileStored.isNotEmpty)  || (chatProvider.objFile != null && chatProvider.objFile!.isNotEmpty)) ?
                          const SizedBox(height: Dimensions.paddingSizeSmall) : const SizedBox(),

                        // Bottom TextField



                      chatProvider.isLoading == false &&chatProvider.pickedImageFileStored.isNotEmpty
                          ? Container(
                          height: 90,

                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(color: Colors.transparent),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 100,
                                  // width: 200,
                                  child: Stack(children: [
                                    Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child:chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('pdf')
                                                ?PdfWidget(file: File( chatProvider
                                                .pickedImageFileStored[index].path),isSend: false,):
                                            chatProvider
                                                .pickedImageFileStored[index].path.endsWith('docx')?DocxAndXlsxFile(file: File(chatProvider
                                                .pickedImageFileStored[index].path), fileName: chatProvider
                                                .pickedImageFileStored[index].name,isSend: false,):
                                            chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('mp3')||chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('m4a')?WaveBubble(
                                              // appDirectory:
                                              // Directory(chatProvider
                                              //     .pickedImageFileStored[
                                              // index]
                                              //     .path),
                                              width: 80,
                                              // index: index,
                                              isSender: true,
                                              // ofline: true,
                                              path: chatProvider
                                                  .pickedImageFileStored[
                                              index]
                                                  .path,
                                            ):
                                            chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('temp')? Mp4Widget(file:File( chatProvider.pickedImageFileStored[index].path),
                                              isSend: true, min: true, height: 80, width: 80,


                                            ):chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('m4a')||chatProvider
                                                .pickedImageFileStored[index].path
                                                .endsWith('mp3')
                                                ? WaveBubble(
                                              // appDirectory: Directory(chatProvider
                                              //     .pickedImageFileStored[index]
                                              //     .path),
                                              width: 100,
                                              // index: index,
                                              isSender: false,
                                              // ofline: true,
                                              path: chatProvider
                                                  .pickedImageFileStored[index]
                                                  .path,
                                            )
                                                : SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: Image.file(
                                                    File(chatProvider
                                                        .pickedImageFileStored[index]
                                                        .path),
                                                    fit: BoxFit.fill)))),
                                    Positioned(
                                        right: 5,
                                        child: InkWell(
                                            child: const Icon(Icons.cancel_outlined,
                                                color: Colors.red),
                                            onTap: () => chatProvider.pickMultipleImage(true,
                                                index: index)))
                                  ]),
                                );
                              },
                              itemCount: chatProvider.pickedImageFileStored.length))
                          : const SizedBox(),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: chatProvider.micOn? const Color(0xFFF0F5F5):null,

                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12)
                            ,topRight:  Radius.circular(12),

                          ),
                        ),
                        child: Stack(
                          children: [
                            if(chatProvider.micOn==false)
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
                            if(chatProvider.micOn)
                              Positioned(
                                bottom:20,
                                right: 30,

                                child: Text(chatProvider.formattedDuration.toString(),style: GoogleFonts.tajawal(

                                  fontSize: 20,
                                  color: Colors.black

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
                                        chatProvider.  getMicOn(true);
                                        chatProvider.startTimer();
                                        chatProvider.refreshWave();
                                        chatProvider.startOrStopRecording();


                                      // }

                                    },
// onlongpress,
                                    onLongPressEnd: (vak)async{
                                      print('onLongPressEnd');
                                       chatProvider.startOrStopRecording();

                                      chatProvider.  getMicOn(false);
                                      chatProvider.stopTimer();






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
                                                    chat: true,
                                                    camera: firstCamera,
                                                  );
                                                },
                                              ));
                                        } else {

                                        }
                                      },
                                      child: Image.asset(Images.chatCamera,width: 25 ,)),
                                  // const SizedBox(width: 5,),
                                  // InkWell(
                                  //     onTap: (){
                                  //       // PopupMenuButton<String>(
                                  //       //   onSelected: (String value) {
                                  //       //     // Handle your action on selection here
                                  //       //     print('Selected: $value');
                                  //       //   },
                                  //       //   itemBuilder: (BuildContext context) {
                                  //       //     return {'Option 1', 'Option 2', 'Option 3'}.map((String choice) {
                                  //       //       return PopupMenuItem<String>(
                                  //       //         value: choice,
                                  //       //         child: Text(choice),
                                  //       //       );
                                  //       //     }).toList();
                                  //       //   },
                                  //       // );
                                  //       support.pickMultipleImage(false);
                                  //     },
                                  //     child: Image.asset(Images.chatFile,width: 25,)),
                                  // const SizedBox(width: 5,),
                                  PullDownButton(

                                    itemBuilder: (context) => [
                                      PullDownMenuItem(
                                        title: getTranslated('photo', context)!,
                                        onTap: () {
                                          chatProvider.pickMultipleImage(false);

                                        },
                                      ),
                                      // const PullDownMenuDivider(),
                                      PullDownMenuItem(
                                        title: getTranslated('video', context)!,
                                        onTap: () {
                                          chatProvider.pickImageCamera();
                                        },
                                      ),
                                      PullDownMenuItem(
                                        title: getTranslated('Files', context)!,
                                        onTap: () {
                                          chatProvider.pickMultipleMedia(false);
                                        },
                                      ),
                                    ],
                                    buttonBuilder: (context, showMenu) => CupertinoButton(
                                        onPressed: showMenu,
                                        padding: EdgeInsets.zero,
                                        child: Image.asset(Images.chatFile,width: 25,)
                                    ),
                                  ),


                                  InkWell(
                                      onTap: (){
                                        if (isValidText(_controller.text)==false ) {
                                        } else {

                                          MessageBody messageBody = MessageBody(id : widget.id!,  message: _controller.text,file: chatProvider.pickedImageFileStored);
                                                                  chatProvider.sendMessage(messageBody, userType: widget.userType);
                                                        _controller.clear();

                                          _controller.text = '';
                                        }
                                      },
                                      child: Image.asset(Images.chatSend,width: 25,)),
                                  const SizedBox(width: 10,),

                                ],
                              ),
                            )
                          ],
                        ),
                      )

                      ],
                    ),
                  ),








                ]);
              }
            ),

            if(widget.shopClose && !isClosed)
              Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                decoration: const BoxDecoration(
                    color: Color(0xFFFEF7D1)),
                child: Row(children: [
                  Expanded(child: Text("${getTranslated("shop_close_message", context)}",
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge?.color))),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  InkWell(onTap: ()=> clickedOnClose(),
                      child: Icon(Icons.cancel, size: 35, color: Theme.of(context).hintColor, ))
                ],
                ),)
          ],
        ),
      ),
    );
  }
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
    if (await Permission.microphone.isGranted) {
      Permission.microphone.request();
      return false;
    } else {
      return true;
    }
  }

}
bool isValidText(String text) {

  String trimmedText = text.trim();
  return trimmedText.length >= 2;
}



Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}

