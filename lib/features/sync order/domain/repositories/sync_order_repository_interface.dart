import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';

import '../../../../data/model/api_response.dart';

abstract class SyncOrderRepositoryInterface extends RepositoryInterface{
  Future<ApiResponse> getOrderList(String type ,String page);
  Future<ApiResponse> getOrderDeteilsList(String id);
  Future<ApiResponse> placeSyncWalletOrder(String id);
  Future<ApiResponse> placeBankTransferOrder(String id,String paymentMethod);

  // Future<dynamic> createNewSupportTicket(SupportTicketBody supportTicketModel, List<XFile?> file);
  //
  // Future<dynamic> getSupportReplyList(String ticketID);
  //
  // Future<dynamic> sendReply(String ticketID, String message, List<XFile?> file);
  //
  // Future<dynamic> closeSupportTicket(String ticketID);

}