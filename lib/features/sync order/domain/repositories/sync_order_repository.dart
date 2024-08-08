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
  }@override
  Future<ApiResponse> placeBankTransferOrder( String id,String paymentMethod) async{
    try {
      var data = FormData.fromMap({
        "id": id,
        "payment_method": paymentMethod,
      });
      final response = await dioClient!.post(AppConstants.placeBankTransferOrder,

      data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> placeSyncWalletOrder(String id) async{
    var data = {"id": id};

    try {
      final response = await dioClient!.post(AppConstants.placeSyncWalletOrder,data: data);
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




}