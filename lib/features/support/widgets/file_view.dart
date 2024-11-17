import 'dart:io';

import 'package:flutter/material.dart';

import '../../../common/basewidget/custom_image_widget.dart';
import '../domain/models/support_reply_model.dart';
import '../file catch/docx.dart';
import '../file catch/mp3.dart';
import '../file catch/mp4.dart';
import '../file catch/pdf.dart';
import 'file_diaglog_widget.dart';

class FileView extends StatefulWidget {
  const FileView({super.key, required this.replyModel, required this.index});
  final List<Attachment> replyModel;
  final int index;
  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {

    return    InkWell(onTap: () {
      print( widget.replyModel[widget.index].fileType);
if(widget.replyModel[widget.index].fileUrl.endsWith('mp3')||widget.replyModel[widget.index].fileUrl.endsWith('m4a')){}else {
  showDialog(context: context, builder: (ctx) =>
      FileDialog(
          imageUrl: widget.replyModel[widget.index].fileUrl));
}
    },
      child: ClipRRect(borderRadius: BorderRadius.circular(5),
          child:widget.replyModel[widget.index].fileUrl.endsWith('png')||widget.replyModel[widget.index].fileType.endsWith('jpg')?
          CustomImageWidget(height: 150, width: MediaQuery.of(context).size.width/2, fit: BoxFit.fill,
              image: widget.replyModel[widget.index].fileUrl):
          widget.replyModel[widget.index].fileUrl.endsWith('temp')||widget.replyModel[widget.index].fileUrl.endsWith('mp4')?
          Mp4Widget(
            file:  File(widget.replyModel[widget.index].fileUrl),
            min: false,
            isSend: true,
            height: 150,
            width: MediaQuery.of(context).size.width/2,)
              :  widget.replyModel[widget.index].fileUrl.endsWith('pdf')?

          PdfWidget(file: File( widget.replyModel[widget.index].fileUrl),isSend: true,):
          widget.replyModel[widget.index]
              .fileUrl.endsWith('docx')|| widget.replyModel[widget.index]
              .fileUrl.endsWith('xlsx')
              ? DocxAndXlsxFile(
            file: File(widget.replyModel[widget.index].fileUrl),
            fileName: widget.replyModel[widget.index].fileName,
            isSend: false,
          )
              : widget.replyModel[widget.index].fileUrl.endsWith('mp3')||widget.replyModel[widget.index].fileUrl.endsWith('m4a')?
          WaveBubble(
            appDirectory: Directory(widget.replyModel[widget.index].fileUrl),
            width: MediaQuery.of(context).size.width/2,
            index: widget.index,
            isSender: true,
            ofline: true,
            path:widget.replyModel[widget.index].fileUrl  ,
          ): const SizedBox.shrink()),);
  }
}
