
import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/repositories/support_ticket_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';





class SupportTicketRepository implements SupportTicketRepositoryInterface{
  final DioClient? dioClient;
  SupportTicketRepository({required this.dioClient});


  @override
  Future<ApiResponse> createNewSupportTicket(SupportTicketBody supportTicketModel,) async {
    try {
      List<MultipartFile> files=[];
      print(supportTicketModel.attachments);
      if(supportTicketModel.attachments!=null) {
        supportTicketModel.attachments!.forEach((element) async {
          files.add(await MultipartFile.fromFile(element.path,filename: element.name));
        });
      }
      print(supportTicketModel.toJson());
      var data = FormData.fromMap({
        'attachments[]':files,
        'subject': supportTicketModel.subject,
        'type': supportTicketModel.orderid,
        'description':supportTicketModel.subject ,
        'order_id': '',
        "priority":supportTicketModel.description
      });
      final response = await dioClient!.post(AppConstants.supportTicketUri,
          data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getList({int? offset = 1}) async {
    try {
      final response = await dioClient!.get(AppConstants.getSupportTicketUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getSupportReplyList(String ticketID) async {
    try {
      final response = await dioClient!.get('${AppConstants.supportTicketConversationUri}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> sendReply(String ticketID, String message,   List<MultipartFile> file) async {
    try {
      var data =file.isNotEmpty?
      FormData.fromMap({'attachments[]': file, 'message': message}):FormData.fromMap({'attachments[]': [], 'message': message});

      final response = await dioClient!.post('${AppConstants.supportTicketReplyUri}$ticketID',data: data);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> closeSupportTicket(String ticketID) async {
    try {
      final response = await dioClient!.post('${AppConstants.closeSupportTicketUri}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> deleteSupportTicket(String ticketID) async {
    try {
      final response = await dioClient!.delete('${AppConstants.deleteSupportTicketUri}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }



  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future add(SupportTicketBody value, {List<XFile>? file}) {
    // TODO: implement add
    throw UnimplementedError();
  }

}