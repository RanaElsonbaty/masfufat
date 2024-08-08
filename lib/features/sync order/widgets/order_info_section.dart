import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/models/sync_order_details.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/widgets/sync_order_type.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
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

          const Row(children: [
            Expanded(child: SyncOrderType(text: 'منصه مصفوفات', index: 0,)),
            Expanded(child: SyncOrderType(text: 'منصه المتجر', index: 1,)),
          ],),
          const SizedBox(height: Dimensions.paddingSizeDefault),

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
                        child: Text('${getTranslated('Date_and_time_of_order', context)!} :',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(DateConverter.formatDate(widget.orderDetailsModel.createdAt!),style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_status_on_Matrix_platform', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(getTranslated(widget.orderDetailsModel.orderStatus!, context)!,style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_payment_status_on_the_Mushafat_platform', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(getTranslated(widget.orderDetailsModel.paymentStatus, context)!,style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),   const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('payment_method', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(widget.orderDetailsModel.paymentMethod!=null?getTranslated(widget.orderDetailsModel.paymentMethod, context)!:'',style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Shipping_and_delivery_company', context)!} :',
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(

                          ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.senderInfo!=null&& widget.orderDetailsModel.shippingInfo!.senderInfo!.name != null ? widget.orderDetailsModel.shippingInfo!.senderInfo!.name : ""}',
                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.senderInfo!=null&& widget.orderDetailsModel.shippingInfo!.senderInfo!.name != null ? widget.orderDetailsModel.shippingInfo!.senderInfo!.name : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Tracking_number_with_shipping_and_delivery_company', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(

                          ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo! : ""}',
                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.shippingTrackingNo! : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Shipment_status_with_shipping_and_delivery_company', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                          ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.status != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.status! : ""}',

                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                ' ${widget.orderDetailsModel.shippingInfo != null && widget.orderDetailsModel.shippingInfo!.shipmentData != null && widget.orderDetailsModel.shippingInfo!.shipmentData!.status != null ? widget.orderDetailsModel.shippingInfo!.shipmentData!.status! : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
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
                        child: Text('${getTranslated('Order_status_on_the_store_platform', context)!} :',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                            ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.status != null ? widget.orderDetailsModel.externalOrder!.status! : ""}',

    style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.status != null ? widget.orderDetailsModel.externalOrder!.status! : ""}',
                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Payment_status_of_the_order_by_the_end_customer_of_the_store', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                            '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment != null ? widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment == true ? getTranslated('unpaid', context) : getTranslated('paid', context) : ""}',
                            style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment != null ? widget.orderDetailsModel.externalOrder!.details!.data!.isPendingPayment == true ? getTranslated('unpaid', context) : getTranslated('paid', context) : ""}',
                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('payment_method', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                            '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod != null ? getTranslated(widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod, context) : ""}',

                            style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                '${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod != null ? getTranslated(widget.orderDetailsModel.externalOrder!.details!.data!.paymentMethod, context) : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('Order_number_on_the_store_platform', context)!} :',
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(

                            ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.referenceId != null ? widget.orderDetailsModel.externalOrder!.details!.data!.referenceId : ""}',
                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                ' ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.referenceId != null ? widget.orderDetailsModel.externalOrder!.details!.data!.referenceId : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_name', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(

                            '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName != null ?( '${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.firstName} ${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName}') : ""}',
                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName != null ?( '${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.firstName} ${widget.orderDetailsModel.externalOrder!.details!.data!.customer!.lastName}') : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_mobile_number', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                            '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile : ""}',

                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.mobile : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
                    ],
                  ),   const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: Text('${getTranslated('End_customer_email', context)!} :',

                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontSize: 16,
                        ),),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1,color: Colors.grey)
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                          child: Text(
                            '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email : ""}',

                          style: const TextStyle(
                          fontSize: 16,
                          ),),
                        ),
                      ),
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
                                '  ${widget.orderDetailsModel.externalOrder != null && widget.orderDetailsModel.externalOrder!.details!.data != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer != null && widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email != null ? widget.orderDetailsModel.externalOrder!.details!.data!.customer!.email : ""}',

                            ));
                          },
                          child: Image.asset(Images.copy,width: 25,)),
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
