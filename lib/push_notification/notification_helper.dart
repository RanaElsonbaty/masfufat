import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:path_provider/path_provider.dart';

import '../features/order_details/screens/order_details_screen.dart';
import 'models/notification_body.dart';

class MyNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // String device =await getDeviceToken();

    // init flutter notification
    try{
      if(Platform.isAndroid){
        print('flutterLocalNotificationsPlugin');
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
            .requestNotificationsPermission();
      }else{
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>() ;
      }

    }catch(e){
      print('flutterLocalNotificationsPlugin error => $e');
    }

    var androidInitialize =
    const AndroidInitializationSettings('notification_icon');

    var iOSInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        print('onDidReceiveLocalNotification => id $id , title $title , body $body , payload $payload');
      },
    );
    var initializationsSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.pendingNotificationRequests();
    // flutterLocalNotificationsPlugin.
    flutterLocalNotificationsPlugin.initialize(
        initializationsSettings,
        onDidReceiveNotificationResponse: (details) {
          print('onDidReceiveNotificationResponse start');

          try {
            if (details.payload!.isNotEmpty) {
             Navigator.push(Get.context!,MaterialPageRoute(
                  builder: (context) => OrderDetailsScreen(
                      orderId: int.parse(details.payload!),
                      )));
            }
          } catch (e) {
            print('onDidReceiveNotificationResponse error => $e');
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground
    );

    try {

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            "onMessage: title: ${message.notification!.title}/ body: ${message.notification!.body}/ titleLocKey: ${message.notification!.titleLocKey}/ imageUrl: ${message.notification!.android!.imageUrl}/ channelId: ${message.notification!.android!.channelId}/ sound: ${message.notification!.android!.sound}");
        showNotification(message, flutterLocalNotificationsPlugin, false);
      });
    } catch (e) {
      print('onMessage error => $e');
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (message.notification!.titleLocKey != null &&
            message.notification!.titleLocKey!.isNotEmpty) {
          Navigator.push(Get.context!,MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(
                  orderId: int.parse(message.notification!.titleLocKey!),
                 )));
        }
      } catch (e) {
        print('onMessageOpenedApp =>$e');
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    String? title;
    String? body;
    String orderID;
    String? image;
    String? sound;
    sound =Platform.isAndroid?message.notification!.android!.sound:message.notification!.apple!.sound!.name;
    if (data) {
      title = message.data['title'];
      body = message.data['body'];
      orderID = message.data['order_id'];

      try {
        image = (message.data['image'] != null &&
            message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http')
            ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}'
            : null;
      } catch (e) {
        image = '';
      }
    } else {
      title = message.notification?.title!;
      if (message.notification!.body != null) {
        body = message.notification!.body!;
      } else {
        body = '';
      }
      if (message.notification!.titleLocKey != null) {
        orderID = message.notification!.titleLocKey!;
      } else {
        orderID = '';
      }

      if (Platform.isAndroid) {
        image = ((message.notification!.android!.imageUrl != null &&
            message.notification!.android!.imageUrl!.isNotEmpty)
            ? message.notification!.android!.imageUrl!.startsWith('http')
            ? message.notification!.android!.imageUrl!
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl!}'
            : '');

      } else if (Platform.isIOS) {
        image = ((message.notification!.apple!.imageUrl != null &&
            message.notification!.apple!.imageUrl!.isNotEmpty)
            ? message.notification!.apple!.imageUrl!.startsWith('http')
            ? message.notification!.apple!.imageUrl
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}'
            : '');
      }
    }

    try {
      if(sound==null&&sound!=''){
        sound ='normal';
      }
      if(Platform.isAndroid){
        if( sound =='order.wav'){
          sound='order';
        }else{
          sound='normal';
        }
      }

      if (image!=null&&image.isNotEmpty) {
        try {
          await showBigPictureNotificationHiddenLargeIcon(
              title!, body!, orderID, image, fln,sound!);
        } catch (e) {
          print('showBigPictureNotificationHiddenLargeIcon => $e');
          await showBigTextNotification(title!, body!, orderID, fln,sound!);
        }
      } else {
        await showBigTextNotification(
            title!,
            body!,
            orderID,
            fln,
            sound!
        );
      }
    } catch (e) {
      print('show notification error => $e');
    }
  }

  static Future<void> showTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln,String sound) async {
    var vibrationPattern = Int64List(4);
    print('showTextNotification sound -> $sound');
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification_channel_id_2',
      'your channel name',
      playSound: true,
      vibrationPattern: vibrationPattern,
      importance: Importance.max,
      priority: Priority.high,
      sound:const RawResourceAndroidNotificationSound('normal'),
    );
    AndroidNotificationDetails androidPlatformChannel =
    AndroidNotificationDetails(
      'order_channel_id_1',
      'your channel name',
      // order.mp3
      playSound: true,
      vibrationPattern: vibrationPattern,
      importance: Importance.max,
      priority: Priority.high,
      sound:const RawResourceAndroidNotificationSound('order'),
    );
    final DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails(
      sound:sound,
      presentSound: false,
      subtitle: title,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android:sound=='normal'? androidPlatformChannelSpecifics:androidPlatformChannel,
        iOS: iosPlatformChannelSpecifics);

    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigTextNotification(String title, String body,
      String orderID, FlutterLocalNotificationsPlugin fln,String sound) async {
    print('showBigTextNotification sound -> $sound');

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    var vibrationPattern = Int64List(4);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification_channel_id_2',
      'your channel name',
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      vibrationPattern: vibrationPattern,
      sound:const RawResourceAndroidNotificationSound("normal"),
    );
    AndroidNotificationDetails androidPlatformChannel =
    AndroidNotificationDetails(
      'order_channel_id_1',
      'your channel name',
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      vibrationPattern: vibrationPattern,
      sound:const RawResourceAndroidNotificationSound("order"),
    );

    final DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails(
      sound:sound,
      presentSound: false,
      subtitle: title,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android:sound=='normal'?  androidPlatformChannelSpecifics:androidPlatformChannel,
        iOS: iosPlatformChannelSpecifics);

    try {
      await fln.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: orderID,
      );
    } catch (e) {
      print('DarwinNotificationDetails => $e');
    }
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
      String title,
      String body,
      String orderID,
      String image,

      FlutterLocalNotificationsPlugin fln,String sound) async {
    print('showBigPictureNotificationHiddenLargeIcon sound -> $sound');

    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
    await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    var vibrationPattern = Int64List(4);

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'notification_channel_id_2',
      'your channel name',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      playSound: true,
      vibrationPattern:vibrationPattern,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      sound:const RawResourceAndroidNotificationSound('normal'),
    );  final AndroidNotificationDetails androidPlatformChannel =
    AndroidNotificationDetails(
      'order_channel_id_1',
      'your channel name',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      playSound: true,
      vibrationPattern:vibrationPattern,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      sound:const RawResourceAndroidNotificationSound("order"),
    );
    // RawResourceAndroidNotificationSound("notification"),
    final DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails(
      sound:sound,
      presentSound: false,
      subtitle: title,

    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android:sound=='normal'? androidPlatformChannelSpecifics:androidPlatformChannel,
        iOS: iosPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }
  static  NotificationBody convertNotification(Map<String, dynamic> data){
    if(data['type'] == 'notification') {
      return NotificationBody(type: 'notification');
    }else if(data['type'] == 'order') {
      return NotificationBody(type: 'order', orderId: int.parse(data['order_id']));
    }else if(data['type'] == 'wallet') {
      return NotificationBody(type: 'wallet');
    }else if(data['type'] == 'block') {
      return NotificationBody(type: 'block');
    }else {
      return NotificationBody(type: 'chatting');
    }
  }

}
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('NotificationResponse => ${notificationResponse.payload} / ${notificationResponse.notificationResponseType}');
}
@pragma('vm:entry-point')
Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  try{
    print('sound android -> ${message.notification!.android!.sound}');
  }catch(e){
    print('sound android -> $e');

  } try{
    print('sound apple -> ${message.notification!.apple!.sound}');

  }catch(e){
    print('sound apple -> $e');

  }
  try{
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");

  }catch(e){
    print('myBackgroundMessageHandler => $e');
  }
}
Future getDeviceToken()async{
  try{
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging fireBase =FirebaseMessaging.instance;
    String? DeviceToken =await fireBase.getToken();
    return (DeviceToken ==null)?'':DeviceToken;
  }catch(e){
    print('getDeviceToken error => $e');
  }

}




