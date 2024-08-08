import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/services/seller_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/shop_again_from_recent_store_model.dart';

class SellerProductController extends ChangeNotifier {
  final SellerProductServiceInterface? sellerProductServiceInterface;
  SellerProductController({required this.sellerProductServiceInterface});

  final TextEditingController searchController = TextEditingController();
  List<Product>? sellerProduct=[];
bool _isLoading=false;
bool get isLoading=>_isLoading;
  Future <List<Product>> getSellerProductList(String sellerId, int offset, String productId,
    String search ,
    String orderBy,
    String productType ,
    String priceFilter,

  ) async {
    _isLoading =true;
    // if(reload) {
    //   sellerProduct = null;
    // }

    ApiResponse apiResponse = await sellerProductServiceInterface!.getSellerProductList(
      sellerId, offset.toString(),
      productId,
        search,
        orderBy,
        productType,
     priceFilter,




    );
    sellerProduct=[];
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data['products'].forEach((product){
        sellerProduct!.add(Product.fromJson(product));
      });
      _isLoading =false;

      notifyListeners();

      return sellerProduct!;

    } else {
      _isLoading =false;
      notifyListeners();
      ApiChecker.checkApi( apiResponse);
      return [];

    }
  }



  ProductModel? productModel;
  Future<void> getSellerWiseBestSellingProductList(String sellerId, int offset) async {
      ApiResponse apiResponse = await sellerProductServiceInterface!.getSellerWiseBestSellingProductList(sellerId, offset.toString());
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
          if(offset == 1){
            productModel = null;
            productModel = ProductModel.fromJson(apiResponse.response!.data);
          }else {
            productModel!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
            productModel!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
            productModel!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
          }
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
  }



  ProductModel? sellerWiseFeaturedProduct;
  Future<void> getSellerWiseFeaturedProductList(String sellerId, int offset) async {
    ApiResponse apiResponse = await sellerProductServiceInterface!.getSellerWiseFeaturedProductList(sellerId, offset.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        sellerWiseFeaturedProduct = null;
        sellerWiseFeaturedProduct = ProductModel.fromJson(apiResponse.response!.data);
      }else {
        sellerWiseFeaturedProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        sellerWiseFeaturedProduct!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
        sellerWiseFeaturedProduct!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  ProductModel? sellerWiseRecommandedProduct;
  Future<void> getSellerWiseRecommandedProductList(String sellerId, int offset) async {
    ApiResponse apiResponse = await sellerProductServiceInterface!.getSellerWiseRecomendedProductList(sellerId, offset.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(offset == 1){
        sellerWiseRecommandedProduct = null;
        sellerWiseRecommandedProduct = ProductModel.fromJson(apiResponse.response!.data);
      }else {
        sellerWiseRecommandedProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        sellerWiseRecommandedProduct!.offset = ProductModel.fromJson(apiResponse.response!.data).offset;
        sellerWiseRecommandedProduct!.totalSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  List<ShopAgainFromRecentStoreModel> shopAgainFromRecentStoreList = [];
  Future<void> getShopAgainFromRecentStore() async {
    ApiResponse apiResponse = await sellerProductServiceInterface!.getShopAgainFromRecentStoreList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((shopAgain)=> shopAgainFromRecentStoreList.add(ShopAgainFromRecentStoreModel.fromJson(shopAgain)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }




  void clearSellerProducts() {
    sellerWiseFeaturedProduct = null;
    sellerWiseRecommandedProduct = null;
  }

}

