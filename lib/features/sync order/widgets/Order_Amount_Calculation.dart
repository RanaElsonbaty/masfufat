import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/amount_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SyncOrderAmountCalculation extends StatelessWidget {
  final double itemTotalAmount;
  final double discount;
  final double? eeDiscount;
  final double tax;
  final double shippingCost;

  final SyncOrderController orderProvider;
  const SyncOrderAmountCalculation({super.key, required this.itemTotalAmount, required this.discount, this.eeDiscount, required this.tax, required this.shippingCost, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return  Container(
        // padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        color: Theme.of(context).highlightColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('sub_total', context),
                amount: PriceConverter.convertPrice(context, itemTotalAmount)),
          ),

          const Divider(height: 1, color: Color(0xFFD8D8D8)),

          orderProvider.syncOrderDetails!.orderType == "POS"? const SizedBox():
          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('shipping_fee', context),
                amount: PriceConverter.convertPrice(context, shippingCost)),
          ),

          const Divider(height: 1, color: Color(0xFFD8D8D8)),


          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('discount', context),
                amount: PriceConverter.convertPrice(context, discount)),
          ),


          const Divider(height: 1, color: Color(0xFFD8D8D8)),

          orderProvider.syncOrderDetails!.orderType == "POS"?
          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('extra_discount', context),
                amount: PriceConverter.convertPrice(context, eeDiscount)),
          ):const SizedBox(),

          orderProvider.syncOrderDetails!.orderType == "POS"? const Divider(height: 1, color: Color(0xFFD8D8D8)):const SizedBox.shrink(),


          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('coupon_voucher', context),
              amount: PriceConverter.convertPrice(context, discount),),
          ),

          const Divider(height: 1, color: Color(0xFFD8D8D8)),


          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('tax', context),
                amount: PriceConverter.convertPrice(context, tax)),
          ),

          const Divider(height: 1, color: Color(0xFFD8D8D8)),

          Padding(
            padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: AmountWidget(title: getTranslated('Shipping_tax', context),
                amount: PriceConverter.convertPrice(context, shippingCost*0.15  )),
          ),

          const Divider(height: 1, color: Color(0xFFD8D8D8)),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
            child: Container(
              // height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor
              ),
              child: Padding(
                padding:  const EdgeInsets.all(Dimensions.paddingSizeSmall),

                child: Row(children: [
                  Text( getTranslated('total_payable', context)!,
                    style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color!,fontWeight: FontWeight.w400,),
                  ),
                  const Spacer(),
                  Text(PriceConverter.convertPrice(context, (itemTotalAmount + shippingCost - eeDiscount! -  discount  + tax+(shippingCost*0.15))),
                    style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400,),
                  )
                ],),
              ),
            ),
          ),
          // AmountWidget(title: getTranslated('total_payable', context),
          //   amount: PriceConverter.convertPrice(context, (itemTotalAmount + shippingCost - eeDiscount! -  discount  + tax+(shippingCost*0.15))),),
        ]));
  }
}
