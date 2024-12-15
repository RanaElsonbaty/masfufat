import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/domain/services/my_shop_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';

import '../domain/model/model.dart';

class MyShopController extends ChangeNotifier {
  final MyShopServiceInterface myShopServiceInterface;
  MyShopController({required this.myShopServiceInterface});

  bool _switch1=false;
  bool _switch2=false;
  bool _switch3=false;
  bool get switch1=>_switch1;
  bool get switch2=>_switch2;
  bool  get switch3=>_switch3;
  TextEditingController taxController=TextEditingController(text: '20');
  void getSwitchState(int index,bool val){
    if(index==0){
      _switch1=val;
    }else if(index==1){
      _switch2=val;

    }else if(index==2){
      _switch3=val;

    }
    notifyListeners();
  }




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
  List<Deleted> _pendingList=[];
  List<Deleted> get pendingList=>_pendingList;
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
    _pendingList=[];
    _deleteList=[];
    _linkedList=[];
    _isLoading=true;
  if(response.response!=null&&response.response!.statusCode==200){
 // try{
   if( response.response!.data['pending']!=null) {
     response.response!.data['pending'].forEach((pending) {
       _pendingList.add(Deleted.fromJson(pending));
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
   await initController();
 // }catch(e){
 //   print('getList shop list error ---> $e');
 // }
    _isLoading=false;

    notifyListeners();

  }
  }
  List<Deleted> _pendingListSearch=[];
  List<Deleted> get pendingListSearch=>_pendingListSearch;
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
  Future resyncProduct(int id)async{
    ApiResponse response =await myShopServiceInterface.resyncProduct(id);
    if(response.response!=null&&response.response!.statusCode==200){
getList();
notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  Future<bool> addProduct(int id)async{
   try{
     ApiResponse response =await myShopServiceInterface.addProduct(id);
     if(response.response!=null&&response.response!.statusCode==200){
       if(response.response!.data.toString()!='1'){
         showCustomSnackBar(response.response!.data, Get.context!);

         return false;
       }else{
       }
       return true;
     }else{
       showCustomSnackBar(response.response!.data, Get.context!);

       return false;
     }
   }catch(e){
     showCustomSnackBar(e.toString(), Get.context!);

     return false;

   }
  }


  List<TextEditingController> controller=[];
  bool selectAll=false;
  List<int> selectIds=[];
  void selectOneProduct(int id, bool add){

    if(add){
      selectIds.add(id);
      if(selectIds.length==_pendingList.length){
        selectAll=true;

      }
    }else{
      selectIds.remove(id);
      selectAll=false;
    }


    notifyListeners();
  }
  void clearSelect(){
    selectIds=[];
    selectAll=false;
    notifyListeners();

  }
  void getSelectProduct(int index){
    selectIds=[];
    selectAll=!selectAll;
    if(selectAll==true){
      if(index==0){
    for (var element in _pendingList) {
      if(selectIds.contains(element.id)){
      }else{
        selectIds.add(element.id);

      }
    }
      }else if(index==1){
        for (var element in _linkedList) {
          if(selectIds.contains(element.id)){
          }else{
            selectIds.add(element.id);

          }
        }
      }else{
        for (var element in _deleteList) {
          if(selectIds.contains(element.id)){
          }else{
            selectIds.add(element.id);

          }
        }
      }
    }else{
      selectIds =[];
    }
    notifyListeners();
  }

  Future initController() async {
    _isLoading=true;
     notifyListeners();
    controller=List.filled(_pendingList.length, TextEditingController());
    for (int i=0;i<_pendingList.length;i++) {
      controller[i]=TextEditingController(text: _pendingList[i].linkedProduct.price>0?_pendingList[i].linkedProduct.price.toString():_pendingList[i].pricings.suggestedPrice.toString());
    }
    _isLoading=false;
    notifyListeners();
  }

  Future addProductPrice(int id,String price)async{
    ApiResponse response =await myShopServiceInterface.addPriceToProduct(id,price);
    if(response.response!=null&&response.response!.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  /// sync all product one time
  Future syncProduct(bool sync,bool update)async{
    ApiResponse response =await myShopServiceInterface.syncProduct(sync,update);
    if(response.response!=null&&response.response!.statusCode==200){
      print('sync product res ---> ${response.response!.data}');

if(response.response!.data.toString()=='1'){
  return true;

}else{
  String error ='${response.response!.data['error']['fields']['sku']} \n sku : ${response.response!.data['sku'].toString()}';
  showCustomSnackBar(error, Get.context!,time: 3);

  return false;

}
    }else{

      return false;
    }
  }
  /// sync one product
  Future syncOneProduct(bool sync,int id,bool update)async{
    ApiResponse response =await myShopServiceInterface.syncOneProduct(sync,id,update);
    if(response.response!=null&&response.response!.statusCode==200){
      print('sync product res ---> ${response.response!.data}');

if(response.response!.data.toString()=='1'){
  return true;

}else{
  String error ='${response.response!.data['error']['fields']['sku']} \n sku : ${response.response!.data['sku'].toString()}';
  showCustomSnackBar(error, Get.context!,time: 3);

  return false;

}
    }else{

      return false;
    }
  }

int? _selectFilter=0;
int? get selectFilter=>_selectFilter;
  void getSelectFilter(int index){

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
        if(element.linkedProduct.deletionReason=='pending review'){
          _deleteListSearch.add(element);
        }
      }else if(index==2){
        if(element.linkedProduct.deletionReason=='not available'){
          _deleteListSearch.add(element);
        }
      }else{
        if(element.linkedProduct.deletionReason=='deleted'){
          _deleteListSearch.add(element);
        }
      }
    }
    notifyListeners();
  }
  bool _allListEmpty=false;
  bool get allListEmpty=>_allListEmpty;
  Future loadDataIfEmpty()async{
    if(_pendingList.isEmpty){
      _allListEmpty=true;
    } if(_linkedList.isEmpty){
      _allListEmpty=true;
    } if(_deleteList.isEmpty){
      _allListEmpty=true;
    }if(_pendingList.isNotEmpty){
      _allListEmpty=false;
    } if(_linkedList.isNotEmpty){
      _allListEmpty=false;
    } if(_deleteList.isNotEmpty){
      _allListEmpty=false;
    }
    if(_allListEmpty){
     await getList();
    }
  }
}
