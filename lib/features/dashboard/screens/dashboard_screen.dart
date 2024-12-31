import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/models/navigation_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/widgets/dashboard_menu_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/widgets/app_exit_card_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/more_screen_view.dart';
import 'package:provider/provider.dart';

import '../../Store settings/controllers/store_setting_controller.dart';
import '../../my shop/screen/my_shop_screen.dart';
import '../../order/screens/order_page_builder.dart';
import '../../product/screens/all_category_and_brand.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key, this.orderError=false});
  final bool? orderError;
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 0;
  late List<NavigationModel> _screens ;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();

  bool singleVendor = false;




  @override
  void initState() {
    super.initState();
if(widget.orderError==true){
  _setPage(3);
}

      _screens = [
        NavigationModel(
          name: 'Home',
          icon: Images.homeIcon,
          screen:
    const HomePage()
        ),
        NavigationModel(name: 'CATEGORY', icon: Images.category, screen: const AllCategoryAndBrand(backButtom: false,)),
if(Provider.of<StoreSettingController>(Get.context!,listen: false).showStoreSetting==true)
        NavigationModel(name: 'my_store', icon: Images.myStoreIcon, screen: const MyShopScreen()),
        // NavigationModel(name: 'cart', icon: Images.cartIcon, screen: const CartScreen(showBackButton: false), showCartIcon: true),
        NavigationModel(name: 'orders', icon: Images.orderIcon, screen:  const OrderPageBuilder(isBacButtonExist: false)),
        NavigationModel(name: 'more', icon: Images.moreIcon, screen:  const MoreScreen()),

      ];







    NetworkInfo.checkConnectivity(context);

  }

  @override
  Widget build(BuildContext context) {

    return PopScope(canPop: false,
      onPopInvoked: (val) async {
        if(_pageIndex != 0) {
          _setPage(0);
          return;
        }else {
          await Future.delayed(const Duration(milliseconds: 150));
          showModalBottomSheet(backgroundColor: Colors.transparent,
              context: Get.context!, builder: (_)=> const AppExitCard());
        }
        return;
      },
      child: Scaffold(
        key: _scaffoldKey,

        body: PageStorage(bucket: bucket, child: _screens[_pageIndex].screen),
        bottomNavigationBar: Container(height: 75,
          decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimensions.paddingSizeLarge)),
            // color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(offset: const Offset(1,1), blurRadius: 2, spreadRadius: 1,
                color: Theme.of(context).primaryColor.withOpacity(.125))],),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getBottomWidget(singleVendor)))

      ));

  }


  void _setPage(int pageIndex) {
    setState(() {
      // if(pageIndex ==1 && _pageIndex != 1 ){
      //   // Provider.of<ChatController>(context, listen: false).setUserTypeIndex(context, 0);
      //   // Provider.of<ChatController>(context, listen: false).resetIsSearchComplete();
      // }
      _pageIndex = pageIndex;
    });
  }

  List<Widget> _getBottomWidget(bool isSingleVendor) {
    List<Widget> list = [];
    for(int index = 0; index < _screens.length; index++) {
      list.add(Expanded(child: CustomMenuWidget(
        isSelected: _pageIndex == index,
        name: _screens[index].name,
        icon: _screens[index].icon,
        showCartCount: _screens[index].showCartIcon ?? false,
        onTap: () => _setPage(index))));
    }
    return list;
  }

}




