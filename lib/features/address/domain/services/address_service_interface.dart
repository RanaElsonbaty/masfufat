import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/domain/models/label_model.dart';


abstract class AddressServiceInterface{

  Future<dynamic> getList({bool fromRemove = false, bool isShipping = false, bool isBilling = false, bool all = false});

  Future<dynamic> add(AddressModel addressModel);

  Future<dynamic> update(Map<String, dynamic> body, int addressId);

  Future<dynamic> delete(int id);

  List<LabelAsModel> getAddressType();

  Future<ApiResponse> getCountryList();

  Future<ApiResponse> getCityList(String id);

  Future<dynamic> getDeliveryRestrictedCountryList();

  Future<dynamic> getDeliveryRestrictedZipList();

  Future<dynamic> getDeliveryRestrictedZipBySearch(String zipcode);

  Future<dynamic> getDeliveryRestrictedCountryBySearch(String country);
}