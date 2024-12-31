import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/services/category_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:provider/provider.dart';

class CategoryController extends ChangeNotifier {
  final CategoryServiceInterface? categoryServiceInterface;
  CategoryController({required this.categoryServiceInterface});


  List<CategoryModel> _categoryList = [];
  int? _categorySelectedIndex;

  List<CategoryModel> get categoryList => _categoryList;
  int? get categorySelectedIndex => _categorySelectedIndex;
  // CategoryModel? _allProduct;
  // CategoryModel? get allProduct=>_allProduct;
  Future<void> getCategoryList(bool reload) async {
    if (_categoryList.isEmpty || reload) {
      _categoryList.clear();
      brandCategoryList.clear();
      ApiResponse apiResponse = await categoryServiceInterface!.getList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {


        apiResponse.response!.data.forEach((category) {

          _categoryList.add(CategoryModel.fromJson(category));
        });
        apiResponse.response!.data.forEach((category) => brandCategoryList.add(CategoryModel.fromJson(category)));
        _categorySelectedIndex = 0;
        // for(CategoryModel elm in _categoryList){
          // if(elm.id==0){
          //   _allProduct=elm;
          //   break;
          // }

        // }
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }
  }

  void emptyCategory(){
    _categoryList = [];
    notifyListeners();
  }

  Future<void> getSellerWiseCategoryList(int sellerId) async {
    _categoryList.clear();
    _brandCategoryList.clear();
    debugPrint("lengthhhhhhhhhhhhh"+categoryList.length.toString());

    ApiResponse apiResponse = await categoryServiceInterface!.getSellerWiseCategoryList(sellerId);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

        apiResponse.response!.data.forEach((category) => _categoryList.add(CategoryModel.fromJson(category)));
        apiResponse.response!.data.forEach((category) => _brandCategoryList.add(CategoryModel.fromJson(category)));
        _categorySelectedIndex = 0;
      } else {
        ApiChecker.checkApi( apiResponse);
      }
    debugPrint("lengthhhhhhhhhhhhh"+categoryList.length.toString());

    notifyListeners();
  }

  final List<int> _selectedCategoryIds = [];
  List<int> get selectedCategoryIds => _selectedCategoryIds;
  String? selectId;
  bool? isBrand=false;

  void checkedToggleCategory(int index,bool brand){
    selectId= index.toString();
    isBrand=brand;
    notifyListeners();
  }

  void checkedToggleSubCategory(int index, int subCategoryIndex){
    // _categoryList[index].subCategories![subCategoryIndex].isSelected = !_categoryList[index].subCategories![subCategoryIndex].isSelected!;
    notifyListeners();
  }

  Future<void> resetChecked(int? id, bool fromShop) async{
    if(fromShop){
      await getSellerWiseCategoryList(id!);
      Provider.of<BrandController>(Get.context!, listen: false).getSellerWiseBrandList(id);
      // Provider.of<SellerProductController>(Get.context!, listen: false).getSellerProductList(id.toString(), 1, "",);
    }else{
      await getCategoryList(true);
      Provider.of<BrandController>(Get.context!, listen: false).getBrandList(true,1);
    }


  }

  void changeSelectedIndex(int selectedIndex) {
    _categorySelectedIndex = selectedIndex;
    notifyListeners();
  }
  List<CategoryModel> _searchCategoryList = [];
  List<CategoryModel> get searchCategoryList =>_searchCategoryList;
  void search(String val){
    _searchCategoryList=[];
    notifyListeners();
    if(categoryList.isNotEmpty){
      for (var element in categoryList) {
        if(element.name.contains(val)){
          print('object');

          _searchCategoryList.add(element);
          notifyListeners();
        }
      }
    }
  }
  void clear(){
    _searchCategoryList=[];
    _searchCategoryList.addAll(categoryList);
  }
  final List<CategoryModel> _brandCategoryList = [];
  // int? _categorySelectedIndex;

  List<CategoryModel> get brandCategoryList => _brandCategoryList;
  Future<bool> getBrandCategoryList(int id) async {

      ApiResponse apiResponse = await categoryServiceInterface!.get(id.toInt());
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _brandCategoryList.clear();
        // if(_allProduct!=null){
        // _brandCategoryList.add(_allProduct!);
        // }

        apiResponse.response!.data.forEach((category) => _brandCategoryList.add(CategoryModel.fromJson(category)));
        _categorySelectedIndex = 0;
        notifyListeners();

        return true;
      } else {
        ApiChecker.checkApi( apiResponse);
        return false;

      }
    // }
  }


}
