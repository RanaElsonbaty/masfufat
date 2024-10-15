import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/repositories/product_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class ProductRepository implements ProductRepositoryInterface{
  final DioClient? dioClient;
  ProductRepository({required this.dioClient});

  @override
  Future<ApiResponse> getFilteredProductList(BuildContext context, String offset, ProductType productType, String? title) async {
    late String endUrl;

     if(productType == ProductType.bestSelling){
      endUrl = '${AppConstants.bestSellingProductUri}$offset&order_by=best-selling';
      title = getTranslated('best_selling', context);
    }
    else if(productType == ProductType.newArrival){
      // /api/v1/products/products-lazy?page=$offset&order_by=latest'
      endUrl = '${AppConstants.newArrivalProductUri}$offset&order_by=latest';
      title = getTranslated('new_arrival',context);
    }
    else if(productType == ProductType.topProduct){
      endUrl = '${AppConstants.topProductUri}$offset&order_by=top-rated';
      title = getTranslated('top_product', context);
    }else if(productType == ProductType.discountedProduct){
       endUrl = '${AppConstants.discountedProductUri}$offset&order_by=discounted';
       title = getTranslated('discounted_product', context);
     }
    try {
      final response = await dioClient!.get(
        endUrl);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> getBrandOrCategoryProductList(bool isBrand,int brandId, String id,int offset,bool reloud,String search,String syncFilter,String filter,String price,bool onlyBrand) async {
    try {
      String uri;
      print('object - $onlyBrand');
      if(isBrand){
        if(syncFilter.isEmpty||filter.isEmpty||search.isEmpty) {
          if(onlyBrand==true){
            uri = '${AppConstants.brandProductUri}$brandId&page=$offset${price !=
                '&from_price=0.0&to_price=0.0' ? price : ''}${syncFilter
                .isNotEmpty ? '&product_type=$syncFilter' : ''}${filter.isNotEmpty
                ? '&order_by=$filter'
                : ""}${search.isNotEmpty ? '&search=$search' : ''}';

          }else{
            uri = '/api/v1/products_filter/$brandId/$id?page=$offset${price !=
                '&from_price=0.0&to_price=0.0' ? price : ''}';
          }

        }else {
          uri = '${AppConstants.brandProductUri}$id&page=$offset${price !=
              '&from_price=0.0&to_price=0.0' ? price : ''}${syncFilter
              .isNotEmpty ? '&product_type=$syncFilter' : ''}${filter.isNotEmpty
              ? '&order_by=$filter'
              : ""}${search.isNotEmpty ? '&search=$search' : ''}';
        }
      }else {
        uri = '${AppConstants.categoryProductUri}?category=$id&page=$offset${price!='&from_price=0.0&to_price=0.0'?price:''}${syncFilter.isNotEmpty?'&product_type=$syncFilter':''}${filter.isNotEmpty?'&order_by=$filter':""}${search.isNotEmpty?'&search=$search':''}';
      }
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response = await dioClient!.get('${AppConstants.relatedProductUri}$id?guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getFeaturedProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.featuredProductUri+offset,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> getLatestProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.latestProductUri+offset,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getRecommendedProduct() async {
    try {
      final response = await dioClient!.get(AppConstants.dealOfTheDay);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getMostDemandedProduct() async {
    try {
      final response = await dioClient!.get(AppConstants.mostDemandedProduct);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getFindWhatYouNeed() async {
    try {
      final response = await dioClient!.get(AppConstants.findWhatYouNeed);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getJustForYouProductList() async {
    try {
      final response = await dioClient!.get(AppConstants.justForYou);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getMostSearchingProductList(int offset) async {
    try {
      final response = await dioClient!.get("${AppConstants.mostSearching}?guest_id=1&limit=10&offset=$offset");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getHomeCategoryProductList() async {
    try {
      final response = await dioClient!.get(AppConstants.homeCategoryProductUri);
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