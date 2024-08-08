import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/domain/models/order_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/domain/services/order_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';



class OrderController with ChangeNotifier {
  final OrderServiceInterface orderServiceInterface;
  OrderController({required this.orderServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<OrderModel>? orderModel=[];
  List<OrderModel>? deliveredOrderModel=[];
  Future<void> getOrderList(int offset, String status, {String? type}) async {
    // if(offset == 1){
    //   orderModel = null;
    // }
    deliveredOrderModel =[];
    orderModel =[];
    ApiResponse apiResponse = await orderServiceInterface.getOrderList(offset, status, type: type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data! .forEach((order){
        deliveredOrderModel!.add( OrderModel.fromJson(order));
        orderModel!.add( OrderModel.fromJson(order));
      });
      // if(offset == 1){
      //   orderModel = OrderModel.fromJson(apiResponse.response?.data);
      //   if(type == 'reorder'){
      //     deliveredOrderModel = OrderModel.fromJson(apiResponse.response?.data);
      //   }
      // }else {
      //   orderModel!.orders!.addAll(OrderModel.fromJson(apiResponse.response?.data).orders!);
      //   orderModel!.offset = OrderModel.fromJson(apiResponse.response?.data).offset;
      //   orderModel!.totalSize = OrderModel.fromJson(apiResponse.response?.data).totalSize;
      // }
    }else{
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  int _orderTypeIndex = 0;
  int get orderTypeIndex => _orderTypeIndex;

  String selectedType = 'ongoing';
  List<OrderModel> selectTypeOrders=[];

  void setIndex(int index,BuildContext context, {bool notify = true})async {

    selectTypeOrders =[];
    _orderTypeIndex = index;
    if(_orderTypeIndex == 0){
      selectTypeOrders.addAll(orderModel!.reversed);
      // selectedType = 'ongoing';
      // getOrderList(1, 'ongoing');
    }else if(_orderTypeIndex == 1){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
if(element.orderStatus==getTranslated('pending', context)||element.orderStatus=='new'||element.orderStatus=='pending_payment'){
  selectTypeOrders.add(element);
}
        }}
      // selectedType = 'delivered';
      // getOrderList(1, 'delivered');
    }else if(_orderTypeIndex == 2){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('confirmed', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 3){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('processing', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 4){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('out_for_delivery', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 5){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus=='delivered'){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 6){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('failed', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 7){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('returned', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }else if(_orderTypeIndex == 8){
      selectTypeOrders=[];
      if(orderModel!=null){
        for (var element in orderModel!.reversed) {
          if(element.orderStatus==getTranslated('CANCELED', context)){
            selectTypeOrders.add(element);
          }
        }}
      // selectedType = 'canceled';
      // getOrderList(1, 'canceled');
    }
    if(notify) {
      notifyListeners();
    }
  }


  OrderModel? trackingModel;
  Future<void> initTrackingInfo(String orderID) async {
      ApiResponse apiResponse = await orderServiceInterface.getTrackingInfo(orderID);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        // trackingModel = Orders.fromJson(apiResponse.response!.data);
      }
      notifyListeners();
  }


  Future<ApiResponse> cancelOrder(BuildContext context, int? orderId) async {
    _isLoading = true;
    ApiResponse apiResponse = await orderServiceInterface.cancelOrder(orderId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoading = false;

    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  int _selectType=0;
  int get selectType=>_selectType;
  void getOrderType(int index){
    _selectType =index;
    notifyListeners();
  }

}
