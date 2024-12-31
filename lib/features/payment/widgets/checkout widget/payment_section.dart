import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment/controller/payment_controller.dart';
import 'package:provider/provider.dart';

import '../../../../utill/dimensions.dart';
import '../../../checkout/controllers/checkout_controller.dart';

class CheckOutPaymentSection extends StatefulWidget {
  const CheckOutPaymentSection({super.key, required this.amount});
  final double amount;

  @override
  State<CheckOutPaymentSection> createState() => _CheckOutPaymentSectionState();
}

class _CheckOutPaymentSectionState extends State<CheckOutPaymentSection> {


  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(
      builder:(context, paymentProvider, child) =>  Consumer<CheckoutController>(
        builder:(context, checkoutProvider, child) {
          return  checkoutProvider.selectedDigitalPaymentMethodId!=null&&checkoutProvider.selectedDigitalPaymentMethodId==0?  Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                          color: Colors.white),
                      child:paymentProvider.build(context, false, false),
                    ),
                  ),
                ],
              ),
            ),
          ):const SizedBox.shrink();
        },
      ),
    );
  }
}
