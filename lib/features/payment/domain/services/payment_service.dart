


import 'package:flutter_sixvalley_ecommerce/features/payment/domain/services/payment_service_interface.dart';

import '../model/payment_model.dart';
import '../repositories/payment_repository_interface.dart';

class PaymentsService implements PaymentServiceInterface{
  PaymentRepositoryInterface paymentRepositoryInterface;
  PaymentsService({required this.paymentRepositoryInterface});

  @override
  Future checkPayment(PaymentModel paymentModel) async{
  return await paymentRepositoryInterface.checkPayment(paymentModel);
  }






}