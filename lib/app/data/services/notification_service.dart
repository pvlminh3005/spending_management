import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/utilities/app_utils.dart';
import '../../core/utilities/http_client/http_client.dart';
import '../../core/utilities/string_utils.dart';
import '../models/models.dart';

final _fln = FlutterLocalNotificationsPlugin();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
    this.image,
  });

  final int id;
  final String? title;
  final String? body;
  final String? image;
  final Map<String, dynamic>? payload;
}

class NotificationService extends GetxService {
  FlutterLocalNotificationsPlugin get fln => _fln;
  final onMessage = Rxn<ReceivedNotification>();

  String? tokenMessage;

  Future<NotificationService> init() async {
    await requestPermission();
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    );
    _fln.initialize(
      initializationSettings,
      onSelectNotification: (String? data) async {
        try {
          if (data != null) {
            Map<String, dynamic> payload = jsonDecode(data);
            navigatorPage(payload);
          }
        } catch (e) {
          AppUtils.log(e, tag: 'OnSelectNotification');
        }
      },
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
      onMessage(
        ReceivedNotification(
          id: remoteMessage.hashCode,
          title: remoteMessage.notification?.title,
          body: remoteMessage.notification?.body,
          payload: remoteMessage.data,
          image: Platform.isIOS
              ? remoteMessage.notification?.apple?.imageUrl
              : remoteMessage.notification?.android?.imageUrl,
        ),
      );
      showNotification(remoteMessage);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      navigatorPage(remoteMessage.data, isBackground: true);
    });

    getToken();
    // FirebaseMessaging.onBackgroundMessage(_myBackgroundMessageHandler);

    // tokenMessage = await FirebaseMessaging.instance.getToken();
    // AppUtils.log(tokenMessage);
    return this;
  }

  Future<void> getToken() async {
    AppUtils.internetLookUp();
    try {
      tokenMessage = await FirebaseMessaging.instance.getToken();
      AppUtils.log('TOKEN MESSAGE: $tokenMessage');
    } catch (e) {
      AppUtils.log(e);
    }
  }

  Future<void> requestPermission() async {
    try {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      }
    } catch (e) {
      AppUtils.log(e);
    }
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    Map<String, dynamic> data = remoteMessage.data;
    AppUtils.log(data);
    RemoteNotification? notification = remoteMessage.notification;
    final androidImage = await remoteMessage.androidImage;
    final iosImage = await remoteMessage.iosImage;
    await _fln.show(
      notification.hashCode,
      notification?.title ?? '',
      notification?.body ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel_sm',
          'High Importance Notifications Spending Management',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon:
              androidImage.isEmpty ? null : FilePathAndroidBitmap(androidImage),
        ),
        iOS: IOSNotificationDetails(
          attachments: [
            if (iosImage.isNotEmpty) IOSNotificationAttachment(iosImage),
          ],
        ),
      ),
      payload: jsonEncode(data),
    );
  }

  void initCurrentNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? remoteMessage) {
        if (remoteMessage != null) {
          navigatorPage(remoteMessage.data);
        }
      },
    );
    final detailLaunch = await _fln.getNotificationAppLaunchDetails();
    if (detailLaunch!.didNotificationLaunchApp) {
      if (detailLaunch.payload != null) {
        var payload = jsonDecode(detailLaunch.payload!);
        navigatorPage(payload);
      }
    }
  }

  void sentMessage(MessagingModel data, String token) {
    try {
      ApiClient.request('https://fcm.googleapis.com/fcm/send',
          method: ApiMethod.post,
          options: Options(method: 'post', headers: {
            'Authorization': 'key=${StringUtils.messagingKey}',
          }),
          data: {
            'notification': <String, dynamic>{
              'title': data.title,
              'body': data.body,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              ...data.data,
            },
            'to': token,
          });
    } catch (e) {
      AppUtils.log(e);
    }
  }
}

void navigatorPage(dynamic data, {isBackground = false}) async {
  AppUtils.log('payload $data, isBackground $isBackground');
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  try {
    if (!url.contains('https://')) {
      return '';
    }
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Options options = Options(responseType: ResponseType.bytes);
    final response = await Dio().get(url, options: options);
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  } catch (e) {
    return '';
  }
}

extension ImageNoticeExt on RemoteMessage {
  Future<String> get androidImage => _downloadAndSaveFile(
        notification?.android?.imageUrl ?? '',
        'androidImage',
      );

  Future<String> get iosImage =>
      _downloadAndSaveFile(notification?.apple?.imageUrl ?? '', 'iosImage');
}
