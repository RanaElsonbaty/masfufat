import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';

abstract class ProductServiceInterface{
  Future<dynamic> getFilteredProductList(BuildContext context,String offset, ProductType productType, String? title);
  Future<dynamic> getBrandOrCategoryProductList(bool isBrand,int brandId, String id,int offset,bool reloud,String search,String syncFilter,String filter,String price,bool onlyBrand);
  Future<dynamic> getRelatedProductList(String id);
  Future<dynamic> getFeaturedProductList(String offset);
  Future<dynamic> getLatestProductList(String offset);
  Future<dynamic> getRecommendedProduct();
  Future<dynamic> getMostDemandedProduct();
  Future<dynamic> getFindWhatYouNeed();
  Future<dynamic> getJustForYouProductList();
  Future<dynamic> getMostSearchingProductList(int offset);
  Future<dynamic> getHomeCategoryProductList(int page);
}