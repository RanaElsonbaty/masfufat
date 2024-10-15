import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/sync_order_details.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/widgets/sync_order_type.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../utill/dimensions.dart';

class OrderInfoSection extends StatefulWidget {
  const OrderInfoSection({super.key, required this.orderDetailsModel});
  final SyncOrderDetailsModel orderDetailsModel;

  @override
  State<OrderInfoSection> createState() => _OrderInfoSectionState();
}

class _OrderInfoSectionState extends State<OrderInfoSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SyncOrderController>(
      builder:(context, syncOrderProvider, child) =>  Column(
        children: [

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
              Expanded(
                  flex: 1,
                  child: Text(getTranslated('Order_information', context)!,

                    style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.w500

             ,fontSize: 16                ),)),
               Expanded(child: SyncOrderType(text: getTranslated('Matrix_platform', context), index: 0,)),
               Expanded(child: SyncOrderType(text: getTranslated('Store_platform', context), index: 1,)),
                       ],),
           ),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          syncOrderProvider.userTypeIndex==0?      Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Date_and_time_of_order', context)!} : ${DateConverter.formatDate(widget.orderDetailsModel.createdAt!)}',
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
                                DateConverter.formatDate(widget.orderDetailsModel.createdAt!)));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_status_on_Matrix_platform', context)!} : ${getTranslated(widget.orderDetailsModel.orderStatus!, context)!}',

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
                                getTranslated(widget.orderDetailsModel.orderStatus!, context)!));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_payment_status_on_the_Mushafat_platform', context)!} : ${getTranslated(widget.orderDetailsModel.paymentStatus, context)!}',

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
                                getTranslated(widget.orderDetailsModel.paymentStatus, context)!));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),   const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('payment_method', context)!} : ${widget.orderDetailsModel.paymentMethod!=null?getTranslated(widget.orderDetailsModel.paymentMethod, context)!:'none'}',

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
                                getTranslated(widget.orderDetailsModel.paymentMethod, context)!));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Shipping_and_delivery_company', context)!} : ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.senderInfo!=null&& widget.orderDetailsModel.shippingInfo!.senderInfo!.name != null ? widget.orderDetailsModel.shippingInfo!.senderInfo!.name : "none"}',
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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.senderInfo!=null&& widget.orderDetailsModel.shippingInfo!.senderInfo!.name != null ? widget.orderDetailsModel.shippingInfo!.senderInfo!.name : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Tracking_number_with_shipping_and_delivery_company', context)!} : ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo! : "none"}',

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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo! : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Shipment_status_with_shipping_and_delivery_company', context)!} : ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.status != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.status! : "none"}',

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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.status != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.status! : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                ],),
              ),
            ),
          ):  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_status_on_the_store_platform', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.status != null ? widget.orderDetailsModel.externalOrder!.status! : "none"}',
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
                                ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.status != null ? widget.orderDetailsModel.externalOrder!.status! : "none"}',
                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Payment_status_of_the_order_by_the_end_customer_of_the_store', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment != null ? widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment == true ? getTranslated('unpaid', context) : getTranslated('paid', context) : "none"}',

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
                                '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment != null ? widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment == true ? getTranslated('unpaid', context) : getTranslated('paid', context) : "none"}',
                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('payment_method', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod != null ? getTranslated(widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod, context) : "none"}',

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
                                '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod != null ? getTranslated(widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod, context) : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_number_on_the_store_platform', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.referenceId != null ? widget.orderDetailsModel.externalOrder!.details!.data!.referenceId : "none"}',
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
                                ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.referenceId != null ? widget.orderDetailsModel.externalOrder!.details!.data!.referenceId : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_name', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName != null ?( '${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.firstName} ${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName}') : "none"}',

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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName != null ?( '${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.firstName} ${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName}') : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_mobile_number', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile : "none"}',

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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color)),
                    ],
                  ),   const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_email', context)!} : ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email : "none"}',

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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email : "none"}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,color: Theme.of(context).iconTheme.color )),
                    ],
                  ),
                ],),
              ),
            ),
          ),
        ],
      ),
    )
    ;
  }
}
