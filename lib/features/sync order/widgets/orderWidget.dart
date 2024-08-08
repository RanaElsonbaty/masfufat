import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/Sync_order_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

import '../screens/sync_orde_details.dart';


class SyncOrderWidget extends StatelessWidget {
  final SyncOrderModel? orderModel;
  const SyncOrderWidget({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {

    double orderAmount = 0;

    if(orderModel?.orderType == 'POS') {
      // if (orderModel != null) {
      // for (var orderDetails in orderModel!) {

      //
      //   }
      if(orderModel!.orderType == 'POS'){
        if(orderModel!.extraDiscountType == 'percent'){
        }else{
        }
      }
      // }
      // double subTotal = itemsPrice +tax - discount;

      orderAmount = orderModel!.orderAmount!;




      // double ? _extraDiscountAnount = 0;
      // if(orderModel.extraDiscount != null){
      //   _extraDiscountAnount = PriceConverter.convertWithDiscount(context, orderModel.totalProductPrice, orderModel.extraDiscount, orderModel.extraDiscountType == 'percent' ? 'percent' : 'amount' );
      //   if(_extraDiscountAnount != null) {
      //     double percentAmount = _extraDiscountAnount!;
      //     _extraDiscountAnount = orderModel.totalProductPrice! - percentAmount;
      //   }
      // }
      //
      // double totalDiscount = (_extraDiscountAnount! + orderModel.totalProductDiscount!);
      // double totalOrderAmount = (orderModel.totalProductPrice! + orderModel.totalTaxAmount!);
      //
      // orderAmount = totalOrderAmount - totalDiscount;
      //
      // orderAmount = orderModel.orderAmount! - orderModel.totalTaxAmount!;


    }



    return InkWell(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderSyncDetailsScreen(orderId: orderModel!.id,syncOrder: orderModel,)));},

      child: Stack(children: [
        Container(margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,
            left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow:  [BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),

          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // SizedBox(width: 82,height: 82,
              //   child: Column(children: [
              //     // Container(decoration: BoxDecoration(color: Theme.of(context).cardColor,
              //     //   borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              //     //   border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(.25)),
              //     //   boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme? null :[BoxShadow(color: Colors.grey.withOpacity(.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))],),
              //     //
              //     //   child: ClipRRect(
              //     //     borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
              //     //     child: CustomImageWidget(
              //     //       placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 70, height: 70,
              //     //       // image: orderModel?.sellerIs == 'admin' ? Provider.of<SplashController>(context, listen: false).configModel!.companyFavIcon?.path ?? '' : '${orderModel?.seller?}',
              //     //       ))
              //     //   ,),
              //   ]),),
              const SizedBox(width: Dimensions.paddingSizeLarge),



              Expanded(flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text('${getTranslated('order', context)!}# ${orderModel!.id.toString()}',
                          style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.bold)))]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text(DateConverter.localDateToIsoStringAMPMOrder(orderModel!.createdAt!),
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text(PriceConverter.convertPrice(context, orderModel!.orderType == 'POS' ? orderAmount : orderModel!.orderAmount),
                      style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getPrimary(context)),),])),



              Container(alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      color: orderModel!.orderStatus == 'delivered'? ColorResources.getGreen(context).withOpacity(.10) :
                      orderModel!.orderStatus == 'pending'? Theme.of(context).primaryColor.withOpacity(.10) :
                      orderModel!.orderStatus == 'confirmed'? ColorResources.getGreen(context).withOpacity(.10)
                          :orderModel!.orderStatus == 'processing'? ColorResources.getPurple(context).withOpacity(.10):
                      orderModel!.orderStatus == 'canceled'? ColorResources.getRed(context).withOpacity(.10):
                      ColorResources.getYellow(context).withOpacity(.1), borderRadius: BorderRadius.circular(50)),

                  child: Text(getTranslated('${orderModel!.orderStatus}', context)??'',
                      style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall, fontWeight: FontWeight.w500,
                          color: orderModel!.orderStatus == 'delivered'?  ColorResources.getGreen(context) :
                          orderModel!.orderStatus == 'pending'? Theme.of(context).primaryColor :
                          orderModel!.orderStatus == 'confirmed'? ColorResources.getGreen(context)
                              :orderModel!.orderStatus == 'processing'? ColorResources.getPurple(context) :
                          (orderModel!.orderStatus == 'canceled' || orderModel!.orderStatus == "failed")? ColorResources.getRed(context) :
                          ColorResources.getYellow(context)))),

            ]),
          ),
        ),

        // Positioned(top: 2, left: Provider.of<LocalizationController>(context, listen: false).isLtr? 90 : MediaQuery.of(context).size.width-50, child: Container(
        //   height: 22,
        //   width: 22,
        //   padding: const EdgeInsets.all(3),
        //   decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        //   child: FittedBox(child: Text(
        //     "orderDetailsCount",
        //     style: textRegular.copyWith(color: Colors.white),
        //     textAlign: TextAlign.center,
        //   )),
        // )),
      ],
      ),
    );
  }
}
