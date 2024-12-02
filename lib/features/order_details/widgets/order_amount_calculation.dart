import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/amount_widget.dart';

class OrderAmountCalculation extends StatelessWidget {
  final double itemTotalAmount;
  final double discount;
  final double? eeDiscount;
  final double tax;
  final double shippingCost;
  final OrderDetailsController orderProvider;
  const OrderAmountCalculation({super.key, required this.itemTotalAmount, required this.discount, this.eeDiscount, required this.tax, required this.shippingCost, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return  Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        color: Theme.of(context).highlightColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          AmountWidget(title: getTranslated('Total_does_not_include_tax', context),
              amount: PriceConverter.convertPrice(context, itemTotalAmount)),
          const SizedBox(height: 5,),

           Divider(color: Colors.grey.shade300,height: 10,),
          const SizedBox(height: 5,),

          orderProvider.orders!.orderType == "POS"? const SizedBox():
          AmountWidget(title: getTranslated('Shipping_cost', context),
              amount: PriceConverter.convertPrice(context, shippingCost)),
          const SizedBox(height: 5,),

 Divider(color: Colors.grey.shade300,height: 10,),
          const SizedBox(height: 5,),

          AmountWidget(title: getTranslated('Product_discount', context),
              amount: PriceConverter.convertPrice(context, discount)),
           Divider(color: Colors.grey.shade300,height: 10,),

          const SizedBox(height: 5,),

          // orderProvider.orders!.orderType == "POS"?
          // AmountWidget(title: getTranslated('Basket_discount', context),
          //     amount: PriceConverter.convertPrice(context, eeDiscount)):const SizedBox(),
          // orderProvider.orders!.orderType == "POS"?
          //  Divider(color: Colors.grey.shade300,height: 10,):const SizedBox(),

          // SizedBox(height:   orderProvider.orders!.orderType == "POS"?5:0,),

          AmountWidget(title: getTranslated('Basket_discount', context),
            amount: PriceConverter.convertPrice(context, orderProvider.orders!.discountAmount),),
          const SizedBox(height: 5,),

           Divider(color: Colors.grey.shade300,height: 10,),
          const SizedBox(height: 5,),

          AmountWidget(title: getTranslated('Product_tax', context),
              amount: PriceConverter.convertPrice(context, tax)),
          Divider(color: Colors.grey.shade300,height: 10,),
          const SizedBox(height: 5,),
   AmountWidget(title: getTranslated('Shipping_tax', context),
              amount: PriceConverter.convertPrice(context, (shippingCost*0.15))),

          const SizedBox(height: 5,),

           Divider(height: 2, color:Colors.grey.shade300),
const SizedBox(height: 5,),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AmountWidget(title: getTranslated('Total', context),
                amount: PriceConverter.convertPrice(context, (itemTotalAmount + shippingCost - eeDiscount! - orderProvider.orders!.discountAmount - discount  + tax+(shippingCost*0.15))),),
            ),
          ),]));
  }
}
