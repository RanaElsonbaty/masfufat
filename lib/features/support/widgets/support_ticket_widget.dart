import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/controllers/support_ticket_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_conversation_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utill/images.dart';


class SupportTicketWidget extends StatefulWidget {
  final SupportTicketModel supportTicketModel;
   const SupportTicketWidget({super.key, required this.supportTicketModel});

  @override
  State<SupportTicketWidget> createState() => _SupportTicketWidgetState();
}

class _SupportTicketWidgetState extends State<SupportTicketWidget> {
  String type ='';
  @override
  void initState() {
    super.initState();
    if(widget.supportTicketModel.type!.toLowerCase()=='website problem'){
      type='website_problem';

    }else if(widget.supportTicketModel.type!.toLowerCase()=='partner request'){
      type='partner_request';

    }else if(widget.supportTicketModel.type!.toLowerCase()=='partner request'){
      type='partner_request';

    }else if(widget.supportTicketModel.type!.toLowerCase()=='complaint'){
      type='complaint';

    }else if(widget.supportTicketModel.type!.toLowerCase()=='info inquiry'){
      type='info_inquiry';

    }
  }
  @override
  Widget build(BuildContext context) {
    // print(widget.supportTicketModel.status);
    return Consumer<SupportTicketController>(
      builder:(context, support, child) =>  Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 0),
        child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
            SupportConversationScreen(
            supportTicketModel: widget.supportTicketModel,)
        // TestChat(supportTicketModel: widget.supportTicketModel,)
        )),
          child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25), width: .5)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


              Row(children: [
            Container(
              // height: 25,
              // width: 25,
              padding: const EdgeInsets.only(top: 3,left: 3,right: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFFAF2F2)
              ),
              child: Center(
                child: Text(
                          widget.supportTicketModel.id.toString(), style: GoogleFonts.tajawal(
                      color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
              ),
            ),
          Spacer(),
          InkWell(

            onTap: ()async{
            await  support.deleteSupportTicket(widget.supportTicketModel.id).then((value) {
                support.getSupportTicketList();
                });
            },
              child: Image.asset(Images.delete,width: 20,)),

          // const SizedBox(width: Dimensions.paddingSizeSmall,),
          //         Expanded(child: Text(
          //            '${ getTranslated(type, context)!} ', style: GoogleFonts.tajawal(
          //           color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75),fontWeight: FontWeight.w500,fontSize: 16))),
          //       const SizedBox(width: Dimensions.paddingSizeSmall,),


              ]),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(child: Text(
                  widget.supportTicketModel.subject!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                      color: Theme.of(context).hintColor,fontWeight: FontWeight.w500,fontSize: 16))),
                  const SizedBox(width: 50,),
                ],
              ),
              // const SizedBox(width: Dimensions.paddingSizeSmall,),
              //
              // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeEight),
              //   child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
              //     Text('${getTranslated('topic', context)} : ', style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
              //     Expanded(child: Text(supportTicketModel.subject!, style: textRegular)),
              //   ],
              //   ),
              // ),


        const SizedBox(height: 10,),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text.rich(TextSpan(children: [
                  //   TextSpan(text: '${getTranslated('priority', context)}',
                  //       style: textRegular.copyWith()),
                  //   const TextSpan(text: ': '),
                  //   TextSpan(text: supportTicketModel.priority!.capitalize(), style: textRegular.copyWith(color:
                  //   supportTicketModel.priority == 'High'?
                  //   Colors.amber : supportTicketModel.priority == 'Urgent'? Theme.of(context).colorScheme.error :
                  //   (supportTicketModel.priority == 'Low' || supportTicketModel.priority == 'low')?
                  //   Theme.of(context).primaryColor : Colors.greenAccent))
                  // ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(DateConverter.supportTicketDateFormat(DateTime.parse(widget.supportTicketModel.updatedAt!)),
                        style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor,fontWeight: FontWeight.w500,)),
                  ),
                  Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                          color: widget.supportTicketModel.status == 'open' ?
                          const Color(0xffec1013).withOpacity(0.57) :widget.supportTicketModel.status == 'pending' ?
                          const Color(0xFF1B9D00).withOpacity(0.38) : const Color(0xFF5A409B).withOpacity(0.20)),

                      child: Text(widget.supportTicketModel.status == 'pending' ? getTranslated('pending', context)! :
                      widget.supportTicketModel.status == 'open' ? getTranslated('open', context)! :
                      getTranslated('closed', context)!,
                          style: GoogleFonts.tajawal(color:Theme.of(context).iconTheme.color))),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
