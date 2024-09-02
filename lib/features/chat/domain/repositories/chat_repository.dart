
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/message_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';


class ChatRepository implements ChatRepositoryInterface {
  final DioClient? dioClient;
  ChatRepository({required this.dioClient});



  @override
  Future<ApiResponse> getChatList(String type, int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.chatInfoUri}$type?limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> searchChat(String type, String search) async {
    try {
      final response = await dioClient!.get('${AppConstants.searchChat}$type?search=$search');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getMessageList(String type, int? id,int offset) async {
    try {
      final response = await dioClient!.get('${AppConstants.messageUri}$type/$id?limit=300&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  @override
  Future<ApiResponse> seenMessage(int id, String type) async {
    try {
      final response = await dioClient!.post('${AppConstants.seenMessageUri}$type',
          data: {'id':id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> sendMessage(MessageBody messageBody, String type, List<XFile?> file, List<PlatformFile>? platformFile) async {

    List<MultipartFile> attachmentFile=[];

    if(messageBody.file!.isNotEmpty){
      for (var element in messageBody.file!) {
        attachmentFile.add(
          await MultipartFile.fromFile(element!.path, filename: element.path),
        );
      }
    }

    try {
      var data = FormData.fromMap({
        'attachments[]':attachmentFile,
        'message': messageBody.message!,
        'id': messageBody.id
      });
      final response = await dioClient!
          .post(AppConstants.sendMessageUri, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('asdasdasdasdasd ----$e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
    // }

  //   Map<String, String> fields = {};
  //   request.fields.addAll(<String, String>{'id': messageBody.id.toString(), 'message': messageBody.message??''});
  //   request.fields.addAll(fields);
  //   http.StreamedResponse response = await request.send();
  //   return response;
  // }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
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
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }


}