import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';

import '../../splash/controllers/splash_controller.dart';


class ConversationListTabview extends StatelessWidget {
  final TabController? tabController;
  const ConversationListTabview({super.key, this.tabController});

  @override
  Widget build(BuildContext context) {

    return Consumer<SplashController>(
      builder:(context, splash, child) {
        List<Widget> taps=[
          if(splash.configModel!.chatWithSellerStatus==true)
            SizedBox(
              height: 35,
              width: splash.configModel!.chatWithDeliveryStatus==true?MediaQuery.of(context).size.width/2.65:MediaQuery.of(context).size.width/1.2,
              child:  Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(getTranslated('vendor', context)!,style: GoogleFonts.tajawal(fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
            ),
      if(splash.configModel!.chatWithDeliveryStatus==true)
            SizedBox(
              height: 35,
              width:splash.configModel!.chatWithSellerStatus==true?
              MediaQuery.of(context).size.width/2.65:MediaQuery.of(context).size.width/1.2,

              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(getTranslated('delivery-man', context)!,style: GoogleFonts.tajawal(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),

        ];
        return Consumer<ChatController>(
          builder: (context, chatProvider,_) {

        return Row(
          children: [
            TabBar(
              controller: tabController,
              unselectedLabelColor: Theme.of(context).iconTheme.color,
              isScrollable: true,
              dividerColor: Colors.transparent,

              indicatorColor: Theme.of(context).primaryColor,
              labelColor:  Theme.of(context).primaryColor,
              labelStyle: GoogleFonts.tajawal(),
              indicatorWeight: 0.5,
              tabAlignment: TabAlignment.center,
              dividerHeight: 0.5,

              tabs:  taps,
              onTap: (index){
                if(chatProvider.isActiveSuffixIcon){
                  chatProvider.setUserTypeIndex(context, tabController!.index, searchActive: true);
                }else{
                  chatProvider.setUserTypeIndex(context, tabController!.index);

                }
              },
            ),

            const Expanded(child: SizedBox()),
          ],
        );
      });
      },
    );
  }
}
