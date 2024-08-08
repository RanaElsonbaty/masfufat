import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

import '../model/payment_model.dart';

abstract class PaymentRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> checkPayment(PaymentModel paymentModel);


}