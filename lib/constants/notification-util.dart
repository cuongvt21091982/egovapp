import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationUtil
{
  late AndroidNotificationChannel channel;
  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }
  void initNotification() async
  {
      await Firebase.initializeApp(
        //name: "egov-message-app",
          options: const FirebaseOptions(
            apiKey: 'AIzaSyBnjVtO2P9N4bg3oPcKF0T9gARwzH0t1JI',
            appId: '1:427955879926:android:ba81993ed6f92964ca51d7',
            messagingSenderId: '427955879926',
            projectId: 'egov-send-message',
          ));
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        ServiceStaffs().updateToken(UserAuthSession.staffId,value!).then((value) {
        }).catchError((e){
          debugPrint("TOTKEN GEN:"+e.toString());
        });
      }).catchError((onError)
      {
        debugPrint("TOKEN GEN:"+onError.toString());
      });
      messaging.subscribeToTopic("com.egov.app.egovapp");
      messaging.subscribeToTopic("com.egov.app.egovapp.unit."+UserAuthSession.unitId.toString());
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        // TODO: handle the received notifications
      } else {
        print('User declined or has not accepted permission');
      }
      /*channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
  // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.*/
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );


  }

}