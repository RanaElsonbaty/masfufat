import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/icon_with_text_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAndBillingWidget extends StatelessWidget {
  final OrderDetailsController orderProvider;
  const ShippingAndBillingWidget({super.key, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return
    Container(decoration: const BoxDecoration(
      // image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)
    ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // IconWithTextRowWidget(
              //   isTitle: true,
              //   icon: Icons.delivery_dining_outlined,
              //   imageIcon: Images.addressInfoIcon,
              //   iconColor: Theme.of(context).primaryColor,
              //   text: getTranslated('address_info', context)!,
              //   textColor: Theme.of(context).primaryColor),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(getTranslated('Address_details', context)!,style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),),
            ),
            orderProvider.onlyDigital?
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                     const SizedBox(height: Dimensions.marginSizeSmall),



                    Row(
                      children: [
                        Expanded(
                          child: IconWithTextRowWidget(
                            icon: Icons.person_2_outlined,
                            text:
                            orderProvider.orders!.shippingAddressData.contactPersonName,),
                        ),


                      ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeSmall),

                    Row(
                      children: [
                        Expanded(
                          child: IconWithTextRowWidget(
                            icon: Icons.call_outlined,
                            text:
                            orderProvider.orders!.shippingAddressData.phone ,),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.marginSizeSmall),

                    Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_outlined, color: Theme.of(context).iconTheme.color),
                          const SizedBox(width: Dimensions.marginSizeSmall),

                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                            orderProvider.orders!.shippingAddressData.address,
                                maxLines: 3, overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.tajawal(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400))))]),

                    // const SizedBox(height: Dimensions.paddingSizeSmall),
                    // Row(children: [
                    //     Expanded(child: IconWithTextRowWidget(
                    //       imageIcon: Images.country,
                    //         icon: Icons.location_city,
                    //         text: '${ orderProvider.orders!.shippingAddressData?.country != null ?
                    //         orderProvider.orders!.shippingAddressData!.country : ''}')),
                    //
                    //     Expanded(child: IconWithTextRowWidget(
                    //       imageIcon: Images.city,
                    //         icon: Icons.location_city,
                    //         text: '${orderProvider.orders!.shippingAddressData != null ?
                    //         orderProvider.orders!.shippingAddressData!.zip : ''}',))]),
                    ],
                  ),
                ),
              ):const SizedBox(),
              // Divider(thickness: .25, color: Theme.of(context).primaryColor.withOpacity(0.50),),


              // orderProvider.orders!.billingAddressData != null?
              // Padding(
              //   padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //         Text(getTranslated('billing', context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
              //         const SizedBox(height: Dimensions.marginSizeSmall),
              //
              //
              //         Row(
              //           children: [
              //             Expanded(
              //               child: IconWithTextRowWidget(
              //                   icon: Icons.person,
              //                   text: '${orderProvider.orders!.billingAddressData != null ?
              //                   orderProvider.orders!.billingAddressData!.contactPersonName : ''}'),
              //             ),
              //
              //
              //             Expanded(
              //               child: IconWithTextRowWidget(icon: Icons.call,
              //                   text: '${orderProvider.orders!.billingAddressData != null ?
              //                   orderProvider.orders!.billingAddressData!.phone : ''}'),
              //             )
              //           ],
              //         ),
              //         const SizedBox(height: Dimensions.marginSizeSmall),
              //
              //         Row(mainAxisAlignment:MainAxisAlignment.start,
              //           crossAxisAlignment:CrossAxisAlignment.start, children: [
              //             Icon(Icons.location_on, color: Provider.of<ThemeController>(context, listen: false).darkTheme?
              //             Colors.white : Theme.of(context).primaryColor.withOpacity(.30)),
              //             const SizedBox(width: Dimensions.marginSizeSmall),
              //
              //             Expanded(child: Padding(
              //               padding: const EdgeInsets.symmetric(vertical: 1),
              //               child: Text('  orderProvider.orders!.billingAddressData!.address',
              //                   maxLines: 3, overflow: TextOverflow.ellipsis,
              //                   style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
              //             )),
              //           ],
              //         ),
              //     const SizedBox(height: Dimensions.paddingSizeSmall,),
              //
              //     // Row(children: [
              //     //   Expanded(child: IconWithTextRowWidget(
              //     //       imageIcon: Images.country,
              //     //       icon: Icons.location_city,
              //     //       text: '${orderProvider.orders!.billingAddressData?.country != null ?
              //     //       orderProvider.orders!.billingAddressData!.country : ''}')),
              //     //
              //     //   Expanded(child: IconWithTextRowWidget(
              //     //       imageIcon: Images.city,
              //     //       icon: Icons.location_city,
              //     //       text: '${orderProvider.orders!.billingAddressData != null ?
              //     //       orderProvider.orders!.billingAddressData!.zip : ''}'))]),
              //     ]
              //   ),
              // ):const SizedBox(),
            ],
          ),
        )
    );
  }
}
