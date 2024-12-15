import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/services/product_details_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';

class ProductDetailsController extends ChangeNotifier {
  final ProductDetailsServiceInterface productDetailsServiceInterface;
  ProductDetailsController({required this.productDetailsServiceInterface});


  int? _imageSliderIndex;
  int? _quantity = 0;
  int? _variantIndex;
  List<int>? _variationIndex;
  int? _orderCount;
  int? _wishCount;
  String? _sharableLink;
  int? _digitalVariationIndex = 0;
  int? _digitalVariationSubindex = 0;

  bool _isDetails = false;
  bool get isDetails =>_isDetails;
  int? get imageSliderIndex => _imageSliderIndex;
  int? get quantity => _quantity;
  int? get variantIndex => _variantIndex;
  List<int>? get variationIndex => _variationIndex;
  int? get orderCount => _orderCount;
  int? get wishCount => _wishCount;
  String? get sharableLink => _sharableLink;
  ProductDetailsModel? _productDetailsModel;
  ProductDetailsModel? get productDetailsModel => _productDetailsModel;
  int? get digitalVariationIndex => _digitalVariationIndex;
  int? get digitalVariationSubindex => _digitalVariationSubindex;


  bool _noProductFount=false;
  bool get noProductFount=>_noProductFount;
  Future<void> getProductDetails(BuildContext context, String productId, String slug) async {
   try{
     _isDetails = true;
     ApiResponse apiResponse = await productDetailsServiceInterface.get(productId);
     if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
       _isDetails = false;

       if(apiResponse.response!.data.toString()=='{}'){
         _noProductFount=true;
       }else{
         _noProductFount=false;
       }
       _productDetailsModel = ProductDetailsModel.fromJson(apiResponse.response!.data);
     } else {
       _noProductFount=false;

       _isDetails = false;
       // showCustomSnackBar(apiResponse.error.toString(), Get.context!);
     }
     _isDetails = false;
     notifyListeners();
   }catch(e){
     _noProductFount=false;

     _isDetails = false;
     notifyListeners();
   }
  }




  void initData(ProductDetailsModel product, int? minimumOrderQuantity, BuildContext context) {
    _variantIndex = 0;
    _quantity = minimumOrderQuantity;
    _variationIndex = [];
    // for (int i=0; i<= product.choiceOptions!.length; i++) {
    //   _variationIndex!.add(0);
    // }
  }

  bool isReviewSelected = false;
  int _index=0;
  int get index=>_index;
  void selectReviewSection(int index, {bool isUpdate = true}){
    // isReviewSelected = review;
    _index=index;

    if(isUpdate) {
      notifyListeners();

    }
  }



  void getCount(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsServiceInterface.getCount(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderCount = apiResponse.response!.data['order_count'];
      _wishCount = apiResponse.response!.data['wishlist_count'];
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  void getSharableLink(String productID, BuildContext context) async {
    ApiResponse apiResponse = await productDetailsServiceInterface.getSharableLink(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _sharableLink = apiResponse.response!.data;
    } else {
      _sharableLink=null;
      // ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  void setImageSliderSelectedIndex(int selectedIndex) {
    _imageSliderIndex = selectedIndex;
    notifyListeners();
  }


  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  void setCartVariantIndex(int? minimumOrderQuantity,int index, BuildContext context) {
    _variantIndex = index;
    _quantity = minimumOrderQuantity;
    notifyListeners();
  }

  void setCartVariationIndex(int? minimumOrderQuantity, int index, int i, BuildContext context) {
    _variationIndex![index] = i;
    _quantity = minimumOrderQuantity;
    notifyListeners();
  }


  void removePrevLink() {
    _sharableLink = null;
  }

  bool isValidYouTubeUrl(String url) {
    RegExp regex = RegExp(
      r'^https?:\/\/(?:www\.)?(youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    return regex.hasMatch(url);
  }

  void setDigitalVariationIndex(int? minimumOrderQuantity, int index, int subIndex, BuildContext context) {
    _quantity = minimumOrderQuantity;
    _digitalVariationIndex = index;
    _digitalVariationSubindex = subIndex;
    notifyListeners();
  }

  void initDigitalVariationIndex() {
    _digitalVariationIndex = 0;
    _digitalVariationSubindex = 0;
  }
  Future<bool> getProductDetailsBarCode( String barCode) async {
    _isDetails = true;
    notifyListeners();
  try{
    ApiResponse apiResponse =
    await productDetailsServiceInterface.getBarCodeProduct( barCode);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isDetails = false;
      _productDetailsModel =
          ProductDetailsModel.fromJson(apiResponse.response!.data);


      Navigator.push(Get.context!,MaterialPageRoute(builder: (context) => ProductDetails(productId: _productDetailsModel!.id!, slug: _productDetailsModel!.slug!, product: null,)));


      _isDetails = false;
      notifyListeners();
    }
    _isDetails=false;
    notifyListeners();
return true;
  }catch(e){
    _isDetails=false;
    notifyListeners();
    return false;

  }

  }
}
