

import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/model/payment_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/payment%20/domain/repositories/payment_repository_interface.dart';
import 'dart:async';

class PaymentRepository implements PaymentRepositoryInterface{
  final DioClient? dioClient;
  PaymentRepository({required this.dioClient});

  @override
  Future<ApiResponse> checkPayment(PaymentModel paymentModel)async {
    var data = FormData.fromMap({
      'invoiceId': paymentModel.invoiceId,
      'InvoiceReference': paymentModel.invoiceReference,
      'payment_method': paymentModel.paymentMethod,
      'payment_amount': paymentModel.paymentAmount,
      "payment_reason":paymentModel.paymentReason,
      "order_id":paymentModel.orderId??'',
    });
    print('invoiceId ---> ${paymentModel.invoiceId}');
    print('invoiceReference ---> ${paymentModel.invoiceReference}');
    print('paymentMethod ---> ${paymentModel.paymentMethod}');
    print('paymentAmount ---> ${paymentModel.paymentAmount}');
    print('orderPrice ---> ${paymentModel.paymentReason}');
    print('order id ---> ${paymentModel.orderId}');
    try{
    Response response = await dioClient!.post(
      '/api/v1/customer/order/place_paid',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    return ApiResponse.withSuccess(response);
  } catch (e) {
  print('check payment error ---> $e');
  return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  }
  }
  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }






}
