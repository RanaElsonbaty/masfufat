import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/find_what_you_need.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/home_category_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/most_demanded_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/services/product_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/enums/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:open_document/my_files/init.dart';
import 'package:provider/provider.dart';

class ProductController extends ChangeNotifier {
  final ProductServiceInterface? productServiceInterface;
  ProductController({required this.productServiceInterface});

  List<Product>? _latestProductList = [];
  List<Product>? _lProductList;
  List<Product>? get lProductList=> _lProductList;
  List<Product>? _featuredProductList;



  ProductType _productType = ProductType.newArrival;
  String? _title = '${getTranslated('best_selling', Get.context!)}';

  bool _filterIsLoading = false;
  bool _filterFirstLoading = true;

  bool _isLoading = false;
  bool _isFeaturedLoading = false;
  bool get isFeaturedLoading => _isFeaturedLoading;
  bool _firstFeaturedLoading = true;
  bool _firstLoading = true;
  int? _latestPageSize = 1;
  int _lOffset = 1;
  int? _lPageSize;
  int? get lPageSize=> _lPageSize;
  int? _featuredPageSize;
  int _lOffsetFeatured = 1;


  ProductType get productType => _productType;
  String? get title => _title;
  int get lOffset => _lOffset;
  int get lOffsetFeatured => _lOffsetFeatured;


  List<int> _offsetList = [];
  List<String> _lOffsetList = [];
  List<String> get lOffsetList=>_lOffsetList;
  List<String> _featuredOffsetList = [];

  List<Product>? get latestProductList => _latestProductList;
  List<Product>? get featuredProductList => _featuredProductList;

  Product? _recommendedProduct;
  Product? get recommendedProduct=> _recommendedProduct;

  bool get filterIsLoading => _filterIsLoading;
  bool get filterFirstLoading => _filterFirstLoading;
  bool get isLoading => _isLoading;
  bool get firstFeaturedLoading => _firstFeaturedLoading;
  bool get firstLoading => _firstLoading;
  int? get latestPageSize => _latestPageSize;
  int? get featuredPageSize => _featuredPageSize;

  ProductModel? _discountedProductModel;
  ProductModel? get discountedProductModel => _discountedProductModel;


  bool filterApply = false;

  void isFilterApply (bool apply, {bool reload = false}){
    filterApply = apply;
    if(reload){
      notifyListeners();
    }

  }


  Future<void> getLatestProductList(int offset, {bool reload = false}) async {
    if(reload || offset == 1) {
      _offsetList = [];
      _latestProductList = null;
    }
    _lOffset = offset;
    if(!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      ApiResponse apiResponse = await productServiceInterface!.getFilteredProductList(Get.context!, offset.toString(), _productType, title);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        if(offset==1){
          _latestProductList = [];
        }

          if(apiResponse.response!.data != null){
            apiResponse.response!.data['products']['data'].forEach((product){
              _latestProductList!.add(Product.fromJson(product));
            });
            _latestPageSize = apiResponse.response!.data['products']['total'];

          //   _latestProductList!.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
          }

          _filterFirstLoading = false;
          _filterIsLoading = false;
          _filterIsLoading = false;
          removeFirstLoading();
      } else {

        if(reload || offset == 1) {
          _latestProductList = [];
        }
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }else {
      if(_filterIsLoading) {
        _filterIsLoading = false;
        notifyListeners();
      }
    }

  }



  //latest product
  Future<void> getLProductList(String offset, {bool reload = false}) async {
    if(reload) {
      _lOffsetList = [];
      _lProductList = [];
    }
    if(!_lOffsetList.contains(offset)) {
      _lOffsetList.add(offset);
      ApiResponse apiResponse = await productServiceInterface!.getLatestProductList(offset);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _lProductList = [];
        _lProductList?.addAll(ProductModel.fromJson(apiResponse.response!.data).products??[]);
        _lPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
        _firstLoading = false;
        _isLoading = false;
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }else {
      if(_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
    }

  }


  List<ProductTypeModel> productTypeList = [
    ProductTypeModel('new_arrival', ProductType.newArrival),
    ProductTypeModel('top_product', ProductType.topProduct),
    ProductTypeModel('best_selling', ProductType.bestSelling),
    ProductTypeModel('discounted_product', ProductType.discountedProduct),
  ];

  
int selectedProductTypeIndex = 0;
 void changeTypeOfProduct(ProductType type, String? title, {int index = 0}){
    _productType = type;
    _title = title;
    _latestProductList = null;
    _latestPageSize = 1;
    _filterFirstLoading = true;
    _filterIsLoading = true;
    selectedProductTypeIndex = index;
    getLatestProductList(1, reload: true);
    notifyListeners();
 }

  void showBottomLoader() {
    _isLoading = true;
    _filterIsLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }


  TextEditingController sellerProductSearch = TextEditingController();
  void clearSearchField( String id){
    sellerProductSearch.clear();
    notifyListeners();
  }




   List<Product> _brandOrCategoryProductList = [];
  bool? _hasData;
  int _productCount=0;
  int get productCount=>_productCount;
  List<Product> get brandOrCategoryProductList => _brandOrCategoryProductList;
  bool? get hasData => _hasData;
  Future<List<Product>> initBrandOrCategoryProductList(bool isBrand,int brandId, String id, BuildContext context,int offset,bool reloud,String search,String syncFilter,String filter,String price,bool onlyBrand) async {
      _brandOrCategoryProductList =[];
      // _productCount=0;
    ApiResponse apiResponse = await productServiceInterface!.getBrandOrCategoryProductList(isBrand,brandId, id,offset,reloud,search,syncFilter,filter,price, onlyBrand);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     try{
       _productCount =apiResponse.response!.data['count'];
       notifyListeners();
     }catch(E){
       print(E);
     }
      apiResponse.response!.data['products']['data'].forEach((product) => _brandOrCategoryProductList.add(Product.fromJson(product)));
      return _brandOrCategoryProductList;
    } else {
      ApiChecker.checkApi( apiResponse);
      return [];
    }
  }


  List<Product>? _relatedProductList;
  List<Product>? get relatedProductList => _relatedProductList;

  void initRelatedProductList(String id, BuildContext context) async {
    ApiResponse apiResponse = await productServiceInterface!.getRelatedProductList(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _relatedProductList = [];
      apiResponse.response!.data.forEach((product) => _relatedProductList!.add(Product.fromJson(product)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  List<Product>? _moreProductList;
  List<Product>? get moreProductList => _moreProductList;

  void getMoreProductList(String id) async {
    ApiResponse apiResponse = await productServiceInterface!.getRelatedProductList(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _relatedProductList = [];
      apiResponse.response!.data.forEach((product) => _relatedProductList!.add(Product.fromJson(product)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  void removePrevRelatedProduct() {
    _relatedProductList = null;
  }


  int featuredIndex = 0;
  void setFeaturedIndex(int index){
    featuredIndex = index;
    notifyListeners();
  }



  Future<void> getFeaturedProductList(String offset, {bool reload = false}) async {
    if(reload) {
      _featuredOffsetList = [];
      _featuredProductList = [];
    }
    if(!_featuredOffsetList.contains(offset)) {
      _featuredOffsetList.add(offset);
      _lOffsetFeatured = int.parse(offset);
      ApiResponse apiResponse = await productServiceInterface!.getFeaturedProductList(offset);
      if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
        if (offset == '1') {
          _featuredProductList = [];
          if(apiResponse.response!.data['products'] != null) {
            _featuredProductList?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
            _featuredPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
          }
          _firstFeaturedLoading = false;
        } else {
          _featuredPageSize = ProductModel.fromJson(apiResponse.response!.data).totalSize;
          _featuredProductList?.addAll(ProductModel.fromJson(apiResponse.response!.data).products!);
        }
        _isFeaturedLoading = false;
        _filterIsLoading = false;
      } else {
        ApiChecker.checkApi( apiResponse);
      }

      notifyListeners();
    }else {
      if(_isFeaturedLoading) {
        _isFeaturedLoading = false;
        notifyListeners();
      }
    }
  }


  bool recommendedProductLoading = false;
  Future<void> getRecommendedProduct() async {
    ApiResponse apiResponse = await productServiceInterface!.getRecommendedProduct();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     try{
       if(apiResponse.response!.data!=[]||apiResponse.response!.data!={}||apiResponse.response!.data!=''){
         _recommendedProduct = Product.fromJson(apiResponse.response!.data);

       }
     }catch(e){
       print(e);

     }
      }
      notifyListeners();
  }


   List<Datum>? _homeCategoryProductList ;
  List<Datum>? get homeCategoryProductList => _homeCategoryProductList;
  bool _pageEnd=false;
  bool get pageEnd=>_pageEnd;
  void initPageEnd(){
    if(_homeCategoryProductList!=null&&_homeCategoryProductList!.isEmpty){
      _pageEnd=false;
      notifyListeners();
    }
  }
  Future<bool> getHomeCategoryProductList(bool reload,int page) async {
  // if (_homeCategoryProductList.isEmpty || reload) {

    _pageEnd=false;
    ApiResponse apiResponse = await productServiceInterface!.getHomeCategoryProductList(page);
    if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response!.data.toString() != '{}'){
        if(page==1){
          _homeCategoryProductList=[];
          apiResponse.response!.data['data'].forEach((elm){
            _homeCategoryProductList!.add(Datum.fromJson(elm));
            notifyListeners();


          });

        }else{
          if(apiResponse.response!.data['data']!=null&&apiResponse.response!.data['data'].isNotEmpty){
            apiResponse.response!.data['data'].forEach((elm){
              _homeCategoryProductList!.add(Datum.fromJson(elm));
              notifyListeners();

            });
          }else{
            _pageEnd=true;
            return false;
          }
notifyListeners();
        }
        notifyListeners();


        return true;
    } else {
      ApiChecker.checkApi( apiResponse);
      notifyListeners();

      return false;

    }
  }else{
      return false;
    }
  }

  MostDemandedProductModel? mostDemandedProductModel;
  Future<void> getMostDemandedProduct() async {
    ApiResponse apiResponse = await productServiceInterface!.getMostDemandedProduct();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response?.data != null && apiResponse.response?.data.isNotEmpty && apiResponse.response?.data != '[]'){
        mostDemandedProductModel = MostDemandedProductModel.fromJson(apiResponse.response!.data);
      }

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  FindWhatYouNeedModel? findWhatYouNeedModel;
  Future<void> findWhatYouNeed() async {
    ApiResponse apiResponse = await productServiceInterface!.getFindWhatYouNeed();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      findWhatYouNeedModel = FindWhatYouNeedModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  List<Product>? justForYouProduct;
  Future<void> getJustForYouProduct() async {
    justForYouProduct = [];
    ApiResponse apiResponse = await productServiceInterface!.getJustForYouProductList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    apiResponse.response?.data.forEach((justForYou)=> justForYouProduct?.add(Product.fromJson(justForYou)));
    }
    notifyListeners();
  }

  ProductModel? mostSearchingProduct;
  Future<void> getMostSearchingProduct(int offset, {bool reload = false}) async {
    ApiResponse apiResponse = await productServiceInterface!.getMostSearchingProductList(offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      if(apiResponse.response?.data['products'] != null && apiResponse.response?.data['products'] != 'null'){
        if(offset == 1) {
          mostSearchingProduct = ProductModel.fromJson(apiResponse.response?.data);
        }else {
          mostSearchingProduct!.products!.addAll(ProductModel.fromJson(apiResponse.response?.data).products!);
          mostSearchingProduct!.offset = ProductModel.fromJson(apiResponse.response?.data).offset;
          mostSearchingProduct!.totalSize = ProductModel.fromJson(apiResponse.response?.data).totalSize;
        }
      }


    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();


  }

  int currentJustForYouIndex = 0;
  void setCurrentJustForYourIndex(int index){
    currentJustForYouIndex = index;
    notifyListeners();
  }

  Future<void> getDiscountedProductList(int offset, bool reload, { bool isUpdate = true}) async {

    if(reload) {
      _discountedProductModel = null;

      if(isUpdate) {
        notifyListeners();
      }
    }

    ApiResponse apiResponse = await productServiceInterface!.getFilteredProductList(Get.context!, offset.toString(), ProductType.discountedProduct, title);

    if (apiResponse.response?.data != null && apiResponse.response?.statusCode == 200) {
      if(offset == 1){
        _discountedProductModel = ProductModel.fromJson(apiResponse.response?.data);
      } else {
        _discountedProductModel?.totalSize = ProductModel.fromJson(apiResponse.response?.data).totalSize;
        _discountedProductModel?.offset = ProductModel.fromJson(apiResponse.response?.data).offset;
        _discountedProductModel?.products?.addAll(ProductModel.fromJson(apiResponse.response?.data).products ?? []);
      }

      notifyListeners();

    } else {
      ApiChecker.checkApi(apiResponse);

    }

  }

List<int> productSelect=[];
 Future selectProduct(int ids,bool remove)async{
     if(productSelect.contains(ids)){
       if(remove){
         productSelect.remove(ids);
       }
     }else{
       productSelect.add(ids);
     }
   notifyListeners();
 }
 Future clearSelectProduct({bool notify=true})async{
   productSelect=[];
   if(notify){
   notifyListeners();}
 }
  double value=0;

  double calculatePercentage(int index,int len) {
    double percentage =(index / len);

    return double.parse(percentage.toStringAsFixed(2));
  }
  bool _addSyncLoading=false;
  bool get addSyncLoading=>_addSyncLoading;
Future addProductToSync()async{
  _addSyncLoading=true;
  MyShopController myShop=Provider.of<MyShopController>(Get.context!,listen: false);
  for (int i=0;i<productSelect.length;i++) {
  try{
    await myShop.addProduct(productSelect[i]).then((val) {
      if(val==false){

        showCustomSnackBar('${getTranslated('Product_sync_failed',Get.context!)} id = ${productSelect[i]}', Get.context!);
      }
      if(i!=0){
        value= calculatePercentage(i,productSelect.length);
        notifyListeners();

      }
    });
  }catch(e){
    showCustomSnackBar(e.toString(), Get.context!,time: 3);
  }

  }


  notifyListeners();
}
void clear()async{
  value=0;
  productSelect=[];
  _addSyncLoading=false;
await Provider.of<MyShopController>(Get.context!,listen: false).getList();

  notifyListeners();
}

}

class ProductTypeModel{
  String? title;
  ProductType productType;

  ProductTypeModel(this.title, this.productType);
}

