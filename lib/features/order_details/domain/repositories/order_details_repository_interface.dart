import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

abstract class OrderDetailsRepositoryInterface<T> extends RepositoryInterface{

  Future<dynamic> getOrderFromOrderId(String orderID);

  Future<dynamic> getOrderInvoice(String orderID);
  Future <dynamic> addOrderRefund(String orderID,String refundReason,List<XFile> files);
  Future <dynamic> getOrderRefund(String orderID,);
  Future<dynamic> refundUpdateReason(String orderID,String reason);
  Future<dynamic> refundDeleteAttachment(String orderID,String index);
  Future<dynamic> downloadDigitalProduct(int orderDetailsId);
  Future<dynamic> refundReplaceAttachment(String orderID,String index,XFile file);
  Future<dynamic> resendOtpForDigitalProduct(int orderId);
  Future<dynamic> refundUploadAttachment(String orderID,List<XFile> files);
  Future<dynamic> otpVerificationForDigitalProduct(int orderId, String otp);

  Future<dynamic> trackYourOrder(String orderId, );

  Future<HttpClientResponse> productDownload(String url);

}