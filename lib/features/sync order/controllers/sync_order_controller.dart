import 'package:camera/camera.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../domain/models/Sync_order_model.dart';
import '../domain/models/sync_order_details.dart';
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
    if(index==0){
      _type ='all';
    }
    else if(index==1){
      _type ='pending';

    }
    else if(index==2){
      _type ='pending_payment';

    }
    else if(index==3){
      _type ='financial_review';

    }
    else if(index==4){
      _type ='new';

    }
    else if(index==5){
      _type ='processing';

    }
    else if(index==6){
      _type ='confirmed';

    }
    else if(index==7){
      _type ='out_for_delivery';

    }
    else if(index==8){
      _type ='delivered';

    }
    else if(index==9){
      _type ='failed';

    }
    else if(index==10){
      _type ='returning';

    }
    else if(index==11){
      _type ='returned';

    }
    else if(index==12){
      _type ='canceled';

    }
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

  SyncOrderDetailsModel? _syncOrderDetails;
  SyncOrderDetailsModel? get syncOrderDetails=>_syncOrderDetails;
  bool _isDetailsLoading=false;
  bool get isDetailsLoading=>_isDetailsLoading;
  Future getOrderDetailsList(String id) async {
    _isDetailsLoading=true;
    _syncOrderDetails=null;
    ApiResponse apiResponse = await syncOrderServiceInterface.getOrderDeteilsList(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  _syncOrderDetails=SyncOrderDetailsModel.fromJson(apiResponse.response!.data);

    _isDetailsLoading=false;
      notifyListeners();
    } else {
      ApiChecker.checkApi( apiResponse);
      _isDetailsLoading=false;

      notifyListeners();


    }
  }
  bool _paymentLoading=false;
  bool get paymentLoading=>_paymentLoading;
  void getLoading(bool val){
    _paymentLoading =val;
    notifyListeners();
  }
  Future<ApiResponse> placeSyncWalletOrder(String id) async {
    _isDetailsLoading=true;
    _syncOrderDetails=null;
    ApiResponse apiResponse = await syncOrderServiceInterface.placeSyncWalletOrder(id);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      notifyListeners();
      return ApiResponse.withSuccess(apiResponse.response!);
    } else  {
    return ApiResponse.withError(apiResponse.error);


    }
  }
  // Future<ApiResponse> placeBankTransferOrder(String id,int addressId,String paymentMethod) async {
  //   _isDetailsLoading=true;
  //   _syncOrderDetails=null;
  //   ApiResponse apiResponse = await syncOrderServiceInterface.placeBankTransferOrder(id,paymentMethod,addressId);
  //   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //
  //     notifyListeners();
  //     return ApiResponse.withSuccess(apiResponse.response!);
  //   } else  {
  //   return ApiResponse.withError(apiResponse.error);
  //
  //
  //   }
  // }
  Future<ApiResponse> placeSyncOrderCashOnDelivery(String id,String couponCode,String couponDiscount,String orderNode , int addressId) async {
    _isDetailsLoading=true;
    _syncOrderDetails=null;
    ApiResponse apiResponse = await syncOrderServiceInterface.placeSyncOrderCashOnDelivery(id,couponCode,couponDiscount,orderNode,addressId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      notifyListeners();
      return ApiResponse.withSuccess(apiResponse.response!);
    } else  {
    return ApiResponse.withError(apiResponse.error);


    }
  }
  int _userTypeIndex = 0;

  int get userTypeIndex => _userTypeIndex;

  void setUserTypeIndex(BuildContext context, int index) {
    _userTypeIndex = index;
    // getChatList(context, 1);
    notifyListeners();
  }

  Future<ApiResponse> bankAndDelayedPayment(String orderID, String paymentMethod, String bank, String holderName, int addressId, BuildContext context, XFile? attachment,) async {
    ApiResponse apiResponse =

      await syncOrderServiceInterface.bankAndDelayedPayment(
        orderID,
        paymentMethod,
        bank,
        holderName,
        addressId,
        attachment!,
      );

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      return ApiResponse.withSuccess(apiResponse.response!);
    } else {
      ApiChecker.checkApi( apiResponse);
      notifyListeners();

      return ApiResponse.withError(apiResponse.error);
    }
  }
  Future<ApiResponse> placeSyncDelayedOrder(String id, String addressId, String couponCode, String couponDiscount, String orderNote) async {
    notifyListeners();

    ApiResponse apiResponse =

      await syncOrderServiceInterface.placeSyncDelayedOrder(
        id,
        addressId,
        couponCode,
        couponDiscount,
        orderNote,

      );

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      return ApiResponse.withSuccess(apiResponse.response!);
    } else {
      ApiChecker.checkApi( apiResponse);
      notifyListeners();

      return ApiResponse.withError(apiResponse.error);
    }
  }

}
