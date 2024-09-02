import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/widget/notification_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/widget/notification_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../domain/models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  final bool fromNotification;
  const NotificationScreen({super.key,  this.fromNotification = false});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();
  final PagingController pagingController =
  PagingController(firstPageKey: 1);
  int _page=1;
  int get page =>_page;
  bool firstTime=true;
  static const _pageSize = 20;

  Future<void> fetchPage(int pageKey) async {
    try {
      firstTime=true;

      final List<NotificationItemModel>  newItems = await Provider.of<NotificationController>(context, listen: false).getNotificationList(1);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      setState(() {
        _page =(_page+1);

      });
    } catch (error) {
      pagingController.error = error;
    }
    firstTime=false;

  }
  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(page,);
    });
    // if(widget.fromNotification){
    //   Provider.of<SplashController>(context, listen: false).initConfig(context).then((value){
    //     Provider.of<NotificationController>(context, listen: false).getNotificationList(1);
    //   });
    // }else{
    //   Provider.of<NotificationController>(context, listen: false).getNotificationList(1);
    //
    // }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:  CustomAppBar(title: getTranslated('notification', context), onBackPressed: (){
        if(Navigator.of(context).canPop()){
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
        }
      }),

      body: Consumer<NotificationController>(
        builder: (context, notificationController, child) {
          return        PagedListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
            physics: const BouncingScrollPhysics(),
            pagingController: pagingController,

            builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder: (context) {
                return const SizedBox(
                    height: 1000,
                    child: NotificationShimmerWidget());
              },
              noMoreItemsIndicatorBuilder: (context) {
                return const  SizedBox.shrink();  },
              newPageErrorIndicatorBuilder: (context) {
                return  const SizedBox.shrink();
              // newPageProgressIndicatorBuilder: (context) {
              //   return const ProductShimmer(isHomePage: false,
              //       isEnabled: true);
              },
              noItemsFoundIndicatorBuilder: (context) {
                return  const NoInternetOrDataScreenWidget(isNoInternet: false,
            message: 'no_notification', icon: Images.noNotification,);  },
              itemBuilder: (context, item, index) {
                return NotificationItemWidget(notificationItem: item as NotificationItemModel, index: index,);

              },),

          ); }));
  }
}




// notificationController.notificationModel.isNotEmpty ?
//           (notificationController.notificationModel.isNotEmpty) ?
//           RefreshIndicator(onRefresh: () async => await notificationController.getNotificationList(1),
//             child:
//             SingleChildScrollView(
//               controller: scrollController,
//               child: PaginatedListView(
//                  scrollController: scrollController,
//                 onPaginate: (int? offset) {  },
//                 totalSize: notificationController.totalNotification,
//                 offset:  notificationController.totalOffset,
//                 itemView: ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: notificationController.notificationModel.length,
//                   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
//                   itemBuilder: (context, index) =>
//                       NotificationItemWidget(notificationItem: notificationController.notificationModel[index]),
//                 )))) : const NoInternetOrDataScreenWidget(isNoInternet: false,
//             message: 'no_notification', icon: Images.noNotification,) : const NotificationShimmerWidget();
//
