
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/domain/repositories/order_details_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class OrderDetailsRepository implements OrderDetailsRepositoryInterface{
  final DioClient? dioClient;
  OrderDetailsRepository({required this.dioClient});

  @override
  Future<ApiResponse> get(String orderID) async {
    try {
      final response = await dioClient!.get(AppConstants.orderDetailsUri+orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getOrderFromOrderId(String orderID) async {
    try {
      final response = await dioClient!.get('${AppConstants.getOrderFromOrderId}$orderID&guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> downloadDigitalProduct(int orderDetailsId) async {
    try {
      final response = await dioClient!.get('${AppConstants.downloadDigitalProduct}$orderDetailsId?guest_id=${Provider.of<AuthController>(Get.context!, listen: false).getGuestToken()}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> resendOtpForDigitalProduct(int orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.otpVResendForDigitalProduct,
      data: {'order_details_id' : orderId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> otpVerificationForDigitalProduct(int orderId, String otp) async {
    try {
      final response = await dioClient!.get('${AppConstants.otpVerificationForDigitalProduct}?order_details_id=$orderId&otp=$otp&guest_id=1',);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> trackYourOrder(String orderId, ) async {
    try {
      final response = await dioClient!.get(AppConstants.orderTrack+orderId,

          );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> reorder(String orderId) async {
    try {
      final response = await dioClient!.post(AppConstants.reorder,
          data: {'order_id': orderId,
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

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
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future getOrderInvoice(String orderID) async{
    try {
      final response = await dioClient!.get('${AppConstants.generateInvoice}$orderID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  @override
  Future<HttpClientResponse> productDownload(String? url) async {
      HttpClient client = HttpClient();
    final response = await client.getUrl(Uri.parse(url!)).then((HttpClientRequest request) {
          return request.close();
        },
      );
    return response;
  }

  @override
  Future addOrderRefund(String orderID, String refundReason, List<XFile> files)async {
    try {
      List file=[];
      for (var element in files) {
        file.add(MultipartFile.fromFile(element.path,filename: element.name) as MultipartFile);
      }
      var data = FormData.fromMap({
        'files': file,
        'order_details_id': orderID,
        'refund_reason': refundReason,
      });
      final response = await dioClient!.post(AppConstants.orderRefund,
      data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future getOrderRefund(String orderID) async{
    try {
      var data = json.encode({
        "id": orderID
      });
      final response = await dioClient!.get(AppConstants.getOrderRefund,
          data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future refundUpdateReason(String orderID,String reason) async{
    try {
      var data = json.encode({
        "order_details_id": orderID,
        'reason':reason
      });
      final response = await dioClient!.post(AppConstants.refundUpdateReason,
          data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future refundDeleteAttachment(String orderID,String index) async{
    try {
      var data = json.encode({
        "order_details_id": orderID,
        "key": index
      });
      final response = await dioClient!.post(AppConstants.refundDeleteAttachment,
          data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }  @override
  Future refundReplaceAttachment(String orderID,String index,XFile file) async{
    try {
      // MultipartFile files=  await MultipartFile.fromFile(File(file.path).path, filename: File(file.path).path);
      print('object');
      var data = FormData.fromMap({
        "order_details_id": orderID,
        "key":index,
        "file":  await MultipartFile.fromFile(file.path, filename: file.path),
      });
      final response = await dioClient!.post(AppConstants.refundReplaceAttachment,
          data: data
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('asdasdasdasd$e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  // @override
  // Future refundUploadAttachment(String orderID,List<XFile> files) async{
  //   try {
  //
  //     List<MultipartFile> file=[];
  //     files.forEach((element) async{
  //       file.add(await MultipartFile.fromFile(element.path,filename: element.name));
  //     });
  //     var data = FormData.fromMap({
  //       'files': file,
  //       'order_details_id': orderID
  //     });
  //     final response = await dioClient!.post(AppConstants.refundUploadAttachment,
  //         data: data
  //     );
  //     print('asdasdasdasd------------------------${response.data}/${orderID}');
  //
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     print('asdasdasdasd------------------------${e}');
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
  //
  @override
  Future<ApiResponse> refundUploadAttachment(String orderID, List<XFile> files) async {
    try {

//       final attachmentFile = [];
//       Map<String ,dynamic > data={
//         'order_details_id':orderID,
//
//       };
//       // const map = {};
//       // for (const key in data) {
//       //   if (map[key]) {
//       //     map[key].push(data[key]);
//       //   } else {
//       //     map[key] = [data[key]];
//       //   }
//       // }
//       if (files.isNotEmpty) {
//         for (var file in files) {
//           try {
//             Map<String,dynamic>map={'files[]':await MultipartFile.fromFile(File(file.path).path, filename: File(file.path).path)};
// ;            // {'files[]':await MultipartFile.fromFile(File(file.path).path, filename: File(file.path).path)}
//             data.addEntries(map.entries,  );
//             // attachmentFile.add(await MultipartFile.fromFile(File(file.path).path, filename: File(file.path).path));
//           } on FileSystemException catch (e) {
//             print('Error accessing file: $e');
//           }
//         }
//       }
      List<MultipartFile> attachmentFile=[];

      if(files.isNotEmpty){
        for (var element in files) {
          attachmentFile.add(
            await MultipartFile.fromFile(element.path, filename: element.path),
          );
        }
      }
      // print('data -----> $data');
      var data = FormData.fromMap({
        'files[]':
            attachmentFile
        ,
        'order_details_id': orderID,
      });
      final response = await dioClient!.post(
        AppConstants.refundUploadAttachment,
        options: Options(method: 'POST', ),
        data: data,
      );


        print('respone upload ---> ${json.encode(response.data)} // $orderID');
        return ApiResponse.withSuccess(response);

    } catch (e) {
      print('Error uploading attachment: $e');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
