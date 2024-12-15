import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';

abstract class SupportTicketServiceInterface{

  Future<dynamic> createNewSupportTicket(SupportTicketBody supportTicketModel, );

  Future<dynamic> getSupportReplyList(String ticketID);

  Future<dynamic> sendReply(String ticketID, String message,   List<MultipartFile> file);

  Future<dynamic> closeSupportTicket(String ticketID);
  Future<dynamic> deleteSupportTicket(String ticketID);

  Future<dynamic> getList({int? offset = 1});
}