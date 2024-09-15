
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/conversation_tabview.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/chat_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/inbox_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/widgets/search_inbox_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';


class InboxScreen extends StatefulWidget {
  final bool isBackButtonExist;
  const InboxScreen({super.key, this.isBackButtonExist = true});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin{

  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  late bool isGuestMode;
  @override
  void initState() {

    // isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    //   if(!isGuestMode) {
        load();
        _tabController = TabController(vsync: this, length: 2);
      // }

    super.initState();
  }


  Future<void> load ()async {
    await Provider.of<ChatController>(context, listen: false).getChatList(1, reload: false,userType: 0);
    await Provider.of<ChatController>(Get.context!, listen: false).getChatList(1, reload: false,userType: 1  );
    _tabController.addListener(() {
      Provider.of<ChatController>(context,listen: false).getChatType(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: Navigator.of(context).canPop(),
      onPopInvoked: (val) async{
        if(Navigator.of(context).canPop()){
          return;
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: getTranslated('inbox', context), isBackButtonExist: widget.isBackButtonExist,
        onBackPressed: (){
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop();
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
          }
        }),
        body: Consumer<ChatController>(
          builder: (context, chat, _) {
            return Column(children: [
              // if(!isGuestMode)
              Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall,
                  Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
                child: ConversationListTabview(tabController: _tabController),
              ),
              Consumer<ChatController>(
                builder: (context, chat, _) {
                  return Padding(padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),    child: SearchInboxWidget(hintText: getTranslated('search', context)));
                }),



              Expanded(child:

                RefreshIndicator(
                  onRefresh: () async {
                    searchController.clear();
                    await chat.getChatList(1, userType: _tabController.index);
                  },
                child: Consumer<ChatController>(
                  builder: (context, chatProvider, child) {
                    // ChatModel? catModel;

                    // if(_tabController.index == 0){
                    //   if(chatProvider.isSearchComplete){
                    //     catModel = chatProvider.searchDeliverymanChatModel;
                    //   } else {
                    //     catModel = chatProvider.deliverymanChatModel;
                    //   }
                    // } else{
                    //   if(chatProvider.isSearchComplete){
                    //     catModel = chatProvider.searchChatModel;
                    //   } else {
                    //     catModel = chatProvider.chatModel;
                    //   }
                    // }

                    return chatProvider.loading==false? (chatProvider.catModel!=null&&chatProvider.catModel!.chat != null && chatProvider.catModel!.chat!.isNotEmpty)?
                      ListView.builder(
                        itemCount: chatProvider.catModel!.chat?.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15,),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ChatItemWidget(chat: chatProvider.catModel?.chat![index], chatProvider: chat),
                          );
                        },
                      ) : const NoInternetOrDataScreenWidget(isNoInternet: false, message: 'no_conversion', icon: Images.noInbox) : const InboxShimmerWidget();
                  }))
              ),
            ]);
          }
        ),
      ),
    );
  }
}



