import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/notification-util.dart';
import 'package:egovapp/constants/router.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/menu/main-menu.dart';
import 'package:egovapp/page/notification/notification-page.dart';
import 'package:egovapp/service/staffs/service-notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class HomeMain extends StatefulWidget {
  HomeMain({Key? key}) : super(key: key);  
  @override
  _HomeMainState createState() => _HomeMainState();
}
class _HomeMainState extends State<HomeMain> {
  @override
  void initState() {

    super.initState();
    NotificationUtil().initNotification();
    receivedMessage(context);
  }

  void receivedMessage(BuildContext context)
  {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
     ServiceNotification().getByMessageId(message.messageId.toString()).then((value) {
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (context) => new NotificationPage(type:value.notificationType),
             ),
           );
     }).catchError((e)
        {
          UIUtils.showToastError(e.toString(), context);
        });
    });

  }
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Language.getText("egovapp") ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.white
            )
        ),
        primaryIconTheme: IconThemeData(color: Colors.red),
        platform: TargetPlatform.iOS,
      ),
      routes: Routers.statesPage,
      home: NavigationHomeScreen(),
    );
  }
}
