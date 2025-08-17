
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtility {

  Future<void> initMessaging() async {

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    
    // 안드로이드 초기화 설정 (커스텀 모니터 아이콘 설정)
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    
    // iOS 초기화 설정
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    // 초기화 설정 통합
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    // 플러그인 초기화
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title.
      description: 'This channel is used for alert notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //iOS foreground 알림표시.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        if (message.data != null) {
          flutterLocalNotificationsPlugin.show(
              hashCode,
              message.notification!.title,
              message.notification!.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/launcher_icon',
                  // icon: '@mipmap/ic_launcher',
                  largeIcon: const DrawableResourceAndroidBitmap('@mipmap/launcher_icon'),
                ),
                iOS: const DarwinNotificationDetails( // ← iOS용 설정
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true,
                  sound: 'default',
                  // iOS는 자동으로 앱 아이콘을 알림에 표시합니다
                ),
              ));
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp : $event");
      // ScaffoldMessenger.of(NavigationManager.navigatorKey.currentContext!).showSnackBar( SnackBar(content: Text("onMessageOpenedApp --> ${event.toMap().toString()}")),);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // ScaffoldMessenger.of(NavigationManager.navigatorKey.currentContext!).showSnackBar( SnackBar(content: Text("getInitialMessage --> ${message.toMap().toString()}")),);
      }
    });

  }

}