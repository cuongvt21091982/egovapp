import 'package:egovapp/constants/ui-util.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
class AppBarAction extends StatefulWidget {
  @override
  _AppBarAction createState() => _AppBarAction();
}

class _AppBarAction extends State<AppBarAction> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Row(
          children: <Widget>[
          Badge(
              position:UIUtils.badgePosition,
              animationDuration: Duration(milliseconds: 300),
              badgeColor: Colors.red,
              animationType: BadgeAnimationType.scale,
              badgeContent: UIUtils.setTextNotification("1"),
              child: IconButton(padding:  UIUtils.iconNotificationPadding,icon: Icon(Icons.attach_email ), iconSize: UIUtils.iconSizeNotification, onPressed: () {
                UIUtils.showToastWarning("HELLO", context);
              }),
            ),
            Badge(
              position: UIUtils.badgePosition,
              animationDuration: Duration(milliseconds: 300),
              badgeColor: Colors.red,
              animationType: BadgeAnimationType.scale,
              badgeContent: UIUtils.setTextNotification("1"),
              child: IconButton(padding: UIUtils.iconNotificationPadding ,icon: Icon(Icons.calendar_today_rounded  ), iconSize: UIUtils.iconSizeNotification, onPressed: () {
                UIUtils.showToastSuccess("HELLO", context);
              }),
            ),
            Badge(
              position: UIUtils.badgePosition,
              animationDuration: Duration(milliseconds: 300),
              badgeColor: Colors.red,
              animationType: BadgeAnimationType.scale,
              badgeContent: UIUtils.setTextNotification("1"),
              child: IconButton(padding:  UIUtils.iconNotificationPadding,icon: Icon(Icons.admin_panel_settings_sharp  ), iconSize: UIUtils.iconSizeNotification, onPressed: () {}),
            )
          ]
      )
      );

  }
}
