import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/domain/models/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

import '../domain/models/order_details_model.dart';

class CancelAndSupportWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final bool fromNotification;
  final List<OrderDetailsModel> orderDetailsModel;

  const CancelAndSupportWidget({super.key, this.orderModel, this.fromNotification = false, required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    // print('aasdasdasdasdasdasdasd  ${orderModel!.refundRequest}');
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen())),
            child: Text.rich(TextSpan(children: [
              TextSpan(text: getTranslated('if_you_cannot_contact_with_seller_or_facing_any_trouble_then_contact', context),
                style: titilliumRegular.copyWith(color: ColorResources.hintTextColor, fontSize: Dimensions.fontSizeSmall),),
              TextSpan(text: '  ${getTranslated('SUPPORT_CENTER', context)}',
                style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context)))]))),
          const SizedBox(height: Dimensions.homePagePadding),


          // (orderModel != null && (orderModel!.customerId == int.parse(Provider.of<ProfileController>(context, listen: false).userID)) &&
          //     (orderModel!.orderStatus == 'pending') && (orderModel!.orderType != "POS")) ?
          // CustomButton(textColor: Theme.of(context).colorScheme.error,
          //     backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
          //     buttonText: getTranslated('cancel_order', context),
          //     onTap: () {
          //   showDialog(context: context, builder: (context) => Dialog(
          //         backgroundColor: Colors.transparent,
          //         child: CancelOrderDialogWidget(orderId: orderModel!.id)));}) :





          // (Provider.of<AuthController>(context, listen: false).isLoggedIn() &&
          //     orderModel!.customerId! == int.parse(Provider.of<ProfileController>(context, listen: false).userID) &&
          //     orderModel!.orderType != "POS" && (orderModel!.orderStatus != 'canceled' &&
          //     orderModel!.orderStatus != 'returned'  && orderModel!.orderStatus != 'fail_to_delivered' ) )?
          // CustomButton(buttonText: getTranslated('TRACK_ORDER', context),
          //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          //       TrackingResultScreen(orderID: orderModel!.id.toString()))),): const SizedBox(),

          const SizedBox(width: Dimensions.paddingSizeSmall)


        ],
      ),
    );
  }
}
