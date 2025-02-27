import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/repositories/splash_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepository implements SplashRepositoryInterface{
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepository({required this.dioClient, required this.sharedPreferences});

  @override
  Future getConfigGuest() async{
    try {
      final response = await dioClient!.get(AppConstants.configUriGuest,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.configUri,
      options: Options(
        headers: {
          // 'Authorization': 'Bearer $token',
          'Authorization':"Bearer ${sharedPreferences!.get('user_login_token')}"
        }
      )
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  @override
  void initSharedData() async {
    if (!sharedPreferences!.containsKey(AppConstants.intro)) {
      sharedPreferences!.setBool(AppConstants.intro, true);
    }
    if(!sharedPreferences!.containsKey(AppConstants.currency)) {
      sharedPreferences!.setString(AppConstants.currency, '');
    }
  }

  @override
  String getCurrency() {
    return sharedPreferences!.getString(AppConstants.currency) ?? '';
  }

  @override
  void setCurrency(String currencyCode) {
    sharedPreferences!.setString(AppConstants.currency, currencyCode);
  }

  @override
  void disableIntro() {
    sharedPreferences!.setBool(AppConstants.intro, false);
  }

  @override
  bool? showIntro() {
    return sharedPreferences!.getBool(AppConstants.intro);
  }
  @override
  Future<ApiResponse>  getMaintenanceMode() async {
    try {
      // print('getConfig token ------> $token');
      var response = await dioClient!.get("${AppConstants.configUri}?type=maintenance_mode",
          options: Options(
            receiveTimeout: const Duration(seconds: 120),
            sendTimeout:  const Duration(seconds: 120),
            headers: {
            },
          ));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('getConfig error: $e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e)); // Emit error response
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
