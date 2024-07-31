import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../domain/models/Sync_order_model.dart';
import '../domain/services/sync_order_service_interface.dart';



class SyncOrderController with ChangeNotifier {
  final SyncOrderServiceInterface syncOrderServiceInterface;
  SyncOrderController({required this.syncOrderServiceInterface});
  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;
  String _type ='all';
  String get type =>_type;
  void setIndex(int index,String type, {bool notify = true})async {
    _orderTypeIndex = index;
    _type =type=='All_Order'?'all':type;
    // getOrderList(type=='All_Order'?'all':type,'1');

    if(notify) {
      notifyListeners();
    }
  }
   List<SyncOrderModel> _orderList=[];
  List<SyncOrderModel> get orderList=>_orderList;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  Future<List<SyncOrderModel>> getOrderList(String type , String page) async {
    _isLoading=true;
    _orderList =[];
    ApiResponse apiResponse = await syncOrderServiceInterface.getOrderList(type, page);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data['orders'].forEach((elm) {
        _orderList.add(SyncOrderModel.fromJson(elm));
      });
      _isLoading=false;

      notifyListeners();
      return _orderList;
    } else {
      ApiChecker.checkApi( apiResponse);
      _isLoading=false;

      notifyListeners();

      return [];

    }
  }

  SyncOrderModel? _syncOrderDetails;
  SyncOrderModel? get syncOrderDetails=>_syncOrderDetails;
  bool _isDetailsLoading=false;
  bool get isDetailsLoading=>_isDetailsLoading;
  Future getOrderDetailsList(String id) async {
    _isDetailsLoading=true;
    _syncOrderDetails=null;
    ApiResponse apiResponse = await syncOrderServiceInterface.getOrderDeteilsList(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  _syncOrderDetails=SyncOrderModel.fromJson(apiResponse.response!.data);

    _isDetailsLoading=false;
      notifyListeners();
    } else {
      ApiChecker.checkApi( apiResponse);
      _isDetailsLoading=false;

      notifyListeners();


    }
  }

}
