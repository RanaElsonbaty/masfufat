
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/controllers/sync_order_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class SyncPaymentInfoWidget extends StatelessWidget {
  final SyncOrderController? order;
  const SyncPaymentInfoWidget({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('PAYMENT_STATUS', context)!,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text((order!.syncOrderDetails!.paymentStatus != null) ?
              order!.syncOrderDetails!.paymentStatus! : 'Digital Payment',
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall))])),


        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(getTranslated('PAYMENT_PLATFORM', context)!,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

          Text(order!.syncOrderDetails!.paymentMethod!,
              style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
        ]),
      ]),
    );
  }
}
