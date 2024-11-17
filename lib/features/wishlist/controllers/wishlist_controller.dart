import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/domain/models/wishlist_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/domain/services/wishlist_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';

class WishListController extends ChangeNotifier {
  final WishlistServiceInterface? wishlistServiceInterface;
  WishListController({required this.wishlistServiceInterface});

   bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<WishlistModel>? _wishList=[];
  List<WishlistModel>? get wishList => _wishList;
  List<int> addedIntoWish =[];
void addOfflineWishList(Product productModel,bool add){
  WishlistModel wishlistModel=WishlistModel(
    product: productModel,
    createdAt: DateTime.now().toString(),
     customerId: 0,
    id: 0,
    productId: productModel.id,
    updatedAt: DateTime.now().toString()

  );
  if(add){
    _wishList!.add(wishlistModel);

  }else{
    _wishList!.removeWhere((element) => element.product!.id==productModel.id,);
  }
  notifyListeners();
}

  void addWishList(int? productID) async {
    addedIntoWish.add(productID!);
    ApiResponse apiResponse = await wishlistServiceInterface!.add(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar("${getTranslated("successfully_added_to_wishlist", Get.context!)}", Get.context!, isError: false);

    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  void removeWishList(int? productID, {int? index}) async {
    // addedIntoWish.removeAt(addedIntoWish.indexOf(productID!));
    ApiResponse apiResponse = await wishlistServiceInterface!.delete(productID!);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getWishList();
      showCustomSnackBar("${getTranslated("successfully_removed_from_wishlist", Get.context!)}", Get.context!, isError: false);
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }
// bool =false;
// bool _isLoading=false;
  Future<void> getWishList() async {
    _isLoading=true;
    ApiResponse apiResponse = await wishlistServiceInterface!.getList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _wishList = [];
      addedIntoWish = [];
      apiResponse.response?.data.forEach((wish)=> _wishList?.add(WishlistModel.fromJson(wish)));
      if(_wishList!.isNotEmpty){
        for(int i=0; i< _wishList!.length; i++){
          addedIntoWish.add(_wishList![i].productId!);
        }
        _isLoading=false;
        notifyListeners();
      }
    } else {
      ApiChecker.checkApi( apiResponse);
      _isLoading=false;
      notifyListeners();
    }
    _isLoading=false;
    notifyListeners();
  }

}
