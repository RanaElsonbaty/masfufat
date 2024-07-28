import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/repositories/My_Shop_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/services/my_shop_service_interface.dart';

class MyShopController extends ChangeNotifier {
  final MyShopServiceInterface myShopServiceInterface;
  MyShopController({required this.myShopServiceInterface});

  int _selectIndex=0;
  int get selectIndex=>_selectIndex;
  void selectType(int val)async{
    _selectIndex = val;
    notifyListeners();
  }
  bool _isSearch=false;
  bool get isSearch=>_isSearch;
  void getSearch(){
    _isSearch =!_isSearch;
    notifyListeners();
  }

}
