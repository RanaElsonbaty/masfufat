
import 'dart:io';

import 'package:image_picker/image_picker.dart';


abstract class OrderDetailsServiceInterface {

  Future<dynamic> getOrderFromOrderId(String orderID);

  Future <dynamic> getOrderDetails(String orderID);
  Future<dynamic> refundReplaceAttachment(String orderID,String index,XFile file);
  Future<dynamic> refundUploadAttachment(String orderID,List<XFile> files);

  Future <dynamic> getOrderInvoice(String orderID);
  Future<dynamic> refundUpdateReason(String orderID,String reason);
  Future<dynamic> refundDeleteAttachment(String orderID,String index);

  Future <dynamic> addOrderRefund(String orderID,String refundReason,List<XFile> files);
  Future <dynamic> getOrderRefund(String orderID,);

  Future<dynamic> downloadDigitalProduct(int orderDetailsId);

  Future<dynamic> resentDigitalProductOtp(int orderId);

  Future<dynamic> verifyDigitalProductOtp(int orderId, String otp);

  Future<dynamic> trackOrder(String orderId, );

  Future<HttpClientResponse> productDownload(String url);


}