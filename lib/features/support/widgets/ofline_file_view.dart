import 'dart:io';

import 'package:flutter/material.dart';

import '../domain/models/support_reply_model.dart';
import '../file catch/docx.dart';
import '../file catch/mp3.dart';
import '../file catch/mp4.dart';
import '../file catch/pdf.dart';
import 'file_diaglog_widget.dart';

class OflineFileView extends StatefulWidget {
  const OflineFileView({super.key, required this.replyModel, required this.index});
  final List<Attachment> replyModel;
  final int index;
  @override
  State<OflineFileView> createState() => _OflineFileViewState();
}

class _OflineFileViewState extends State<OflineFileView> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(onTap: () {
      if(
           widget.replyModel[widget.index].fileType.endsWith('mp3')||widget.replyModel[widget.index].fileType.endsWith('m4a')
      ){}else{
        showDialog(context: context, builder: (ctx)  =>  FileDialog(
            imageUrl: widget.replyModel[widget.index].fileUrl));
      }

    },
      child: ClipRRect(borderRadius: BorderRadius.circular(5),
          child:widget.replyModel[widget.index].fileUrl.endsWith('png')||widget.replyModel[widget.index].fileType.endsWith('jpg')?
        SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Image.file(File(  widget.replyModel[widget.index].filePath,),fit: BoxFit.fill,)):
          widget.replyModel[widget.index].fileType.endsWith('temp')||widget.replyModel[widget.index].fileType.endsWith('mp4')?
          Mp4Widget(
            file:  File(widget.replyModel[widget.index].fileUrl),
            min: false,
            isSend: false,
            height: 150,
            width: MediaQuery.of(context).size.width/2,)
              :  widget.replyModel[widget.index].fileType.endsWith('pdf')?

          PdfWidget(file: File( widget.replyModel[widget.index].fileUrl),isSend: true,):
          widget.replyModel[widget.index]
              .fileType.endsWith('docx')|| widget.replyModel[widget.index]
              .fileType .endsWith('xlsx')
              ? DocxAndXlsxFile(
            file: File(widget.replyModel[widget.index].fileUrl),
            fileName: widget.replyModel[widget.index].fileName,
            isSend: false,
          )
              : widget.replyModel[widget.index].fileType.endsWith('mp3')||widget.replyModel[widget.index].fileType.endsWith('m4a')?
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
