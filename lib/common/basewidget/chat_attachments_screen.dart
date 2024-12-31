import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/support/domain/models/support_reply_model.dart';
import '../../features/support/widgets/file_view.dart';

class ChatAttachmentsScreen extends StatefulWidget {
final List<Attachment> attachment;
final String chatName;
  const ChatAttachmentsScreen({super.key, required this.attachment, required this.chatName});

  @override
  State<ChatAttachmentsScreen> createState() => _ChatAttachmentsScreenState();
}

class _ChatAttachmentsScreenState extends State<ChatAttachmentsScreen> {
  @override
  Widget build(BuildContext context) {
    int selectIndex=0;
    return Scaffold(
      body: Column(children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
              color: Colors.grey.shade800,

            ),
            child:  Padding(
              padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(widget.chatName,style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,fontSize: 16
                    ),),
                      Text(DateConverter.convertStringTimeToDateChatting(widget.attachment[selectIndex].createdAt),style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,fontSize: 14
                    ),),


                  ],),
                  const SizedBox(width: 20,),
              ],),
            ),
          ),

        const Spacer(),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
            color: Colors.grey.shade800,

          ),
          child: ListView.builder(
            itemCount: widget.attachment.length,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
            return Container(
              child: FileView(),
            );
          },),
        ),
      ],),
    );
  }
}
class FileView extends StatefulWidget {
  const FileView({super.key});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

