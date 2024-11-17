import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/label_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/repositories/address_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';


class AddressRepository implements AddressRepoInterface<ApiResponse>{
  final DioClient? dioClient;
  AddressRepository({this.dioClient});


  @override
  Future<ApiResponse> getDeliveryRestrictedCountryList() async {
    try {
      final response = await dioClient!.get(AppConstants.deliveryRestrictedCountryList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getDeliveryRestrictedZipList() async {
    try {
      final response = await dioClient!.get(AppConstants.deliveryRestrictedZipList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getDeliveryRestrictedZipBySearch(String zipcode) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryRestrictedZipList}?search=$zipcode');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getDeliveryRestrictedCountryBySearch(String country) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryRestrictedCountryList}?search=$country');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getList({int? offset,}) async {
    try {
      final response = await dioClient!.get(AppConstants.addressListUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> delete(int? id) async {
    try {
      final response = await dioClient!.post(
        '${AppConstants.removeAddressUri}?address_id=$id',
        data: {"_method" : 'delete'}
      );
      ApiResponse res = ApiResponse.withSuccess(response);
      return res;
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> add(AddressModel addressModel) async {
    try {
      var data = FormData.fromMap({
        'contact_person_name': addressModel.contactPersonName,
        'address_type': addressModel.addressType,
        'address': addressModel.address,
        'city': addressModel.city,
        'zip': addressModel.zip,
        'title':addressModel.addressType,
        'country': addressModel.country,
        'phone': addressModel.phone,
        'latitude': addressModel.latitude,
        'longitude': addressModel.longitude,
        'is_billing': '1'
      });

      print(data);
      Response response = await dioClient!.post(AppConstants.addAddressUri, data:data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> update(Map<String, dynamic> addressModel, int addressId) async {
    try {
      Response response = await dioClient!.put(AppConstants.updateAddressUri, data: addressModel,options:
      Options(
        method: 'PUT',
      ));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> getCountryList() async {
    try {
      Response response = await dioClient!.get(AppConstants.countries, );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  } @override
  Future<ApiResponse> getCityList(String id,{bool address=false}) async {
    try {
      print(address);
      Response response = await dioClient!.get(address?AppConstants.provincesAwb:'${AppConstants.provinces}$id', );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  List<LabelAsModel> getAddressType() {
    List<LabelAsModel> labelAsList= [
      LabelAsModel('home', Images.homeImage),
      LabelAsModel('office', Images.officeImage),
      LabelAsModel('others', Images.address),
    ];
    return labelAsList;
  }




  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

}


