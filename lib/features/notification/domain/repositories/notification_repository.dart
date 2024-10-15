import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/repositories/notification_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class NotificationRepository implements NotificationRepositoryInterface{
  final DioClient? dioClient;
  NotificationRepository({required this.dioClient});

  @override
  Future<ApiResponse>  getList({int? offset}) async {
    try {
      Response response = await dioClient!.get('${AppConstants.notificationUri}$offset');
;      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse>  seenNotification(int id) async {
    try {
      Response response = await dioClient!.post('${AppConstants.seenNotificationUri}id=$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // 
    throw UnimplementedError();
  }


  @override
  Future update(Map<String, dynamic> body, int id) {
    throw UnimplementedError();
  }
}