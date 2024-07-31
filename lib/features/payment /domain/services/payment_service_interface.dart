
import '../model/payment_model.dart';

abstract class PaymentServiceInterface {
  Future <dynamic> checkPayment(PaymentModel paymentModel);



}