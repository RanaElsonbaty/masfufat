import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/models/notification_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/domain/services/notification_service_interface.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class NotificationController extends ChangeNotifier {
  final NotificationServiceInterface notificationServiceInterface;

  NotificationController({required this.notificationServiceInterface});

  List<NotificationItemModel> notificationModel=[];
int totalNotification =0;
int totalOffset =0;

  Future<  List<NotificationItemModel>> getNotificationList(int offset) async {
    notificationModel=[];
    ApiResponse apiResponse = await notificationServiceInterface.getList(offset : offset);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      apiResponse.response?.data['data'].forEach((notification){
        notificationModel.add(NotificationItemModel.fromJson(notification));
      });
      totalOffset =offset;
      totalNotification =  apiResponse.response?.data['total'];      // if(offset == 1){
      //   notificationModel = NotificationItemModel.fromJson(apiResponse.response?.data);
      // }else{
      //   notificationModel?.notification?.addAll(NotificationItemModel.fromJson(apiResponse.response?.data).notification!);
      //   notificationModel?.offset = NotificationItemModel.fromJson(apiResponse.response?.data).offset!;
      //   notificationModel?.totalSize = NotificationItemModel.fromJson(apiResponse.response?.data).totalSize!;
      // }
      notifyListeners();

      return notificationModel;
    } else {
      ApiChecker.checkApi( apiResponse);
      return [];

    }
  }



  Future<void> seenNotification(int id,int index) async {
    ApiResponse apiResponse = await notificationServiceInterface.seenNotification(id);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      getNotificationList(1);
    }
    notifyListeners();
  }
}
