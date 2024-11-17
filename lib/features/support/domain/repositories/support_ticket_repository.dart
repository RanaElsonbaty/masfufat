
import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/models/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/domain/repositories/support_ticket_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';




class SupportTicketRepository implements SupportTicketRepositoryInterface{
  final DioClient? dioClient;
  SupportTicketRepository({required this.dioClient});


  @override
  Future<ApiResponse> createNewSupportTicket(SupportTicketBody supportTicketModel,) async {
    try {
      final response = await dioClient!.post(AppConstants.supportTicketUri,
          data: supportTicketModel.toJson()
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
      var data =
      FormData.fromMap({'attachments[]': file, 'message': message});
      // print('dfkjsfhskjfhksdjhfksdhfkshfksdhfksj$message');

      final response = await dioClient!.post('${AppConstants.supportTicketReplyUri}$ticketID',data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> closeSupportTicket(String ticketID) async {
    try {
      final response = await dioClient!.get('${AppConstants.closeSupportTicketUri}$ticketID');
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