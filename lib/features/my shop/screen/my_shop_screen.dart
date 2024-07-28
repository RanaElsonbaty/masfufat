import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:provider/provider.dart';

import '../../../utill/images.dart';
import '../widget/header.dart';
import '../widget/search_widget.dart';
import '../widget/select_type_section.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  ScrollController scrollController =ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:  SafeArea(
  child: RefreshIndicator(
    onRefresh: ()async{},
    child: CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).highlightColor,
          title: Image.asset(Images.logoWithNameImage, height: 150),
        ),
        const SliverToBoxAdapter(
          child: Column(children: [
            Row(
              children: [
                Expanded(child: SelectTypeSection(title: 'Selected_products', subTitle: 'Waiting_for_price_status_and_sync', index: 0,)),
                Expanded(child: SelectTypeSection(title: 'My_related_products', subTitle: '', index: 1,)),
                Expanded(child: SelectTypeSection(title: 'Deleted_products', subTitle: 'Due_to_deletion_or_updating_of_data', index: 2,)),
              ],
            )
          ],),
        ),
        SliverPersistentHeader(pinned: true,

            delegate: SliverDelegate(
          child: Consumer<MyShopController>(builder:(context, myShopProvider, child) =>  HeaderSection(index:myShopProvider.selectIndex ,))
        )),
        SliverPersistentHeader(pinned: false,

            delegate: SliverDelegate(
          child: Consumer<MyShopController>(builder:(context, myShopProvider, child) => myShopProvider.isSearch? const MyShopSearchWidget():SizedBox.shrink())
        )),
        const SliverToBoxAdapter(
          child: Column(children: [

          ],),
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

