
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/domain/models/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/shipping/controllers/shipping_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/widgets/cart_page_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/widgets/cart_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shipping/widgets/shipping_method_bottom_sheet_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../checkout/widgets/coupon_apply_widget.dart';
import '../widgets/cart_bill.dart';

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;
  final bool showBackButton;
  const CartScreen({super.key, this.fromCheckout = false, this.sellerId = 1, this.showBackButton = true});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  Future<void> _loadData() async{
    await Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
    Provider.of<CartController>(Get.context!, listen: false).setCartData();
    if( Provider.of<SplashController>(Get.context!,listen: false).configModel!.shippingMethod != 'sellerwise_shipping'){
      Provider.of<ShippingController>(Get.context!, listen: false).getAdminShippingMethodList(Get.context!);
    }
  }
  final TextEditingController _controller = TextEditingController();

  Color _currentColor = Theme.of(Get.context!).cardColor; // Initial color
  final Duration duration = const Duration(milliseconds: 500);
  void changeColor() {
    setState(() {
      _currentColor = (_currentColor == Theme.of(Get.context!).cardColor) ? Colors.grey.withOpacity(.15) : Theme.of(Get.context!).cardColor;
      Future.delayed(const Duration(milliseconds: 500)).then((value){
        reBackColor();
      });
    });
  }

  void reBackColor() {
    setState(() {
      _currentColor = (_currentColor == Theme.of(Get.context!).cardColor) ? Colors.grey.withOpacity(.15) : Theme.of(Get.context!).cardColor;
    });
  }


  @override
  void initState() {
    _loadData();
    super.initState();
  }
  final tooltipController = JustTheController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
        builder: (context, configProvider,_) {
          return Consumer<ShippingController>(
              builder: (context, shippingController,_) {
                return Consumer<CartController>(builder: (context, cart, child) {
                  double amount = 0.0;
                  bool onlyDigital= true;
                  List<String?> orderTypeShipping = [];
                  List<String?> sellerList = [];
                  List<List<String>> productType = [];
                  List<CartModel> sellerGroupList = [];
                  List<List<CartModel>> cartProductList = [];
                  List<List<int>> cartProductIndexList = [];
                  List<CartModel> cartList = [];
                 try{

                   cartList.addAll(cart.cartList);

                   for(CartModel cart in cartList) {
                     if(cart.productType == "physical" ){
                       onlyDigital = false;
                     }
                   }


                   for(CartModel cart in cartList) {
                     // if() {
                     // }
                     if(!sellerList.contains(cart.cartGroupId)) {
                       sellerList.add(cart.cartGroupId);
                       cart.isGroupChecked = false;
                       sellerGroupList.add(cart);
                     }
                   }



                   for(CartModel? seller in sellerGroupList) {
                     List<CartModel> cartLists = [];
                     List<int> indexList = [];
                     List<String> productTypeList = [];
                     bool isSellerChecked = true;
                     for(CartModel cart in cartList) {
                       if(seller?.cartGroupId == cart.cartGroupId) {
                         cartLists.add(cart);
                         indexList.add(cartList.indexOf(cart));
                         productTypeList.add(cart.productType!);
                         // if(!cart.isChecked!){
                         isSellerChecked = false;
                       } else if (cart.isChecked!) {
                         seller?.isGroupItemChecked = true;
                         // }
                       }
                     }

                     cartProductList.add(cartLists);
                     productType.add(productTypeList);
                     cartProductIndexList.add(indexList);
                     if(isSellerChecked){
                       seller?.isGroupChecked = true;
                     }
                   }

                   for (var seller in sellerGroupList) {
                     if(seller.freeDeliveryOrderAmount?.status == 1 && seller.isGroupItemChecked!){
                     }
                     if(seller.shippingType == 'order_wise'){
                       orderTypeShipping.add(seller.shippingType);
                     }
                   }



                   for(int i=0;i<cart.cartList.length;i++){
                     amount += (cart.cartList[i].price! - cart.cartList[i].discount!) * cart.cartList[i].quantity!;

                   }



                 }catch(e){

                 }
                  return Scaffold(



                    appBar: CustomAppBar(title: getTranslated('my_cart', context), isBackButtonExist: widget.showBackButton),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        if(Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
                          await Provider.of<CartController>(context, listen: false).getCartData(context);
                        }
                      },
                      child: SingleChildScrollView(
                        child: cart.cartLoading ? const CartPageShimmerWidget() :sellerList.isNotEmpty ?
                        Column(children: [

                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sellerList.length??0,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              bool hasPhysical = false;
                              // for(var cart in cartProductList[index]) {
                              // }

                             try{
                               for(CartModel cart in cartProductList[index]) {
                                 if(cart.productType == 'physical' && cart.isChecked!) {
                                   hasPhysical = true;
                                   break;
                                 }
                               }
                             }catch(e){

                             }




                              return AnimatedContainer(
                                // color: ( (configProvider.configModel!.shippingMethod =='sellerwise_shipping' &&
                                //     sellerGroupList[index].shippingType == 'order_wise' && Provider.of<ShippingController>(context, listen: false).shippingList!=null&&Provider.of<ShippingController>(context, listen: false).shippingList![index].shippingIndex == -1 && sellerGroupList[index].isGroupItemChecked == true)) ? _currentColor :
                                // index.floor().isOdd? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).canvasColor,

                                duration: duration,
                                child: Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    sellerGroupList[index].shopInfo!.isNotEmpty ?

                                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                      child: Row( children: [
                                        Expanded(
                                          flex: 11,
                                            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                                child: Row(children: [

                                                  Expanded(
                                                    child: Text('${sellerGroupList[index].shopInfo!??''} (${cartProductList[index].length??''})', maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.start, style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,
                                                          fontWeight: FontWeight.w500,
                                                          // color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                                          // Theme.of(context).hintColor : Theme.of(context).primaryColor
                                                      )),
                                                  ),

                                                  // if(shopClose)
                                                  //   JustTheTooltip(
                                                  //     backgroundColor: Colors.black87,
                                                  //     controller: tooltipController,
                                                  //     preferredDirection: AxisDirection.down,
                                                  //     tailLength: 10,
                                                  //     tailBaseWidth: 20,
                                                  //     content: Container(width: 150,
                                                  //         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                  //         child: Text(getTranslated('store_is_closed', context)!,
                                                  //             style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault))),
                                                  //     child: InkWell(onTap: ()=>  tooltipController.showTooltip(),
                                                  //       child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                                  //         child: SizedBox(width: 30, child: Image.asset(Images.warning, color: Theme.of(context).colorScheme.error,)),
                                                  //       ),
                                                  //     ),
                                                  //   )


                                                ]))),

                                        configProvider.configModel!=null&&   configProvider.configModel!.shippingMethod =='sellerwise_shipping' &&
                                            sellerGroupList[index].shippingType == 'order_wise' && hasPhysical ?SizedBox(width: 200, child: configProvider.configModel!.shippingMethod =='sellerwise_shipping' &&
                                            sellerGroupList[index].shippingType == 'order_wise' && hasPhysical ?

                                        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                          child: InkWell(onTap: () {
                                            showModalBottomSheet(
                                              context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                              builder: (context) => ShippingMethodBottomSheetWidget(groupId: sellerGroupList[index].cartGroupId??'',
                                                  sellerIndex: index, sellerId: sellerGroupList[index].id??0),
                                            );
                                          },
                                            child: Container(decoration: BoxDecoration(
                                                border: Border.all(width: 0.5,color: Colors.grey),
                                                borderRadius: const BorderRadius.all(Radius.circular(10))),
                                              child: Padding(padding: const EdgeInsets.all(8.0),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                  if(shippingController.shippingList == null || shippingController.shippingList!.isEmpty || shippingController.shippingList?[index].shippingMethodList == null ||
                                                      shippingController.chosenShippingList.isEmpty || shippingController.shippingList![index].shippingIndex == -1)

                                                    Row(children: [
                                                      SizedBox(width: 15,height: 15, child: Image.asset(Images.delivery,color: Theme.of(context).textTheme.bodyLarge?.color)),
                                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                                      Text(getTranslated('choose_shipping', context)!, style: textRegular, overflow: TextOverflow.ellipsis,maxLines: 1,),]),

                                                  Flexible(child: Text((shippingController.shippingList == null ||
                                                      shippingController.shippingList![index].shippingMethodList == null ||
                                                      shippingController.chosenShippingList.isEmpty ||
                                                      shippingController.shippingList![index].shippingIndex == -1) ? ''
                                                      : shippingController.shippingList![index].shippingMethodList![shippingController.shippingList![index].shippingIndex!].title.toString(),
                                                      style: titilliumSemiBold.copyWith(color: Theme.of(context).hintColor),
                                                      maxLines: 1, overflow: TextOverflow.ellipsis,textAlign: TextAlign.end)),
                                                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                                                ]),
                                              ),
                                            ),
                                          ),
                                        ) : const SizedBox()
                                          ,):const SizedBox.square()
                                      ],
                                      ),
                                    ) : const SizedBox(),

                                    // if(sellerGroupList[index].minimumOrderAmountInfo!> totalCost)
                                    // Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                                    //   child: Text('${getTranslated('minimum_order_amount_is', context)} '
                                    //       '${PriceConverter.convertPrice(context, sellerGroupList[index].minimumOrderAmountInfo)}',
                                    //     style: textRegular.copyWith(color: Theme.of(context).colorScheme.error),),),

                                    if(configProvider.configModel!=null&&configProvider.configModel!.shippingMethod == 'sellerwise_shipping' && sellerGroupList[index].shippingType == 'order_wise' && hasPhysical)
                                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                        child: (shippingController.shippingList == null ||
                                            shippingController.shippingList![index].shippingMethodList == null ||
                                            shippingController.chosenShippingList.isEmpty ||
                                            shippingController.shippingList![index].shippingIndex == -1)?const SizedBox():
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Row(children: [
                                            Text((shippingController.shippingList == null ||
                                                shippingController.shippingList![index].shippingMethodList == null ||
                                                shippingController.chosenShippingList.isEmpty ||
                                                shippingController.shippingList![index].shippingIndex == -1) ? '':
                                            '${getTranslated('shipping_cost', context)??''} : ', style: textRegular,),

                                            Text((shippingController.shippingList == null ||
                                                shippingController.shippingList![index].shippingMethodList == null ||
                                                shippingController.chosenShippingList.isEmpty ||
                                                shippingController.shippingList![index].shippingIndex == -1) ? ''
                                                : PriceConverter.convertPrice(context,
                                                shippingController.shippingList![index].shippingMethodList![shippingController.shippingList![index].shippingIndex!].cost),
                                                style: textBold.copyWith(),
                                                maxLines: 1, overflow: TextOverflow.ellipsis,textAlign: TextAlign.end),
                                          ],
                                          ),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                          Row(children: [
                                            Text((shippingController.shippingList == null ||
                                                shippingController.shippingList![index].shippingMethodList == null ||
                                                shippingController.chosenShippingList.isEmpty ||
                                                shippingController.shippingList![index].shippingIndex == -1) ? '':
                                            '${getTranslated('shipping_time', context)??''} : ',style: textRegular,),
                                            Text((shippingController.shippingList == null ||
                                                shippingController.shippingList![index].shippingMethodList == null ||
                                                shippingController.chosenShippingList.isEmpty ||
                                                shippingController.shippingList![index].shippingIndex == -1) ? ''
                                                : '${shippingController.shippingList![index].shippingMethodList![shippingController.shippingList![index].shippingIndex!].duration.toString()} '
                                                '${getTranslated('days', context)}',
                                                style: textBold.copyWith(),
                                                maxLines: 1, overflow: TextOverflow.ellipsis,textAlign: TextAlign.end)
                                          ],
                                          ),

                                        ],),
                                      ),



                                    Column(children: [
                                      ListView.builder(physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        itemCount: cartProductList[index].length??0,
                                        itemBuilder: (context, i) {
                                          return CartWidget(cartModel: cartProductList[index][i],
                                            index: cartProductIndexList[index][i],
                                            fromCheckout: widget.fromCheckout??false,
                                          );
                                        },
                                      ),

                                    ],
                                    ),

                                    if(sellerGroupList.isNotEmpty&&sellerGroupList[index].freeDeliveryOrderAmount?.status == 1 && hasPhysical && sellerGroupList[index].isGroupItemChecked!)
                                      Padding(padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeDefault,
                                          right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall),
                                        child: Row(children: [
                                          SizedBox(height: 16, child: Image.asset(Images.freeShipping,
                                            color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                            Theme.of(context).hintColor: Theme.of(context).primaryColor,)),
                                          if(sellerGroupList[index].freeDeliveryOrderAmount!.amountNeed! > 0)
                                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                              child: Text(PriceConverter.convertPrice(context, sellerGroupList[index].freeDeliveryOrderAmount!.amountNeed!),
                                                  style: textMedium.copyWith(color: Theme.of(context).primaryColor)),),
                                          sellerGroupList[index].freeDeliveryOrderAmount!.percentage! < 100?
                                          Text('${getTranslated('add_more_for_free_delivery', context)}', style: textMedium.copyWith(color: Theme.of(context).hintColor)):
                                          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                            child: Text('${getTranslated('you_got_free_delivery', context)}', style: textMedium.copyWith(color: Colors.green)),
                                          )
                                        ],),
                                      ),
                                    if(sellerGroupList.isNotEmpty&&sellerGroupList[index].freeDeliveryOrderAmount?.status == 1 && hasPhysical && sellerGroupList[index].isGroupItemChecked!)
                                      Padding(padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,0,Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          barRadius: const Radius.circular(Dimensions.paddingSizeDefault),
                                          width: MediaQuery.of(context).size.width - 40,
                                          lineHeight: 4.0,
                                          percent: sellerGroupList[index].freeDeliveryOrderAmount!.percentage! / 100,
                                          backgroundColor: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                          Theme.of(context).primaryColor.withOpacity(.5):Theme.of(context).primaryColor.withOpacity(.2),
                                          progressColor: (sellerGroupList[index].freeDeliveryOrderAmount!.percentage! < 100 &&
                                              !Provider.of<ThemeController>(context, listen: false).darkTheme)?
                                          Theme.of(context).colorScheme.onSecondary : Colors.green,
                                        ),
                                      ),


                                  ]),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10,),
                          // if(Provider.of<AuthController>(context, listen: false).isLoggedIn())
                          Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                              child: CouponApplyWidget(couponController: _controller, orderAmount: amount)),
                          const SizedBox(height: 10,),
                          ( !onlyDigital && configProvider.configModel!=null&&configProvider.configModel!.shippingMethod != 'sellerwise_shipping' && configProvider.configModel!.inhouseSelectedShippingType =='order_wise')?
                          InkWell(onTap: () {showModalBottomSheet(
                              context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                              builder: (context) => const ShippingMethodBottomSheetWidget(groupId: 'all_cart_group',sellerIndex: 0, sellerId: 1));},
                            child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                              child: Container(decoration: BoxDecoration(
                                  border: Border.all(width: 0.5, color: Colors.grey),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                                child: Padding(padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                    Row(children: [
                                      // SizedBox(width: 15,height: 15, child: Image.asset(Images.delivery, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                      Text(getTranslated('choose_shipping', context)!, style: textRegular, overflow: TextOverflow.ellipsis,maxLines: 1,),]),

                                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                      Text((shippingController.shippingList == null ||shippingController.chosenShippingList.isEmpty ||
                                          shippingController.shippingList!.isEmpty || shippingController.shippingList![0].shippingMethodList == null ||
                                          shippingController.shippingList![0].shippingIndex == -1) ? ''
                                          : shippingController.shippingList![0].shippingMethodList![shippingController.shippingList![0].shippingIndex!].title.toString(),
                                        style: titilliumSemiBold.copyWith(color: Theme.of(context).hintColor),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                      Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                                    ]),
                                  ]),
                                ),
                              ),
                            ),
                          ):const SizedBox(),
                          const SizedBox(height: 10,),

                          CartBill( cartList: cartList,),



                        ],
                        ) : NoInternetOrDataScreenWidget(icon: Images.emptyCart, icCart: true,
                          isNoInternet: false, message: 'no_product_in_cart',),
                      ),
                    ),
                  );
                });
              }
          );
        }
    );
  }
}