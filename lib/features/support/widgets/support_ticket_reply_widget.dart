import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_reply_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../file catch/docx.dart';
import '../file catch/mp3.dart';
import '../file catch/mp4.dart';
import '../file catch/pdf.dart';
import 'file_diaglog_widget.dart';

class SupportTicketReplyWidget extends StatelessWidget {
  final bool isMe;
  final String dateTime;
  final String? message;
  final SupportReplyModel replyModel;
  const SupportTicketReplyWidget({super.key, required this.isMe, required this.dateTime, this.message, required this.replyModel});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
      Column(
        children: [
          Container(margin: isMe ?  const EdgeInsets.fromLTRB(5, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 5, 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
                  bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
                  topRight: const Radius.circular(10)),
                  color: isMe ? Theme.of(context).primaryColor.withOpacity(.1) : Theme.of(context).highlightColor),
              child: message != null ?
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(message??'', style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault)),
              ) :
              const SizedBox.shrink()),
          Text(dateTime, style: GoogleFonts.tajawal(
            fontSize: Dimensions.fontSizeSmall, )),

        ],
      ),


      if(replyModel.attachments.isNotEmpty)
        const SizedBox(height: Dimensions.paddingSizeSmall),
      (replyModel.attachments.isNotEmpty)?
      Directionality(textDirection:Provider.of<LocalizationController>(context, listen: false).isLtr ? isMe ?
      TextDirection.rtl : TextDirection.ltr : isMe ? TextDirection.ltr : TextDirection.rtl,
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2,
          child: ListView.builder(
            // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
            //     mainAxisExtent: 100,
            //   childAspectRatio: 1
            //
            // ),
            padding: EdgeInsets.all(0),
              shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: replyModel.attachments.length,
            itemBuilder: (BuildContext context, attachmentIndex) {


            return  Padding(
              padding: const EdgeInsets.all(3.0),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  FileDialog(
                        imageUrl: replyModel.attachments[attachmentIndex].fileUrl)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(5),
                          child:replyModel.attachments[attachmentIndex].fileType=='png'||replyModel.attachments[attachmentIndex].fileType=='jpg'?
                          CustomImageWidget(height: 150, width: MediaQuery.of(context).size.width/2, fit: BoxFit.fill,
                              image: replyModel.attachments[attachmentIndex].fileUrl):
                          replyModel.attachments[attachmentIndex].fileType=='temp'||replyModel.attachments[attachmentIndex].fileType=='mp4'?
                          Mp4Widget(
                            file:  File(replyModel.attachments[attachmentIndex].fileUrl),
                            min: false,
                            isSend: true,
                            height: 150,
                            width: MediaQuery.of(context).size.width/2,)
                              :  replyModel.attachments[attachmentIndex].fileType=='pdf'?

                          PdfWidget(file: File( replyModel.attachments[attachmentIndex].fileUrl),isSend: true,):
                          replyModel
                                                            .attachments[
                                                                attachmentIndex]
                                                            .fileType ==
                                                        'docx'
                                                    ? DocxAndXlsxFile(
                                                        file: File(replyModel
                                                            .attachments[
                                                                attachmentIndex]
                                                            .fileUrl),
                                                        fileName: replyModel
                                                            .attachments[
                                                                attachmentIndex]
                                                            .fileName,
                                                        isSend: false,
                                                      )
                                                    : replyModel.attachments[attachmentIndex].fileType=='mp3'||replyModel.attachments[attachmentIndex].fileType=='m4a'?
                          WaveBubble(
                            appDirectory: Directory(replyModel.attachments[attachmentIndex].filePath),
                            width: MediaQuery.of(context).size.width/2,
                            index: attachmentIndex,
                            isSender: true,
                            ofline: true,
                            path:replyModel.attachments[attachmentIndex].fileUrl  ,
                          ): const SizedBox.shrink()),),
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

            },),
        ),
      ):
      const SizedBox.shrink(),
    ],
    );
  }
}
