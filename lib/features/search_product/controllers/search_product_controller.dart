import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/compare/controllers/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/domain/models/suggestion_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/domain/services/search_product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:provider/provider.dart';

class SearchProductController with ChangeNotifier {
  final SearchProductServiceInterface? searchProductServiceInterface;
  SearchProductController({required this.searchProductServiceInterface});

  int _filterIndex = 0;
  List<String> _historyList = [];

  int get filterIndex => _filterIndex;
  List<String> get historyList => _historyList;

  double minPriceForFilter = AppConstants.minFilter;
  double maxPriceForFilter = AppConstants.maxFilter;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setMinMaxPriceForFilter(RangeValues currentRangeValues){
    minPriceForFilter = currentRangeValues.start;
    maxPriceForFilter = currentRangeValues.end;
    notifyListeners();
  }


  bool _isFilterApplied = false;
  bool _isSortingApplied = false;

  bool get isFilterApplied => _isFilterApplied;
  bool get isSortingApplied => _isSortingApplied;


  void setFilterApply({bool? isFiltered, bool? isSorted}){
    if(isFiltered != null) {
      _isFilterApplied = isFiltered;
    }

    if(isSorted != null) {
      _isSortingApplied = isSorted;
    }

    notifyListeners();
  }

  String sortText = 'low-high';
  void setFilterIndex(int index) {
    _filterIndex = index;
    if(index == 0){
      sortText = 'latest';
    }else if(index == 1){
      sortText = 'low-high';
    }else if(index == 2){
      sortText = 'high-low';
    }else if(index == 3){
      sortText = 'q-low-high';
    }else if(index ==4){
      sortText = 'q-high-low';
    }else if(index ==5){
      sortText = 'most-favorite';
    }else if(index ==6){
      sortText = 'featured';
    }else if(index ==7){
      sortText = 'featured_deal';
    }
    notifyListeners();
  }
  int _syncFilterIndex = 0;

  int get syncFilterIndex => _syncFilterIndex;
  String syncSortText = '';

  void setSyncFilterIndex(int index) {
    _syncFilterIndex = index;
    if(index == 0){
      syncSortText = '';
    }else if(index == 1){
      syncSortText = 'not-linked';
    }else if(index == 2){
      syncSortText = 'linked';
    }

    notifyListeners();
  }

  double minFilterValue = 0;
  double maxFilterValue = 0;
  void setFilterValue(double min, double max){
  minFilterValue = min;
  maxFilterValue = max;
  }



  bool _isClear = true;
  bool get isClear => _isClear;

  void cleanSearchProduct({bool notify = false}) {
    // searchedProduct = ProductModel(products: []);
    searchedProduct = null;
    minFilterValue = 0;
    maxFilterValue = 0;
    _isClear = true;
    if(notify){
      notifyListeners();
    }
  }






  List<Product>? searchedProduct;
  Future<List<Product>> searchProduct({required String query,bool?brand,  String? categoryIds, String? brandIds, String? sort, String? priceMin, String? priceMax, required int offset,String ?syncFilter}) async {
    searchController.text = query;
    if(offset == 1) {
      _isLoading = true;
      notifyListeners();
    }

    ApiResponse apiResponse = await searchProductServiceInterface!.getSearchProductList(query,brand, categoryIds, brandIds, sort, priceMin, priceMax, offset,syncFilter);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      // if(offset == 1){
        searchedProduct = [];
        apiResponse.response!.data['products']['data'].forEach((product){
          searchedProduct!.add(Product.fromJson(product));
        });
        return searchedProduct!;
        // if(ProductModel.fromJson(apiResponse.response!.data).products != null){
        //   searchedProduct = );
        //   if(searchedProduct?.minPrice != null){
        //     minFilterValue = searchedProduct!.minPrice!;
        //   }
        //   if(searchedProduct?.maxPrice != null){
        //     maxFilterValue = searchedProduct!.maxPrice!;
        //   }
        // }
        // if(offset == 1) {
        //   _isLoading = false;
        //   notifyListeners();
        // }
      // }else{
      //   if(ProductModel.fromJson(apiResponse.response!.data).products != null){
      //     searchedProduct?.products?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!) ;
          // searchedProduct?.offset = (ProductModel.fromJson(apiResponse.response!.data).offset) ;
          // searchedProduct?.totalSize = (ProductModel.fromJson(apiResponse.response!.data).totalSize) ;
        // }
      // }
    } else {

      ApiChecker.checkApi( apiResponse);
      notifyListeners();

      return []
;    }
  }


  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  SuggestionModel? suggestionModel;
  List<String> nameList = [];
  List<int> idList = [];
  Future<void> getSuggestionProductName(String name) async {

    ApiResponse apiResponse = await searchProductServiceInterface!.getSearchProductName(name);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      nameList = [];
      idList = [];
      suggestionModel = SuggestionModel.fromJson(apiResponse.response?.data);
      for(int i=0; i< suggestionModel!.products!.length; i++){
        nameList.add(suggestionModel!.products![i].name!);
        idList.add(suggestionModel!.products![i].id!);
      }
    }
    notifyListeners();
  }

  void initHistoryList() {
    _historyList = [];
    _historyList.addAll(searchProductServiceInterface!.getSavedSearchProductName());

  }

  int selectedSearchedProductId = 0;
  void setSelectedProductId(int index, int? compareId){
    if(suggestionModel!.products!.isNotEmpty){
      selectedSearchedProductId = suggestionModel!.products![index].id!;
    }
    if(compareId != null){
      Provider.of<CompareController>(Get.context!, listen: false).replaceCompareList(compareId ,selectedSearchedProductId);
    }else{
      Provider.of<CompareController>(Get.context!, listen: false).addCompareList(selectedSearchedProductId);
    }
    notifyListeners();
  }

  void saveSearchAddress(String searchAddress) async {
    searchProductServiceInterface!.saveSearchProductName(searchAddress);
    if (!_historyList.contains(searchAddress)) {
      _historyList.add(searchAddress);
    }
    notifyListeners();
  }

  void clearSearchAddress() async {
    searchProductServiceInterface!.clearSavedSearchProductName();
    _historyList = [];
    notifyListeners();
  }

  void setInitialFilerData(){
    _filterIndex = 0;
  }
}
