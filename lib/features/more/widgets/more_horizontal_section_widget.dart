import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/screens/wallet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';

import '../../../theme/controllers/theme_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../wallet/widgets/wallet_card_widget.dart';

class MoreHorizontalSection extends StatefulWidget {
  const MoreHorizontalSection({super.key});

  @override
  State<MoreHorizontalSection> createState() => _MoreHorizontalSectionState();
}

class _MoreHorizontalSectionState extends State<MoreHorizontalSection> {
  JustTheController tooltipController = JustTheController();

   TextEditingController inputAmountController = TextEditingController(text: '1');

   FocusNode focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileController>(
      builder: (context, profileProvider,_) {
        return SizedBox(height: ResponsiveHelper.isTab(context)? 135 :130,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: ListView(scrollDirection:Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), children: [
                     // if(Provider.of<SplashController>(context, listen: false).configModel!.activeTheme != "theme_fashion")
                     //  SquareButtonWidget(image: Images.offerIcon, title: getTranslated('offers', context),
                     //    navigateTo: const OfferProductListScreen(),count: 0,hasCount: false,),

                      if(!isGuestMode && Provider.of<SplashController>(context,listen: false).configModel!=null&&Provider.of<SplashController>(context,listen: false).configModel!.walletStatus == 1)
                        // SquareButtonWidget(image: Images.walletIcon, title: getTranslated('wallet', context),
                        //     navigateTo: const WalletScreen(),count: 1,hasCount: false,
                        //     subTitle: getTranslated('wallet', context), isWallet: true, balance: profileProvider.balance),
                        //
                        Consumer<WalletController>(builder: (context, walletP,_) {
                          return Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen(),));
                                },
                                child: Container(height: MediaQuery.of(context).size.width/3.0,
                                  width: MediaQuery.of(context).size.width-30,
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                  Theme.of(context).cardColor : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                      boxShadow: [BoxShadow(color: Colors.grey[ 200]!, spreadRadius: 0.5, blurRadius: 0.3)]),
                                  child: WalletCardWidget(tooltipController: tooltipController, focusNode: focusNode,
                                      inputAmountController: inputAmountController),),
                              ));}),


                    // if(!isGuestMode && Provider.of<SplashController>(context,listen: false).configModel!=null&& Provider.of<SplashController>(context,listen: false).configModel!.loyaltyPointStatus == 1)
                    //     SquareButtonWidget(image: Images.loyaltyPoint, title: getTranslated('loyalty_point', context),
                    //       navigateTo: const LoyaltyPointScreen(),count: 1,hasCount: false,isWallet: true,subTitle: 'point',
                    //       balance: profileProvider.loyaltyPoint, isLoyalty: true),


                      // if(!isGuestMode)
                      // Consumer<OrderController>(
                      //   builder:(context, order, child) =>  SquareButtonWidget(image: Images.shoppingIcon2, title: getTranslated('orders', context),
                      //     navigateTo: const OrderPageBuilder(isBacButtonExist: true,),count: 1,hasCount: false,isWallet: true,subTitle: 'orders',
                      //     balance: double.tryParse(order.orderModel!.length.toString()), isLoyalty: true),
                      // ),

                      // SquareButtonWidget(image: Images.cartImage, title: getTranslated('cart', context),
                      //   subTitle:  getTranslated('cart', context),
                      //   navigateTo: const CartScreen(),
                      //   isLoyalty: true,
                      //   balance: double.tryParse(Provider.of<CartController>(context,listen: false).cartList.length.toString()),
                      //   count: Provider.of<CartController>(context,listen: false).cartList.length, hasCount: true,),
                    //
                    // Consumer<WishListController>(builder: (context, wishListController, _) {
                    //   return SquareButtonWidget(
                    //     image: Images.wishlist, title: getTranslated('wishlist', context),
                    //     navigateTo: const WishListScreen(),
                    //     subTitle: getTranslated('wishlist', context),
                    //     isLoyalty: true,
                    //     balance: double.tryParse( wishListController.wishList?.length.toString()??'0'),
                    //     count: wishListController.wishList?.length ?? 0,
                    //     hasCount: (!isGuestMode  && (wishListController.wishList?.length ?? 0) > 0),
                    //   );
                    // }),

                    ]),
            ),
          ),
        );
      }
    );
  }
}
