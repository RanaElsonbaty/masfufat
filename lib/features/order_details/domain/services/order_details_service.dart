import 'dart:io';

import 'package:flutter_sixvalley_ecommerce/features/order_details/domain/repositories/order_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/domain/services/order_details_service_interface.dart';
import 'package:image_picker/image_picker.dart';

class OrderDetailsService implements OrderDetailsServiceInterface{
  OrderDetailsRepositoryInterface orderDetailsRepositoryInterface;
  OrderDetailsService({required this.orderDetailsRepositoryInterface});



  @override
  Future getOrderFromOrderId(String orderID) async{
    return await orderDetailsRepositoryInterface.getOrderFromOrderId(orderID);
  }

  @override
  Future getOrderDetails(String orderID) async{
    return await orderDetailsRepositoryInterface.get(orderID);
  }

  @override
  Future getOrderInvoice(String orderID) async{
    return await orderDetailsRepositoryInterface.getOrderInvoice(orderID);
  }

  @override
  Future downloadDigitalProduct(int orderDetailsId) async{
    return await orderDetailsRepositoryInterface.downloadDigitalProduct(orderDetailsId);
  }

  @override
  Future verifyDigitalProductOtp(int orderId, String otp) async{
    return await orderDetailsRepositoryInterface.otpVerificationForDigitalProduct(orderId, otp);
  }

  @override
  Future resentDigitalProductOtp(int orderId) async{
    return await orderDetailsRepositoryInterface.resendOtpForDigitalProduct(orderId);
  }

  @override
  Future trackOrder(String orderId, ) async{
    return await orderDetailsRepositoryInterface.trackYourOrder(orderId, );
  }

  @override
  Future<HttpClientResponse> productDownload(String url) async{
    return await orderDetailsRepositoryInterface.productDownload(url);
  }

  @override
  Future addOrderRefund(String orderID, String refundReason, List<XFile> files) async{
    return await orderDetailsRepositoryInterface.addOrderRefund(orderID,refundReason,files);

  }

  @override
  Future getOrderRefund(String orderID) async{
    return await orderDetailsRepositoryInterface.getOrderRefund(orderID,);

  }

  @override
  Future refundUpdateReason(String orderID, String reason) async{
    return await orderDetailsRepositoryInterface.refundUpdateReason(orderID,reason);

  }

  @override
  Future refundDeleteAttachment(String orderID, String index)async {
    return await orderDetailsRepositoryInterface.refundDeleteAttachment(orderID,index);

  }

  @override
  Future refundReplaceAttachment(String orderID, String index, XFile file)async {
    return await orderDetailsRepositoryInterface.refundReplaceAttachment(orderID,index,file);

  }

  @override
  Future refundUploadAttachment(String orderID, List<XFile> files)async {
    return await orderDetailsRepositoryInterface.refundUploadAttachment(orderID,files);
  }



}