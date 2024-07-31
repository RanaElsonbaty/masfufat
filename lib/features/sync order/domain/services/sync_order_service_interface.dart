import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/api_response.dart';

abstract class SyncOrderServiceInterface{

  Future<ApiResponse> getOrderList(String type ,String page);
  Future<ApiResponse> getOrderDeteilsList(String id);
  //
  // Future<dynamic> getSupportReplyList(String ticketID);
  //
  // Future<dynamic> sendReply(String ticketID, String message, List<XFile?> file);
  //
  // Future<dynamic> closeSupportTicket(String ticketID);
  //
  // Future<dynamic> getList({int? offset = 1});
}