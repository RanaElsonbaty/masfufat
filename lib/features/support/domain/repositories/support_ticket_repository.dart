import 'dart:convert';

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
      print('asdasdasdasdasda-----> ${supportTicketModel.toJson()}');
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
  Future<ApiResponse> sendReply(String ticketID, String message, List<XFile?> file) async {
    // http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.supportTicketReplyUri}$ticketID'));
    // request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}'});
    // for(int i=0; i<file.length;i++){
    //   Uint8List list = await file[i]!.readAsBytes();
    //   var part = http.MultipartFile('image[]', file[i]!.readAsBytes().asStream(),
    //       list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
    //   request.files.add(part);
    // }
    // Map<String, String> fields = {};
    // request.fields.addAll(<String, String>{
    //   'message': message,
    // });
    // request.fields.addAll(fields);
    // http.StreamedResponse response = await request.send();
    // return response;
    try {
      List<MultipartFile> attachmentFile=[];
      if(file.isNotEmpty){
      for (var element in file) {
        attachmentFile.add(
          await MultipartFile.fromFile(element!.path, filename: element.path),
        );
      }
      }

      attachmentFile.forEach((element) {
        print('sdasdasdasdasdasdasdasd${element.filename}');
      });
      var data =
      FormData.fromMap({'attachments[]': attachmentFile, 'message': message});
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