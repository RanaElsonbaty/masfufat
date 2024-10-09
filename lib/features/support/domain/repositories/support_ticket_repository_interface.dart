import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/interface/repo_interface.dart';
import 'package:image_picker/image_picker.dart';

abstract class SupportTicketRepositoryInterface extends RepositoryInterface<SupportTicketBody>{

  Future<dynamic> createNewSupportTicket(SupportTicketBody supportTicketModel, );

  Future<dynamic> getSupportReplyList(String ticketID);

  Future<dynamic> sendReply(String ticketID, String message,   List<MultipartFile> file);

  Future<dynamic> closeSupportTicket(String ticketID);

}