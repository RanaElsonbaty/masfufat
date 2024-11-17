import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/features/sync%20order/domain/repositories/sync_order_repository_interface.dart';

import '../../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../../data/model/api_response.dart';
import '../../../../utill/app_constants.dart';




class SyncOrderRepository implements SyncOrderRepositoryInterface{
  final DioClient? dioClient;
  SyncOrderRepository({required this.dioClient});
  @override
  Future<ApiResponse> getOrderList(String type, String page) async{
    try {
      final response = await dioClient!.get('${AppConstants.syncOrderList}$type&page=$page');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  } @override
  Future<ApiResponse> getOrderDeteilsList( String id) async{
    try {
      final response = await dioClient!.get('${AppConstants.syncOrderDetailsList}$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  // @override
  // Future<ApiResponse> placeBankTransferOrder( String id,String paymentMethod) async{
  //   try {
  //     var data = FormData.fromMap({
  //       "id": id,
  //       "payment_method": paymentMethod,
  //     });
  //     final response = await dioClient!.post(AppConstants.placeBankTransferOrder,
  //
  //     data: data);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
  @override
  Future<ApiResponse> placeSyncWalletOrder(String id) async{
    var data = {"id": id};

    try {
      final response = await dioClient!.post(AppConstants.placeSyncWalletOrder,data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }  @override
  Future<ApiResponse> placeSyncOrderCashOnDelivery(String id,String couponCode,String couponDiscount,String orderNode,int addressId) async{

    // if()
    var data =FormData.fromMap({
      'id': id,
      'address_id': addressId,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'order_note': '',
      'payment_method': 'cash_on_delivery'
    });
    try {
      final response = await dioClient!.post(AppConstants.placeSyncOrderCashOnDelivery,
      data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
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
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
  @override
  Future<ApiResponse> bankAndDelayedPayment(
      String orderID,
      String paymentMethod,
      String bank,

      String holderName,
      int addressId,
  XFile? attachment,

  ) async {
    var data =FormData.fromMap({
      'attachment': [
        await MultipartFile.fromFile(attachment!.path, filename: attachment.name)
      ],
      // "attachment":attachment!.path,
      'id': orderID,
      'address_id': addressId,
      'coupon_code': '',
      'coupon_discount': '0',
      'order_note': '',
      "holder_name":holderName,
      'payment_method': 'bank_transfer'
    });

    try {
      final response = await dioClient!.post(
       '${AppConstants.baseUrl}${AppConstants.placeBankTransferSyncOrder}' ,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> placeSyncDelayedOrder(String id, String addressId, String couponCode, String couponDiscount, String orderNote)async {
    // if()
    var data =FormData.fromMap({
      'id': id,
      'address_id': addressId,
      'coupon_code': couponCode,
      'coupon_discount': couponDiscount,
      'order_note': orderNote,
      'payment_method': 'delayed'
    });

    try {
      final response = await dioClient!.post(
        "${AppConstants.baseUrl}${AppConstants.placeSyncDelayedOrder}",
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}