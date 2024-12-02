import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/support/controllers/support_ticket_controller.dart';
import '../features/support/domain/models/support_ticket_model.dart';

class TestChat extends StatefulWidget {
  const TestChat({super.key, required this.supportTicketModel});
  final SupportTicketModel supportTicketModel;

  @override
  State<TestChat> createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  Duration duration = const Duration();
  Duration position = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
List<Widget> message =[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SupportTicketController>(context, listen: false)
        .getSupportTicketReplyList(context, widget.supportTicketModel.id).then((value) {
      for (var element in Provider.of<SupportTicketController>(context, listen: false).supportReplyList!) {
   setState(() {
     message.add(  BubbleSpecialThree(
       text: element.customerMessage,
       color: Theme.of(context).primaryColor,
       tail: false,
       isSender: false,
       textStyle: const TextStyle(color: Colors.white, fontSize: 16),
     ),);
     if(element.attachments.isNotEmpty){
       for (var elm in element.attachments) { 
         if(elm.fileType=='png'||elm.fileType=='jpg'){
           message.add(   BubbleNormalImage(
             id: 'id001',
             image: Image.network(elm.fileUrl),
             color: Theme.of(context).primaryColor,
             tail: false,
             onTap: (){},
             delivered: true,
           ),);
         }else if(elm.fileType=='mp3'||elm.fileType=='mp3'){
           message.add(
               BubbleNormalAudio(
                            color: const Color(0xFFE8E8EE),
                            duration: 50,
                            position: 10,
                            isPlaying: isPlaying,

                            isLoading: isLoading,
                            isPause: isPause,


                            onSeekChanged: (value) {

                            },
                            onPlayPauseButtonClick: () {

                            },
                            sent: true,
                          ),
           );
         }
       }
     }
   });
      }});

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child:message.isNotEmpty? Column(
              children: <Widget>[
               ListView.builder(
                 itemCount: message.length,
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) {
                 return  message.reversed.toList()[index];
               },),
       //          BubbleNormalImage(
       //            id: 'id001',
       //            image: Image.asset(Images.file),
       //            color: Theme.of(context).primaryColor,
       //            tail: true,
       //            delivered: true,
       //          ),
       //          BubbleNormalAudio(
       //            color: Color(0xFFE8E8EE),
       //            duration: 50,
       //            position: 10,
       //            isPlaying: isPlaying,
       //
       //            isLoading: isLoading,
       //            isPause: isPause,
       //
       //
       //            onSeekChanged: (value) {
       //
       //            },
       //            onPlayPauseButtonClick: () {
       //
       //            },
       //            sent: true,
       //          ),
       //          DateChip(
       //            date: now,
       //          ),
       // BubbleSpecialThree(
       //            text: 'bubble special three with tail',
       //            color: Color(0xFF1B97F3),
       //            tail: true,
       //            textStyle: TextStyle(color: Colors.white, fontSize: 16),
       //          ),
       //          BubbleSpecialThree(
       //            text: "bubble special three without tail",
       //            color: Color(0xFFE8E8EE),
       //            tail: false,
       //            isSender: false,
       //          ),

                const SizedBox(
                  height: 100,
                )
              ],
            ):const SizedBox(),
          ),
          MessageBar(
            onSend: (_) => print(_),
            actions: [
              InkWell(
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
