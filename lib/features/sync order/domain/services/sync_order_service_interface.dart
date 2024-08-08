
import '../../../../data/model/api_response.dart';

abstract class SyncOrderServiceInterface{
  //   var data = FormData.fromMap({
  //       "id": orderID,
  //       "payment_method": paymentMethod,
  //       "bank": bank,
  //       "attachment": attachment,
  //       "holder_name": holderName
  //     });
  Future<ApiResponse> getOrderList(String type ,String page);
  Future<ApiResponse> getOrderDeteilsList(String id);
  Future<ApiResponse> placeSyncWalletOrder(String id);
  Future<ApiResponse> placeBankTransferOrder(String id,String paymentMethod);
  //
  // Future<dynamic> getSupportReplyList(String ticketID);
  //
  // Future<dynamic> sendReply(String ticketID, String message, List<XFile?> file);
  //
  // Future<dynamic> closeSupportTicket(String ticketID);
  //
  // Future<dynamic> getList({int? offset = 1});
}