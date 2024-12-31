import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/controllers/store_setting_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/cart_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import '../../../main.dart';
import '../../cart/domain/models/cart_model.dart';

class BottomCartWidget extends StatefulWidget {
  final ProductDetailsModel? product;
  const BottomCartWidget({super.key, required this.product});

  @override
  State<BottomCartWidget> createState() => _BottomCartWidgetState();
}

class _BottomCartWidgetState extends State<BottomCartWidget> {
  bool vacationIsOn = false;
  bool temporaryClose = false;
bool sync =false;

  @override
  void initState() {

    super.initState();

    final today = DateTime.now();


    //
  try{
    if(widget.product!.addedBy!=null&&widget.product!.addedBy == 'admin'){



      // if(difference >= 0 && (Provider.of<SplashController>(context, listen: false).configModel?.inhouseVacationAdd?.status == 1) && startDate <= 0){
      vacationIsOn = true;
      // } else{
      //   vacationIsOn = false;
      // }

    }
    else if(widget.product != null && widget.product!.seller != null&&widget.product!.seller!.shop!=null && widget.product!.seller!.shop!.vacationEndDate != null){
      DateTime vacationDate = DateTime.parse(widget.product!.seller!.shop!.vacationEndDate!);
      DateTime vacationStartDate = DateTime.parse(widget.product!.seller!.shop!.vacationStartDate!);
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if(difference >= 0 && widget.product!.seller!.shop!.vacationStatus==1 && startDate <= 0){
        vacationIsOn = true;
      }

      else{
        vacationIsOn = false;
      }
    }


    if(widget.product!.addedBy == 'admin'){
      temporaryClose = false;
    } else {
      if(widget.product != null && widget.product!.seller != null && widget.product!.seller!.shop != null && widget.product!.seller!.shop!.temporaryClose==1){
        temporaryClose = true;
      }else{
        temporaryClose = false;
      }
    }
  }catch(e){}
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder:(context, cartProvider, child) {
        bool inCart=false;
        if(widget.product!=null){
        for (var element in cartProvider.cartList) {
          if(element.product!.id==widget.product!.id){
            inCart=true;
          }
        }
        }
        return Container(height: 80,
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault+3),
        decoration: BoxDecoration(color: Theme.of(context).highlightColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [BoxShadow(color: Theme.of(context).hintColor, blurRadius: .5, spreadRadius: .1)]),
        child: Row(children: [
          Expanded(
              flex: 1,
              child: InkWell(onTap: ()async {
                HapticFeedback.heavyImpact();

                vibrate();
                Vibration.cancel();
               try{
                 if(widget.product!.id==null){
                   showCustomSnackBar(getTranslated('The_product_was_not_added_to_the_cart_successfully', context), context);
                   return ;
                 }
                 if(inCart){
                   if(cartProvider.cartList.isEmpty){
                     await cartProvider.getCartData(context);
                     cartProvider.setCartData();
                   }
                   CartModel? cartItem;
                   int index= 0;
                   for (int i=0;i<cartProvider.cartList.length;i++) {
                     if(cartProvider.cartList[i].product!.id == widget.product!.id){
                       index =i;
                       cartItem=cartProvider.cartList[i];
                       if(widget.product!.currentStock!=cartItem.quantity){

                         cartProvider.updateCartProductQuantity(cartItem.id, cartItem.quantity!+1, context, true, index);
                       }else{
                         showCustomSnackBar(getTranslated('out_of_stock', context), context);

                       }


                     }
                   }


                   // showCustomSnackBar(getTranslated('Already_added', context), context);
                 }else
                 if(widget.product!.currentStock==0){
                   showCustomSnackBar(getTranslated('Out_of_stock', context), context);
                 }else{

                   if(vacationIsOn || temporaryClose ){
                     showCustomSnackBar(getTranslated('this_shop_is_close_now', context), context, isToaster: true);
                   }else{
                     showModalBottomSheet(context: context, isScrollControlled: true,
                         backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
                         builder: (con) => CartBottomSheetWidget(product: widget.product, callback: (){
                           showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                         },));
                   }
                 }
               }catch(e){
                 showCustomSnackBar(getTranslated('The_product_was_not_added_to_the_cart_successfully', context), context);

               }
             },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                      color:inCart?Theme.of(context).primaryColor: Theme.of(context).primaryColor.withOpacity(.20)),
                  child: Text(inCart?getTranslated('Added_to_cart', context)!:getTranslated('buy', context)!,
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: inCart?Colors.white:Colors.black),),
                ),
              )),
          if(Provider.of<StoreSettingController>(Get.context!,listen: false).showStoreSetting==true)

          Expanded(child: Consumer<MyShopController>(
            builder:(context, myShopController, child) {
              bool  sync=false;
              bool  linked=false;

              if(widget.product!=null){
              for (var element in myShopController.pendingList) {
                if(element.id==widget.product!.id){
                  sync=true;
                }
              } for (var element in myShopController.deleteList) {
                if(element.id==widget.product!.id){
                  sync=true;
                }
              } for (var element in myShopController.linkedList) {
                if(element.id==widget.product!.id){
                  linked
                  =true;
                }
              }
              }
              return Consumer<StoreSettingController>(
                builder:(context, storeSetting, child) =>  InkWell(onTap: () {
                  HapticFeedback.heavyImpact();

                  vibrate();
                  Vibration.cancel();

                try{

                  if(widget.product!.currentStock==0){
                    showCustomSnackBar(getTranslated('Out_of_stock', context), context);

                  }else if(!sync){
                    if(widget.product!.id==null){
                      showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
                      return ;
                    }
                    myShopController.addProduct(widget.product!.id!).then((value) {
                      if(value==true){
                        showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);
                        myShopController.getList();
                      }else{
                        showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
                PriceConverter.convertPrice(context, 0);
                      }
                    });}else{
                    showCustomSnackBar(getTranslated('Already_added', context), context,isError: true );
                  }
                }catch(e){
                  if(widget.product!.currentStock==0){
                    showCustomSnackBar(getTranslated('Out_of_stock', context), context);

                  }else if(!sync){
                    if(widget.product!.id==null){
                      showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
                      return ;
                    }
                    myShopController.addProduct(widget.product!.id!).then((value) {
                      if(value==true){
                        showCustomSnackBar(getTranslated('Added_to_my_store', context), context,isError: false);
                        myShopController.getList();
                      }else{
                        showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );

                      }
                    });}else{
                    showCustomSnackBar(getTranslated('Not_added_to_my_store', context), context,isError: true );
                  }

                  }
                            },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
                      color:linked?Colors.green:sync?Colors.grey.shade500:  Theme.of(context).primaryColor),
                  child: Text(linked?getTranslated('synced', context)!:sync?getTranslated('Addedd_to_my_store', context)!:getTranslated('sync', context)!,
                    style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: sync?Colors.white:Colors.white),),
                ),
                            ),
              );
            },
          )),



        ]),
      );
      },
    );
  }
  Future<bool>
  vibrate() async {
    if (await Vibration
        .hasVibrator() ==
        true) {
      print('vibrate');
      // Vibration.vibrate();
      Vibration.vibrate(
          pattern: [
            1000,
            500,
          ]);
      return Future(() => true);
    } else {
      print('cannot vibrate');

      return Future(
              () => false);
    }
  }
}
