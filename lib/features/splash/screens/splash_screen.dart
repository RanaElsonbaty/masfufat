import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/order_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/push_notification/models/notification_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/onboarding/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../../address/controllers/address_controller.dart';
import '../../auth/screens/auth_screen.dart';
import '../../banner/controllers/banner_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../deal/controllers/featured_deal_controller.dart';
import '../../deal/controllers/flash_deal_controller.dart';
import '../../maintenance/maintenance_screen.dart';
import '../../my shop/controllers/my_shop_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../../payment /controller/payment_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../../shop/controllers/shop_controller.dart';
import '../../update/screen/update_screen.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
// with SingleTickerProviderStateMixin
{
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  // late Animation<int> _animation;
  // AnimationController? controller;
  // Offset _getOffset(int angle, int distance) {
  //   return Offset.fromDirection(math.pi / 180 * angle, distance.toDouble());
  // }

    @override
  void initState() {
    super.initState();
    Provider.of<SplashController>(context,listen: false).initConfigGuest(context);
    // AnimationController controller =
    // AnimationController(vsync: this, duration: const Duration(seconds: 20))
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // _animation = _tween.animate(controller);
    //
    // controller.repeat();



    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: isNotConnected ? Colors.red : Colors.green,
        //   duration: Duration(seconds: isNotConnected ? 6000 : 3),
        //   content: Text(isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!,
        //     textAlign: TextAlign.center)));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }
  static Future<void> loadData(bool reload) async {
  await  Provider.of<SplashController>(Get.context!,listen: false).initConfig(Get.context!);

     Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_banner');
       Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
     Provider.of<FlashDealController>(Get.context!, listen: false).getFlashDealList(reload, false);
     Provider.of<ProductController>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
     Provider.of<FeaturedDealController>(Get.context!, listen: false).getFeaturedDealList(reload);
     Provider.of<ShopController>(Get.context!, listen: false).getTopSellerList(reload, 1, type: "top");
     Provider.of<ProductController>(Get.context!, listen: false).getRecommendedProduct();
    Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_section_banner');
    Provider.of<ProductController>(Get.context!, listen: false).getHomeCategoryProductList(reload);
    Provider.of<AddressController>(Get.context!, listen: false).getAddressList();
     Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
     Provider.of<ProductController>(Get.context!, listen: false).getLatestProductList(1, reload: reload);
    Provider.of<MyShopController>(Get.context!,listen: false).getList();

     Provider.of<WishListController>(Get.context!, listen: false).getWishList();
    // await Provider.of<ProductController>(Get.context!, listen: false).getLProductList('1', reload: reload);
     Provider.of<NotificationController>(Get.context!, listen: false).getNotificationList(1);
    if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
   await     Provider.of<ProfileController>(Get.context!, listen: false).getUserInfo(Get.context!);
    }
    Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(true,false);
       Provider.of<PaymentController>(Get.context!,listen: false).getAmount(( 0));
      Provider.of<PaymentController>(Get.context!,listen: false).getApiKey(Get.context!);
     Provider.of<PaymentController>(Get.context!,listen: false).initiate(Get.context!);
     Provider.of<PaymentController>(Get.context!,listen: false).getPaymentMethod(Get.context!,'cart');
    Provider.of<PaymentController>(Get.context!,listen: false).cardViewStyle();
    Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(false,true);
  }

  void _route() async{
    await Provider.of<SplashController>(Get.context!,listen: false).getMaintenanceMode().then((value) {
      if(Provider.of<SplashController>(Get.context!, listen: false).maintenanceMode) {
        Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (_) => const MaintenanceScreen()));
        return ;

      }
    });
    //     Timer(const Duration(seconds: 1), ()
    //     {
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => const AuthScreen()));
    //     });
    // // Provider.of<SplashController>(context, listen: false).initConfig(context).then((bool isSuccess) {
    //   if(isSuccess) {
        String? minimumVersion = "1";
       // String appVersion = '1.0.0';
        if(Platform.isAndroid) {
          minimumVersion =  '1.0.0';
        } else if(Platform.isIOS) {
          minimumVersion =   '1.0.0';
        }
    // مصفوفات
        Provider.of<SplashController>(Get.context!, listen: false).initSharedPrefData();
        Timer(const Duration(seconds: 2), () async{
          if(compareVersions(minimumVersion!, AppConstants.appVersion) == 1) {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (_) => const UpdateScreen()));
          } else

            if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
           await   Provider.of<SplashController>(Get.context!, listen: false).initConfig(context);
            Provider.of<AuthController>(Get.context!, listen: false).updateToken(Get.context!);
            if(widget.body != null){
              if (widget.body!.type == 'order') {
                Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>
                    OrderDetailsScreen(orderId: widget.body!.orderId)));
              }else if(widget.body!.type == 'notification'){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>
                const NotificationScreen()));
              }else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>
                const InboxScreen(isBackButtonExist: true,)));
              }
            }else{
              loadData(true);

              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
            }
          }

          else if(Provider.of<SplashController>(Get.context!, listen: false).showIntro()!){
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen(
              indicatorColor: ColorResources.grey, selectedIndicatorColor: Theme.of(context).primaryColor)));
          }else{
  await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));

            }
          // else{
          //   // if(Provider.of<AuthController>(context, listen: false).getGuestToken() != null &&
          //   //     Provider.of<AuthController>(context, listen: false).getGuestToken() != '1'){
          //     loadData(true);
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
          //   }
          //   else{
          //     Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
          //     loadData(true);
          //
          //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
          //   }
          // }
        });
      // }
    // });
  }


  int compareVersions(String version1, String version2) {
    List<String> v1Components = version1.split('.');
    List<String> v2Components = version2.split('.');
    for (int i = 0; i < v1Components.length; i++) {
      int v1Part = int.parse(v1Components[i]);
      int v2Part = int.parse(v2Components[i]);
      if (v1Part > v2Part) {
        return 1;
      } else if (v1Part < v2Part) {
        return -1;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      key: _globalKey,
      body: Provider.of<SplashController>(context).hasConnection ?
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Theme.of(context).primaryColor,Colors.black.withOpacity(0.99)],
              begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter
              )
            ),
            child: Center(child: Image.asset(Images.whiteLogoWithMame,width: 180,height: 100,)),
          )
      // Stack( children: [
      //   // Positioned(
      //   //     top: 0,
      //   //     left: 0,
      //   //     child: Image.asset(Images.yellowCircle, width: 500, height: 500,)),
      //   // Positioned(
      //   //     bottom: 0,
      //   //     left: 0,
      //   //     child: Image.asset(Images.porpoleCircle,
      //   //     width: 500,
      //   //
      //   //     height: 500,)),
      //   // Center(child: Image.asset(Images.logoWithNameImage,width: MediaQuery.of(context).size.width/1.5,))
      //   // BouncyWidget(
      //   //     duration: const Duration(milliseconds: 2000), lift: 50, ratio: 0.5, pause: 0.25,
      //   //     child: SizedBox(width: 150, child: Image.asset(Images.icon, width: 150.0))),
      //   // Text(AppConstants.appName,style: textRegular.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),
      //   // Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      //   //     child: Text(AppConstants.slogan,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white)))
      //       ])
          : const NoInternetOrDataScreenWidget(isNoInternet: true, child: SplashScreen()),
    );
  }
}
