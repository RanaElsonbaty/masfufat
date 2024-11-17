import 'package:camera/camera.dart';
import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

import '../../../../data/model/api_response.dart';

abstract class SyncOrderRepositoryInterface extends RepositoryInterface {
  Future<ApiResponse> getOrderList(String type, String page);

  Future<ApiResponse> getOrderDeteilsList(String id);

  Future<ApiResponse> placeSyncWalletOrder(String id);

  Future<ApiResponse> placeSyncOrderCashOnDelivery(String id, String couponCode,
      String couponDiscount, String orderNode, int addressId);

  // Future<ApiResponse> placeBankTransferOrder(String id);
  Future<ApiResponse> bankAndDelayedPayment(
    String orderID,
    String paymentMethod,
    String bank,
    String holderName,
    int addressId,
    XFile attachment,
  );
  Future<ApiResponse> placeSyncDelayedOrder(String id,String addressId,String couponCode,String couponDiscount,String orderNote);

// Future<dynamic> createNewSupportTicket(SupportTicketBody supportTicketModel, List<XFile?> file);
//
// Future<dynamic> getSupportReplyList(String ticketID);
//
// Future<dynamic> sendReply(String ticketID, String message, List<XFile?> file);
//
// Future<dynamic> closeSupportTicket(String ticketID);
}
