import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingInfoWidget extends StatelessWidget {
  final OrderDetailsController? order;
  const ShippingInfoWidget({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${getTranslated('shipping_info', context)}', style: GoogleFonts.tajawal(
              fontSize: 16,fontWeight: FontWeight.w500
            )),
            const SizedBox(height: Dimensions.marginSizeExtraSmall),
Card(
  color: Theme.of(context).cardColor,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(children: [

      Row( children: [
        Text('${getTranslated('delivery_service_name', context)} : ',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),

        Text(getTranslated(order!.orders!.shippingType.toString(), context)!,
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14))]),
      const SizedBox(height: Dimensions.marginSizeExtraSmall),


      Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Text('${getTranslated('tracking_id', context)} : ',
            style:GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),

        Text(
            order!.orders!.id.toString(),
            style:GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),
      ]),
      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: Row(children: [
            Text('${getTranslated('PAYMENT_STATUS', context)!} : ',
                style:GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),

            Text(
               getTranslated( order!.orders!.paymentStatus, context)! ,
                style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14))])),


      Row( children: [
        Text('${getTranslated('PAYMENT_PLATFORM', context)!} : ',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),

        Text(getTranslated(order!.orders!.paymentMethod, context)!,
            style: GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14)),
      ]),
    ],),
  ),
)
          ]),
    );
  }
}
