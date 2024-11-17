
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/model/payment_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/repositories/payment_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/services/payment_service_interface.dart';


class PaymentsService implements PaymentServiceInterface{
  PaymentRepositoryInterface paymentRepositoryInterface;
  PaymentsService({required this.paymentRepositoryInterface});

  @override
  Future checkPayment(PaymentModel paymentModel) async{
  return await paymentRepositoryInterface.checkPayment(paymentModel);
  }






}