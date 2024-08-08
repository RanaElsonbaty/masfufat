import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/icon_with_text_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class SyncShippingAndBillingWidget extends StatelessWidget {
  final SyncOrderController orderProvider;
  const SyncShippingAndBillingWidget({super.key, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return
    Container(decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Images.mapBg,), fit: BoxFit.cover, )),
        child: Card(margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.homePagePadding),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconWithTextRowWidget(
                  isTitle: true,
                  icon: Icons.delivery_dining_outlined,
                  imageIcon: Images.addressInfoIcon,
                  iconColor: Theme.of(context).primaryColor,
                  text: getTranslated('address_info', context)!,
                  textColor: Theme.of(context).primaryColor),


              // orderProvider.onlyDigital?
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Divider(thickness: .25, color: Theme.of(context).primaryColor.withOpacity(0.50),),
                Text(getTranslated('shipping', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                const SizedBox(height: Dimensions.marginSizeSmall),



                Row(
                  children: [
                    Expanded(
                      child: IconWithTextRowWidget(
                        icon: Icons.person,
                        text: '${orderProvider.syncOrderDetails!.shippingAddressData != null ?
                        orderProvider.syncOrderDetails!.shippingAddressData!.contactPersonName : ''}',),
                    ),

                    Expanded(
                      child: IconWithTextRowWidget(
                        icon: Icons.call,
                        text: orderProvider.syncOrderDetails!.shippingAddressData != null ?
                        orderProvider.syncOrderDetails!.shippingAddressData!.phone! : '',),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.marginSizeSmall),

                Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                      Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
                      const SizedBox(width: Dimensions.marginSizeSmall),

                      Expanded(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(orderProvider.syncOrderDetails!.shippingAddressData != null ?
                          orderProvider.syncOrderDetails!.shippingAddressData!.address! : '',
                              maxLines: 3, overflow: TextOverflow.ellipsis,
                              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault))))]),

                const SizedBox(height: Dimensions.paddingSizeSmall),
             ],
              ),

                  ]
                ),
              // ):const SizedBox(),
            // ],
            // ),

          ),

        )
    );
  }
}
