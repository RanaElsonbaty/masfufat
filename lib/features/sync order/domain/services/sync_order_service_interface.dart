import 'package:camera/camera.dart';

import '../../../../data/model/api_response.dart';

abstract class SyncOrderServiceInterface {
  //   var data = FormData.fromMap({
  //       "id": orderID,
  //       "payment_method": paymentMethod,
  //       "bank": bank,
  //       "attachment": attachment,
  //       "holder_name": holderName
  //     });
  Future<ApiResponse> getOrderList(String type, String page);

  Future<ApiResponse> getOrderDeteilsList(String id);

  Future<ApiResponse> placeSyncOrderCashOnDelivery(String id, String couponCode,
      String couponDiscount, String orderNode, int addressId);

  Future<ApiResponse> placeSyncWalletOrder(String id);

  Future<ApiResponse> bankAndDelayedPayment(
    String orderID,
    String paymentMethod,
    String bank,
    String holderName,
    int addressId,
    XFile attachment,
  );
  Future<ApiResponse> placeSyncDelayedOrder(String id,String addressId,String couponCode,String couponDiscount,String orderNote);

}
