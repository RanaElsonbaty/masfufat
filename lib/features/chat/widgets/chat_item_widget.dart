
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatItemWidget extends StatefulWidget {
  final Chat? chat;
  final ChatController chatProvider;
  const ChatItemWidget({super.key, this.chat, required this.chatProvider});

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? baseUrl = '', image = '', call = '', name = '';
  int? id;
  bool vacationIsOn = false;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    baseUrl = widget.chatProvider.userTypeIndex != 0 ?
    Provider.of<SplashController>(context, listen: false).baseUrls!.shopImageUrl:
    Provider.of<SplashController>(context, listen: false).baseUrls!.deliveryManImageUrl;


    id = widget.chatProvider.userTypeIndex != 0 ?
    widget.chat?.sellerId??widget.chat?.adminId : widget.chat!.deliveryManId;

    if(Provider.of<ShopController>(context,listen: false).sellerModel!=null){
for (var element in Provider.of<ShopController>(context,listen: false).sellerModel!) {
  if(element.seller!.id==widget.chat!.sellerId!){
    // widget.chat!.
   setState(() {
     id =element.sellerId;
     name=element.name;
     image=element.image;
     // id =element.id;

   });
  }
}
}else{
      Provider.of<ShopController>(context,listen: false).getTopSellerList(true, 1, type:  '').then((value) {
        for (var element in Provider.of<ShopController>(context,listen: false).sellerModel!) {
          if(element.seller!.id==widget.chat!.sellerId!){
            // widget.chat!.
            setState(() {
              name=element.name;
              image=element.image;
              // id =element.id;

            });
          }
        }
      });
    }
    if(widget.chatProvider.userTypeIndex != 0){
      if (widget.chat?.sellerInfo?.shops![0].vacationEndDate != null) {
        DateTime vacationDate = DateTime.parse(widget.chat!.sellerInfo!.shops![0].vacationEndDate!);
        DateTime vacationStartDate = DateTime.parse(widget.chat!.sellerInfo!.shops![0].vacationStartDate!);
        final today = DateTime.now();
        final difference = vacationDate.difference(today).inDays;
        final startDate = vacationStartDate.difference(today).inDays;

        if ((difference >= 0 && widget.chat!.sellerInfo!.shops![0].vacationStatus==1 && startDate <= 0)|| widget.chat!.sellerInfo!.shops![0].temporaryClose==1!) {
          vacationIsOn = true;
        } else {
          vacationIsOn = false;
        }
      }
    }


    return Consumer<ChatController>(
      builder: (context, chatController,_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell( onTap: (){
              // chatController.seenMessage( context, id,id,);
              // if((name!.trim().isEmpty || name == 'Shop not found' || name!.trim()=='') && widget.chat?.adminId == null){
              //   showCustomSnackBar(getTranslated('user_account_was_deleted', context), context);
              // }else{
                Navigator.push(Get.context!, MaterialPageRoute(builder: (_) =>
                    ChatScreen(id: id, name: name, image:   '$baseUrl/$image',
                        isDelivery: widget.chatProvider.userTypeIndex == 0, phone: call, shopClose: vacationIsOn,)));
              // }
            },
              child: Container(decoration: const BoxDecoration(
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
                  child: Row(children: [

                    Stack(children: [
                        Container(
                            width: 70,height: 70,decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25),width: .5),
                            borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(borderRadius: BorderRadius.circular(100),
                              child: CustomImageWidget(image:'$baseUrl/$image',
                                  height: 50,width: 50, fit: BoxFit.cover))),

                      if(vacationIsOn)
                      Container(width: 70,height: 70,decoration: BoxDecoration(
                         color: Colors.black54.withOpacity(.65),
                          borderRadius: BorderRadius.circular(100)),
                          child: ClipRRect(borderRadius: BorderRadius.circular(100),
                              child: Center(child: Text(getTranslated("close", context)??'',
                                style: textMedium.copyWith(color: Colors.white),))))

                      ],
                    ),
                      const SizedBox(width: Dimensions.paddingSizeDefault,),
                      Expanded(child: Column(children: [

                            Row(children: [

                            // (widget.chat?.adminId == 0 ) ?
                            //   Expanded(child: Text('Provider.of<SplashController>(context, listen: false).configModel?.companyName', maxLines: 1, overflow: TextOverflow.ellipsis,
                            //     style: Goo(fontSize: Dimensions.fontSizeDefault))):
                              Expanded(child: Text(name??'', maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w700))),

                              const SizedBox(width: Dimensions.paddingSizeSmall),

                              Text(DateConverter.compareDates(widget.chat!.createdAt!),
                                  style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)),
                            ],),
                            const SizedBox(height: Dimensions.paddingSizeSmall,),
                            Row(children: [
                              Expanded(child: Text(widget.chat!.message?? getTranslated('sent_attachment', context)!, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w500,)),
                              ),


                              if(widget.chat!.unseenMessageCount != null && widget.chat!.unseenMessageCount! > 0)
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                              if(widget.chat!.unseenMessageCount != null && widget.chat!.unseenMessageCount! > 0)
                                CircleAvatar(radius: 12, backgroundColor: Theme.of(context).primaryColor,
                                    child: Text('${widget.chat!.unseenMessageCount}', style: textRegular.copyWith(
                                        color: Colors.white, fontSize: Dimensions.fontSizeSmall)))
                            ]),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey, // Set the border color
              // indent: 16.0, // Set the indent (optional)
              // endIndent: 16.0, // Set the endIndent (optional)
            ),
          ],
        );
      }
    );
  }
}
