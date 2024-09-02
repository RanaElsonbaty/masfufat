import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/icon_with_text_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SyncShippingAndBillingWidget extends StatelessWidget {
  final SyncOrderController orderProvider;
  const SyncShippingAndBillingWidget({super.key, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return
      orderProvider.syncOrderDetails!.shippingAddressData!=null?  Container(decoration: const BoxDecoration(
        // image: DecorationImage(image: AssetImage(Images.mapBg,), fit: BoxFit.cover, )
      ),
        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(getTranslated('Address_details', context)!,style: GoogleFonts.tajawal(
                fontWeight: FontWeight.w500,
                 fontSize: 16
              ),),
            ),
            // Divider(thickness: .25, color: Theme.of(context).primaryColor.withOpacity(0.50),),
            // Text(getTranslated('shipping', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
            // const SizedBox(height: Dimensions.marginSizeSmall),
Card(
  color: const Color(0xFFEFECF5),
  child: Column(
    children: [
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),

      Padding(
        padding: const EdgeInsets.all(3.0),
        child: IconWithTextRowWidget(
          icon: Icons.person_2_outlined,
          text: orderProvider.syncOrderDetails!.shippingAddressData != null&&orderProvider.syncOrderDetails!.shippingAddressData!.contactPersonName!=null ?
          orderProvider.syncOrderDetails!.shippingAddressData!.contactPersonName ?? '': '',),
      ),
      // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

      Padding(
        padding: const EdgeInsets.all(3.0),
        child: IconWithTextRowWidget(
          icon: Icons.call,
          text: orderProvider.syncOrderDetails!.shippingAddressData != null&& orderProvider.syncOrderDetails!.shippingAddressData!.phone!=null ?
          orderProvider.syncOrderDetails!.shippingAddressData!.phone! : '',),
      ),
      // const SizedBox(height: Dimensions.paddingSizeExtraSmall),

      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.black),
              const SizedBox(width: Dimensions.marginSizeSmall),

              Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Text(orderProvider.syncOrderDetails!.shippingAddressData != null&&orderProvider.syncOrderDetails!.shippingAddressData!.address!=null ?
                  orderProvider.syncOrderDetails!.shippingAddressData!.address! : '',
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400))))
            ]),
      ),

      const SizedBox(height: Dimensions.paddingSizeSmall),

    ],
  ),
)


              ]
            ),

        )
    ):const SizedBox.shrink();
  }
}
