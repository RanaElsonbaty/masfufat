import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

abstract class SearchProductRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getSearchProductList(String query,bool?brand, String? categoryIds, String? brandIds, String? sort, String? priceMin, String? priceMax, int offset,String? syncFilter);
  Future<dynamic> getSearchProductName(String name);
  Future<dynamic> saveSearchProductName(String searchAddress);
  List<String> getSavedSearchProductName();
  Future<bool> clearSavedSearchProductName();

}