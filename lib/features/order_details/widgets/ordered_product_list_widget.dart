import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/controllers/order_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/widgets/order_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

import '../../order/domain/models/order_model.dart';

class OrderProductListWidget extends StatelessWidget {
  final String? orderType;
  final String? orderId;
  final bool fromTrack;
  final OrderModel orderModel;
  final int? isGuest;
  final bool? fromRefunt;
  const OrderProductListWidget({super.key, this.orderType,  this.fromTrack = false, this.isGuest, this.orderId, required this.orderModel, this.fromRefunt=false});

  @override
  Widget build(BuildContext context) {
    return  Consumer<OrderDetailsController>(
      builder: (context, orderDetailsController, _) {
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemCount:
          orderDetailsController.orderDetails!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) => OrderDetailsWidget(orderDetailsModel: orderDetailsController.orderDetails![i],
              isGuest: isGuest,
              fromRefunt: fromRefunt,
              fromTrack: fromTrack,
              callback: () {showCustomSnackBar('${getTranslated('review_submitted_successfully', context)}', context, isError: false);},
              orderType: orderType!, paymentStatus: orderDetailsController.orders!.paymentStatus, orderId: orderId!, index: i, orderModel: orderModel,),
        );
      }
    );
  }
}
