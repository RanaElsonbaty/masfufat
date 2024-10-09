import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/Store%20settings/domain/repositories/store_setting_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class StoreSettingRepository implements StoreSettingInterface{
  final DioClient? dioClient;

  StoreSettingRepository({required this.dioClient,});
  @override
  Future<ApiResponse> getLinkedAccount() async {
    try {
      final response = await dioClient!.get(AppConstants.linkedAccount,
         );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> unlinkLinkedAccount(bool salla) async {
    try {
      final response = await dioClient!.post(salla?AppConstants.linkedAccountUnlink:AppConstants.linkedAccountUnlinkZid,
         );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }  @override
  Future<ApiResponse> packages() async {
    try {
      final response = await dioClient!.get(AppConstants.packages,);
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
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  void disableIntro() {
    // TODO: implement disableIntro
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  Future getConfig() {
    // TODO: implement getConfig
    throw UnimplementedError();
  }

  String getCurrency() {
    // TODO: implement getCurrency
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  void initSharedData() {
    // TODO: implement initSharedData
  }

  void setCurrency(String currencyCode) {
    // TODO: implement setCurrency
  }

  bool? showIntro() {
    // TODO: implement showIntro
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }


}
