import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/repositories/My_Shop_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class MyShopRepository implements MyShopRepositoryInterface{
  final DioClient? dioClient;
  MyShopRepository({required this.dioClient});

  @override
  Future<ApiResponse>  getList({int? offset}) async {
    try {
      Response response = await dioClient!.get(AppConstants.linkedProduct);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse>  delete(int id,) async {
    try {
      var data = {"id": id};
      Response response = await dioClient!.post(AppConstants.deletePendingProducts
      ,data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse>  deleteLinked(int id,) async {
    try {
      var data = {"id": id};
      Response response = await dioClient!.post(AppConstants.deleteLinkedProducts
      ,data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }  @override
  Future<ApiResponse>  addProduct(int id,) async {
    try {

      Response response = await dioClient!.post('${AppConstants.addProductToStore}$id'
      ,
      );
      print(response.data);
      return ApiResponse.withSuccess(response);

    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  } @override
  Future<ApiResponse>  addPriceToProduct(int id,String price) async {
    try {
      var data = {
        'product_id': id,
        "price": price,
      };
      Response response = await dioClient!.post(AppConstants.addLinkedProductToSyncing
      ,data: data
      );
      print(response.data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }@override
  Future<ApiResponse>  syncProduct(bool sync) async {
    try {

      Response response = await dioClient!.post(AppConstants.syncLinkedProducts,

          data: {
            'resync_deleted':sync==true?1:0,
          }
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future resyncProduct(int id) async{
    try {

      Response response = await dioClient!.post(AppConstants.syncLinkedProducts,
          data: {
            'resync':0,
            "product_id":id,
          }
      );
      print(response.data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }


  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }


  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }


}