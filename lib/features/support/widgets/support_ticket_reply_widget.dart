import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_reply_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

import '../file catch/docx.dart';
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
      Container(margin: isMe ?  const EdgeInsets.fromLTRB(5, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 5, 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: isMe ? const Radius.circular(10) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(10),
              topRight: const Radius.circular(10)),
              color: isMe ? Theme.of(context).primaryColor.withOpacity(.1) : Theme.of(context).highlightColor),
          child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, children: [
                Text(dateTime, style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall, color: ColorResources.getHint(context),)),


                message != null ?
                Text(message??'', style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)) :
                const SizedBox.shrink()])),


      if(replyModel.attachments.isNotEmpty)
        const SizedBox(height: Dimensions.paddingSizeSmall),
      (replyModel.attachments.isNotEmpty)?
      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: Directionality(textDirection:Provider.of<LocalizationController>(context, listen: false).isLtr ? isMe ?
        TextDirection.rtl : TextDirection.ltr : isMe ? TextDirection.ltr : TextDirection.rtl,
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 3,
              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: replyModel.attachments.length,
            itemBuilder: (BuildContext context, attachmentIndex) {


            return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  FileDialog(
                imageUrl: replyModel.attachments[attachmentIndex].fileUrl)),
              child: ClipRRect(borderRadius: BorderRadius.circular(5),
                  child:replyModel.attachments[attachmentIndex].fileType=='png'?
                  CustomImageWidget(height: 150, width: 150, fit: BoxFit.fill,
                      image: replyModel.attachments[attachmentIndex].fileUrl):
                  replyModel.attachments[attachmentIndex].fileType=='temp'||replyModel.attachments[attachmentIndex].fileType=='mp4'?
                  Mp4Widget(
                    file:  File(replyModel.attachments[attachmentIndex].fileUrl),
                    min: false,
                    isSend: true,
                    height: 150,
                    width: 150,)
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
                                            : const SizedBox.shrink()),);

            },),
        ),
      ):
      const SizedBox.shrink(),
    ],
    );
  }
}
