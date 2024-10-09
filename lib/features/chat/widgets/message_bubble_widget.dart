import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../helper/date_converter.dart';
import '../../support/file catch/docx.dart';
import '../../support/file catch/mp3.dart';
import '../../support/file catch/mp4.dart';
import '../../support/file catch/pdf.dart';
import '../../support/widgets/file_diaglog_widget.dart';
import '../../support/widgets/file_view.dart';
import '../../support/widgets/ofline_file_view.dart';

class MessageBubbleWidget extends StatelessWidget {
  final Message message;
  final Message? previous;
  final Message? next;
  const MessageBubbleWidget({super.key, required this.message, this.previous, this.next});

  @override
  Widget build(BuildContext context) {

    List files = [];

    if(previous != null){
      if(previous?.sentBySeller == message.sentBySeller){
      }else{
      }
    }


    bool isMe = message.sentByCustomer==1;


    // if(message.attachment != null) {
    //   // for(List<String> attachment in message!.attachment){
    //   //   if(attachment.type == 'image'){
    //   //     images.add(attachment);
    //   //   }else if (attachment.type == 'file') {
    //   //     files.add(attachment);
    //   //   }
    //   // }
    //   message!.attachment.forEach((element) {
    //     // if(element.endsWith('png') ){
    //     //   images.add(element);
    //     // }else if (element.endsWith('xmls')) {
    //     //   files.add(element);
    //     // }
    //   // });
    // }

    return Consumer<ChatController>(
        builder: (context, chatProvider,child) {
          String dateTime = DateConverter.localDateToIsoStringAMPM(
              message.createdAt);
          String chatTime  = chatProvider.getChatTime(message.createdAt.toString(), message.createdAt.toString());
          bool isSameUserWithPreviousMessage = chatProvider.isSameUserWithPreviousMessage(previous, message);
          bool isSameUserWithNextMessage = chatProvider.isSameUserWithNextMessage(message, next);
          bool isLTR = Provider.of<LocalizationController>(context, listen: false).isLtr;
          String previousMessageHasChatTime = next != null? chatProvider.getChatTime(next!.createdAt.toString(), message.createdAt.toString()) : "";

        return Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start, children: [

            ((!isMe && !isSameUserWithPreviousMessage) ||  (!isMe && isSameUserWithPreviousMessage)) &&
                      chatProvider.getChatTimeWithPrevious(message, previous).isNotEmpty ?
                 Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container( width: Dimensions.paddingSizeExtraLarge + 5, height: Dimensions.paddingSizeExtraLarge + 5,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Theme.of(context).primaryColor)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(20.0),
                      child: CustomImageWidget(
                        fit: BoxFit.cover, width: Dimensions.paddingSizeExtraLarge + 5,
                        height: Dimensions.paddingSizeExtraLarge + 5, image: '${message.attachment}'))),
                )
                     :  !isMe ? const SizedBox(width: Dimensions.paddingSizeExtraLarge + 5,) : const SizedBox(),


                if(message.message.isNotEmpty)
                Flexible(child: InkWell(
                  onTap: (){
                    chatProvider.toggleOnClickMessage(onMessageTimeShowID :
                    message.id.toString());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: isMe && isLTR ?  const EdgeInsets.fromLTRB(70, 2, 10, 2) : EdgeInsets.fromLTRB(10, 2, isLTR ? 70 : 10, 2),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(

                            borderRadius: isMe && (isSameUserWithNextMessage || isSameUserWithPreviousMessage) ? BorderRadius.only(
                              topRight: Radius.circular(isSameUserWithNextMessage && isLTR && chatTime =="" ? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              bottomRight: Radius.circular(isSameUserWithPreviousMessage && isLTR && previousMessageHasChatTime =="" ? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              topLeft: Radius.circular(isSameUserWithNextMessage && !isLTR && chatTime ==""? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              bottomLeft: Radius.circular(isSameUserWithPreviousMessage && !isLTR && previousMessageHasChatTime ==""? Dimensions.radiusSmall :Dimensions.radiusExtraLarge + 5),

                            ) : !isMe && (isSameUserWithNextMessage || isSameUserWithPreviousMessage) ? BorderRadius.only(
                              topLeft: Radius.circular(isSameUserWithNextMessage && isLTR && chatTime ==""? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              bottomLeft: Radius.circular( isSameUserWithPreviousMessage && isLTR && previousMessageHasChatTime =="" ? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              topRight: Radius.circular(isSameUserWithNextMessage && !isLTR && chatTime ==""? Dimensions.radiusSmall : Dimensions.radiusExtraLarge + 5),
                              bottomRight: Radius.circular(isSameUserWithPreviousMessage && !isLTR && previousMessageHasChatTime ==""? Dimensions.radiusSmall :Dimensions.radiusExtraLarge + 5),

                            ) : BorderRadius.circular(Dimensions.radiusExtraLarge + 5),

                                color: isMe ? const Color(0xffF0F5F5): ColorResources.chattingSenderColor(context)),
                            child: (message.message.isNotEmpty) ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(message.message,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,
                                      color :Colors.black),
                              ),
                            ) : const SizedBox.shrink(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10,right: 10),
                        child: Text(dateTime,
                            style: GoogleFonts.tajawal(
                              fontSize: Dimensions.fontSizeSmall, )),
                      ),
                    ],
                  ),
                ))]),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 500),
                    height: chatProvider.onMessageTimeShowID == message.id.toString() ? 25.0 : 0.0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: chatProvider.onMessageTimeShowID == message.id.toString() ?
                        Dimensions.paddingSizeExtraSmall : 0.0,
                      ),
                      child: Text(chatProvider.getOnPressChatTime(message) ?? "", style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall
                      ),),
                    ),
                  ),
                ),

          if(message.attachment.isNotEmpty)
            Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            child: Directionality(textDirection:Provider.of<LocalizationController>(context, listen: false).isLtr ? isMe ?
            TextDirection.rtl : TextDirection.ltr : isMe ? TextDirection.ltr : TextDirection.rtl,
              child: SizedBox(width: MediaQuery.of(context).size.width/2,
                child: ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // childAspectRatio: 1, crossAxisCount: 2,
                  // mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),

                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: message.attachment.length,
                  itemBuilder: (BuildContext context, index) {
                    return  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                              topRight: const Radius.circular(16)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: [

                            message.attachment.isNotEmpty? message.ofline==true?OflineFileView(replyModel: message.attachment, index: index):
                            FileView(replyModel: message.attachment, index: index,):const SizedBox.shrink(),

                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 5,right: 5),
                                  child: Text(dateTime,
                                      style: GoogleFonts.tajawal(
                                        fontSize: Dimensions.fontSizeSmall, color: Colors.white,)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );

                  }),


              )),
          ),











        ]);
      }
    );
  }
}
