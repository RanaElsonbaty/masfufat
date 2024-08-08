import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/services/my_shop_service_interface.dart';

import '../domain/model/model.dart';

class MyShopController extends ChangeNotifier {
  final MyShopServiceInterface myShopServiceInterface;
  MyShopController({required this.myShopServiceInterface});

  int _selectIndex=0;
  int get selectIndex=>_selectIndex;
  void selectType(int val)async{
    clearSearch();
    selectIds=[];
    selectAll=false;
    _selectIndex = val;
    notifyListeners();
  }
  bool _isSearch=false;
  bool get isSearch=>_isSearch;
  void getSearch(){
    _isSearch =!_isSearch;
    if(_isSearch==false){
      _searchActive=false;
    }
    notifyListeners();
  }
  List<Pending> _pendingList=[];
  List<Pending> get pendingList=>_pendingList;
  List<Linked> _linkedList=[];
  List<Linked> get linkedList=> _linkedList;
  List<Linked> _deleteList=[];
  List<Linked> get deleteList=> _deleteList;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  Future getList()async{
    _pendingList=[];
    _deleteList=[];
    _linkedList=[];
    _isLoading=true;
    ApiResponse response= await myShopServiceInterface.getList();
  if(response.response!=null&&response.response!.statusCode==200){
    if( response.response!.data['pending']!=null) {
      response.response!.data['pending'].forEach((pending) {
        _pendingList.add(Pending.fromJson(pending));
      });
    }
    notifyListeners();
    if( response.response!.data['linked']!=null) {
      response.response!.data['linked'].forEach((linked) {
        _linkedList.add(Linked.fromJson(linked));
      });
    }
    notifyListeners();

    if( response.response!.data['deleted']!=null){
    response.response!.data['deleted'].forEach((delete){
      _deleteList.add(Linked.fromJson(delete));
    });
    }
    _isLoading=false;

    notifyListeners();

  }
  }
  List<Pending> _pendingListSearch=[];
  List<Pending> get pendingListSearch=>_pendingListSearch;
  List<Linked> _linkedListSearch=[];
  List<Linked> get linkedListSearch=> _linkedListSearch;
  List<Linked> _deleteListSearch=[];
  List<Linked> get deleteListSearch=> _deleteListSearch;
bool _searchActive=false;
bool get searchActive=>_searchActive;
    void search(int index,String val){
      _pendingListSearch=[];
      _deleteListSearch=[];
      _linkedListSearch=[];
if(val!=''&&val.isNotEmpty){
  _searchActive=true;
}else{
  _searchActive=false;
  notifyListeners();
  return ;
  }
    if(index==0&&val !=''){
      for (var element in _pendingList) {
        if (element.itemNumber.toString().contains(val) ||
            element.name.toString().contains(val) ||
            element.code.toString().contains(val)) {
          _pendingListSearch.add(element);
        }
      }
    }else if(index==1&&val!=''){
      for (var element in _linkedList) {
        if (element.itemNumber.toString().contains(val) ||
            element.name.toString().contains(val) ||
            element.code.toString().contains(val)) {
          _linkedListSearch.add(element);
        }
      }
    }else {
      for (var element in _deleteList) {
        if (element.itemNumber.toString().contains(val) ||
            element.name.toString().contains(val) ||
            element.code.toString().contains(val)) {
          _deleteListSearch.add(element);
        }
      }
    }
    notifyListeners();
    }
    void clearSearch(){
      _isSearch=false;
      _searchActive=false;
      _pendingListSearch=[];
      _deleteListSearch=[];
      _linkedListSearch=[];
    }

  Future deleteProduct(int id)async{
    ApiResponse response =await myShopServiceInterface.delete(id);
    if(response.response!=null&&response.response!.statusCode==200){
_pendingList.removeWhere((element) => element.id==id);
selectIds=[];
notifyListeners();
      return true;
    }else{
      return false;
    }
  }
  Future deleteLinkedProduct(int id)async{
    ApiResponse response =await myShopServiceInterface.deleteLinked(id);
    if(response.response!=null&&response.response!.statusCode==200){
_pendingList.removeWhere((element) => element.id==id);
selectIds=[];
notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  Future addProduct(int id)async{
    ApiResponse response =await myShopServiceInterface.addProduct(id);
    if(response.response!=null&&response.response!.statusCode==200){
      if(response.response!.data.toString()!='1'){
       return false;
      }
      return true;
    }else{
      return false;
    }
  }


  List<TextEditingController> controller=[];
  bool selectAll=false;
  List<int> selectIds=[];
  void selectOneProduct(int id, bool add){
    if(add){
      selectIds.add(id);
    }else{
      selectIds.remove(id);
    }
    notifyListeners();
  }
  void getSelectProduct(int index){
    selectIds=[];
    selectAll=!selectAll;
    if(selectAll==true){
      if(index==0){
    for (var element in _pendingList) {
      if(selectIds.contains(element.id!)){
      }else{
        selectIds.add(element.id!);

      }
    }
      }else if(index==1){
        for (var element in _linkedList) {
          if(selectIds.contains(element.id!)){
          }else{
            selectIds.add(element.id!);

          }
        }
      }else{
        for (var element in _deleteList) {
          if(selectIds.contains(element.id!)){
          }else{
            selectIds.add(element.id!);

          }
        }
      }
    }else{
      selectIds =[];
    }
    notifyListeners();
  }

  void initController(){
    controller=List.filled(_pendingList.length, TextEditingController());
    for (int i=0;i<_pendingList.length;i++) {
      controller[i]=TextEditingController(text: _pendingList[i].pricings!.suggestedPrice!.toString());
    }
  }

  Future addProductPrice(int id,String price)async{
    print("asdasdasdasdasdsadds---> $id ///// $price");
    ApiResponse response =await myShopServiceInterface.addPriceToProduct(id,price);
    if(response.response!=null&&response.response!.statusCode==200){
      return true;
    }else{
      return false;
    }
  } Future syncProduct()async{
    ApiResponse response =await myShopServiceInterface.syncProduct();
    if(response.response!=null&&response.response!.statusCode==200){
      print('sync product res ---> ${response.response!.data}');
if(response.response!.data=='1'){
  return true;

}else{
  return false;

}
    }else{
      return false;
    }
  }
//   A1952-GTR-2-BK
int? _selectFilter;
int? get selectFilter=>_selectFilter;
  void getSelectFilter(int index){
    print('object$index');
    if(_selectFilter==index){
      _selectFilter=null;
      _searchActive=false;
    }else{
    _selectFilter= index;
    _searchActive=true;

    }
    for (var element in _deleteList) {
      _deleteListSearch=[];
      if(index==0){
        _searchActive=false;
        _deleteListSearch=[];

      }else if(index==1){
        if(element.linkedProduct!=null&&element.linkedProduct!.deletionReason=='pending review'){
          _deleteListSearch.add(element);
        }
      }else if(index==2){
        if(element.linkedProduct!=null&&element.linkedProduct!.deletionReason=='not available'){
          _deleteListSearch.add(element);
        }
      }else{
        if(element.linkedProduct!=null&&element.linkedProduct!.deletionReason=='deleted'){
          _deleteListSearch.add(element);
        }
      }
    }
    notifyListeners();
  }
}
