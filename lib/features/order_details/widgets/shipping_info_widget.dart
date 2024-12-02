import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/date_converter.dart';
import '../../../utill/images.dart';

class ShippingInfoWidget extends StatelessWidget {
  final OrderDetailsController? order;
  const ShippingInfoWidget({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Card(color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: Text('${getTranslated('Date_and_time_of_order', context)!} : ${DateConverter.formatDate(order!.orders!.createdAt)}',
                    overflow: TextOverflow.ellipsis,
                    style:  GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),
                  ),
                ),
                // const Spacer(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 0),
                //   child: Text(,style: const TextStyle(
                //   fontSize: 16,
                //   ),),
                // ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      showCustomSnackBar(
                        getTranslated(
                            'The_text_has_been_copied',
                            context),
                        context,
                        isError: false,
                      );
                      Clipboard.setData( ClipboardData(
                          text:
                          DateConverter.formatDate(order!.orders!.createdAt)));
                    },
                    child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color,)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: Text('${getTranslated('Order_status_on_Matrix_platform', context)!} : ${getTranslated(order!.orders!.orderStatus, context)!}',

                    overflow: TextOverflow.ellipsis,
                    style:  GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),),
                ),
                const Spacer(),

                InkWell(
                    onTap: (){
                      showCustomSnackBar(
                        getTranslated(
                            'The_text_has_been_copied',
                            context),
                        context,
                        isError: false,
                      );
                      Clipboard.setData( ClipboardData(
                          text:
                          getTranslated(order!.orders!.orderStatus, context)!));
                    },
                    child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: Text('${getTranslated('Order_payment_status_on_the_Mushafat_platform', context)!} : ${getTranslated(order!.orders!.paymentStatus, context)!}',

                    overflow: TextOverflow.ellipsis,
                    style:  GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),),
                ),
                const Spacer(),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border.all(width: 1,color: Colors.grey)
                //   ),
                //   child:  Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                //     child: Text(getTranslated(widget.orderDetailsModel.paymentStatus, context)!,style: const TextStyle(
                //     fontSize: 16,
                //     ),),
                //   ),
                // ),
                InkWell(
                    onTap: (){
                      showCustomSnackBar(
                        getTranslated(
                            'The_text_has_been_copied',
                            context),
                        context,
                        isError: false,
                      );
                      Clipboard.setData( ClipboardData(
                          text:
                          getTranslated(order!.orders!.paymentStatus, context)!));
                    },
                    child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
              ],
            ),   const SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: Text('${getTranslated('payment_method', context)!} : ${order!.orders!.paymentMethod!=null?getTranslated(order!.orders!.paymentMethod, context)!:'none'}',

                    overflow: TextOverflow.ellipsis,
                    style:  GoogleFonts.tajawal(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,

                    ),),
                ),
                const Spacer(),

                InkWell(
                    onTap: (){
                      showCustomSnackBar(
                        getTranslated(
                            'The_text_has_been_copied',
                            context),
                        context,
                        isError: false,
                      );
                      Clipboard.setData( ClipboardData(
                          text:
                          getTranslated(order!.orders!.paymentMethod, context)!));
                    },
                    child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
              ],
            ),
            // const SizedBox(height: 10,),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 11,
            //       child: Text('${getTranslated('Shipping_and_delivery_company', context)!} : ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.senderInfo!=null&& order!.orders!.shippingInfo!.senderInfo!.name != null ? order!.orders!.shippingInfo!.senderInfo!.name : "none"}',
            //         overflow: TextOverflow.ellipsis,
            //
            //         style:  GoogleFonts.tajawal(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //
            //         ),),
            //     ),
            //     const Spacer(),
            //
            //     InkWell(
            //         onTap: (){
            //           showCustomSnackBar(
            //             getTranslated(
            //                 'The_text_has_been_copied',
            //                 context),
            //             context,
            //             isError: false,
            //           );
            //           Clipboard.setData( ClipboardData(
            //             text:
            //             ' ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.senderInfo!=null&& order!.orders!.shippingInfo!.senderInfo!.name != null ? order!.orders!.shippingInfo!.senderInfo!.name : "none"}',
            //
            //           ));
            //         },
            //         child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
            //   ],
            // ),
            // const SizedBox(height: 10,),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 11,
            //       child: Text('${getTranslated('Tracking_number_with_shipping_and_delivery_company', context)!} : ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.shipmentData != null && order!.orders!.shippingInfo!.shipmentData!.shippingTrackingNo != null ? order!.orders!.shippingInfo!.shipmentData!.shippingTrackingNo! : "none"}',
            //
            //         overflow: TextOverflow.ellipsis,
            //         style:  GoogleFonts.tajawal(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //
            //         ),),
            //     ),
            //     const Spacer(),
            //
            //     InkWell(
            //         onTap: (){
            //           showCustomSnackBar(
            //             getTranslated(
            //                 'The_text_has_been_copied',
            //                 context),
            //             context,
            //             isError: false,
            //           );
            //           Clipboard.setData( ClipboardData(
            //             text:
            //             ' ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.shipmentData != null && order!.orders!.shippingInfo!.shipmentData!.shippingTrackingNo != null ? order!.orders!.shippingInfo!.shipmentData!.shippingTrackingNo! : "none"}',
            //
            //           ));
            //         },
            //         child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
            //   ],
            // ),
            // const SizedBox(height: 10,),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 11,
            //       child: Text('${getTranslated('Shipment_status_with_shipping_and_delivery_company', context)!} : ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.shipmentData != null && order!.orders!.shippingInfo!.shipmentData!.status != null ? order!.orders!.shippingInfo!.shipmentData!.status! : "none"}',
            //
            //         overflow: TextOverflow.ellipsis,
            //         style:  GoogleFonts.tajawal(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //
            //         ),),
            //     ),
            //     const Spacer(),
            //
            //     InkWell(
            //         onTap: (){
            //           showCustomSnackBar(
            //             getTranslated(
            //                 'The_text_has_been_copied',
            //                 context),
            //             context,
            //             isError: false,
            //           );
            //           Clipboard.setData( ClipboardData(
            //             text:
            //             ' ${order!.orders!.shippingInfo != null && order!.orders!.shippingInfo!.shipmentData != null && order!.orders!.shippingInfo!.shipmentData!.status != null ? order!.orders!.shippingInfo!.shipmentData!.status! : "none"}',
            //
            //           ));
            //         },
            //         child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
            //   ],
            // ),
          ],),
        ),
      ),
    );
  }
}
