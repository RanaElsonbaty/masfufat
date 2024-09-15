import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/shimmers/sync_shimmers.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/widget/products/linked_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:provider/provider.dart';

import '../widget/header.dart';
import '../widget/search_widget.dart';
import '../widget/select_type_section.dart';
import '../widget/products/sync_product_widget.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  ScrollController scrollController =ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  Future initData()async{
  await  Provider.of<MyShopController>(context,listen: false).getList();
    Provider.of<MyShopController>(Get.context!,listen: false).initController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('my_store', context),isBackButtonExist: false,),
body:  SafeArea(
  child: RefreshIndicator(
    onRefresh: ()async{
    await  initData();

    },
    child: CustomScrollView(

      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        // SliverAppBar(
        //   floating: true,
        //   elevation: 0,
        //   centerTitle: false,
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Theme.of(context).highlightColor,
        //   title: Image.asset(Images.logoWithNameImage, height: 150),
        // ),
         const SliverToBoxAdapter(
          child: Column(children: [
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(child: SelectTypeSection(title: 'Selected_products', subTitle: 'Waiting_for_price_status_and_sync', index: 0,)),
                Expanded(child: SelectTypeSection(title: 'My_related_products', subTitle: '', index: 1,)),
                Expanded(child: SelectTypeSection(title: 'Deleted_products', subTitle: 'Due_to_deletion_or_updating_of_data', index: 2,)),
              ],
            )
          ],),
        ),
        Consumer<MyShopController>(
          builder:(context, myShopProvider, child) =>  SliverPersistentHeader(pinned: false,

              delegate: SliverDelegate(
                  height:70 ,

                  child:   MyShopSearchWidget( selectIndex: myShopProvider.selectIndex,)
              )),
        ),
        Consumer<MyShopController>(
          builder:(context, myShopProvider, child) =>  SliverPersistentHeader(pinned: false,

              delegate: SliverDelegate(
                height: myShopProvider.selectIndex==0?100:60,
            child: Consumer<MyShopController>(builder:(context, myShopProvider, child) =>  HeaderSection(index:myShopProvider.selectIndex ,pending: myShopProvider.selectIndex==0,))
          )),
        ),

         SliverToBoxAdapter(
          child: Consumer<MyShopController>(
            builder:(context, myShopProvider, child) =>   myShopProvider.isLoading==false?  Column(children: [
if(myShopProvider.selectIndex==0)
  myShopProvider.pendingList.isNotEmpty? ListView.builder(
    itemCount:myShopProvider.searchActive?myShopProvider.pendingListSearch.length: myShopProvider.pendingList.length,
    padding: const EdgeInsets.all(0),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {


      return SyncProductWidget(
          pending:myShopProvider.searchActive?myShopProvider.pendingListSearch[index]: myShopProvider.pendingList[index],
          controller: myShopProvider.controller[index],
        index: index,
        );
    },):const NoInternetOrDataScreenWidget(isNoInternet: false),
              if(myShopProvider.selectIndex==1)
                myShopProvider.linkedList.isNotEmpty?ListView.builder(
                  itemCount:myShopProvider.searchActive?myShopProvider.linkedListSearch.length: myShopProvider.linkedList.length,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LinkedProductWidget(
                      linked:myShopProvider.searchActive?myShopProvider.linkedListSearch[index]: myShopProvider.linkedList[index],
                    );
                  },):const NoInternetOrDataScreenWidget(isNoInternet: false),
              if(myShopProvider.selectIndex==2)
                myShopProvider.deleteList.isNotEmpty?ListView.builder(
                  itemCount: myShopProvider.searchActive?myShopProvider.deleteListSearch.length:myShopProvider.deleteList.length,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LinkedProductWidget(
                      unSync: true,
                      linked:myShopProvider.searchActive?myShopProvider.deleteListSearch[index]:myShopProvider.deleteList[index],
                    );
                  },):const NoInternetOrDataScreenWidget(isNoInternet: false),

            ],):const SyncShimmers(),
          ),
        )
      ],
    ),
  ),
),
    );
  }
}
class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}

