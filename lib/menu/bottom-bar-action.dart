
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/page/calendar/congtac/lich-congtac.dart';
import 'package:egovapp/page/email/danhan/thu-danhan.dart';
import 'package:egovapp/page/home/dashboard.dart';
import 'package:egovapp/page/meeting/ql-meeting.dart';
import 'package:egovapp/page/notification/notification-page.dart';
import 'package:egovapp/page/staffs/info-account.dart';
import 'package:egovapp/page/thongbao/docthongbao/doc-thongbao.dart';
import 'package:flutter/material.dart';
class BottomBarAction extends StatefulWidget {
   const BottomBarAction({Key? key, this.pageCurrent}) : super(key: key);
   final int? pageCurrent;
  @override
  _BottomBarAction createState() => _BottomBarAction();
}

class _BottomBarAction extends State<BottomBarAction> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if(_selectedIndex == 0)
        {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new DashBoardPage()
            )
          );
        }
      if(_selectedIndex == 1)
      {
        Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(
              builder: (context) => new QLMeeting()
          ), (route) => true
        );
      }
      if(_selectedIndex == 2)
      {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new DocThongBao()
          )
        );
      }
      if(_selectedIndex == 3)
      {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new InfoAccount()
          ),
        );
      }
      if(_selectedIndex == 4)
      {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new ThuDaNhan()
          ),
        );
      }
      if(_selectedIndex == 5)
      {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new NotificationPage(type: 'ALL')
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: UIUtils.setBoxBottomContainer(),
        height: 60,
        child:BottomNavigationBar(
          unselectedItemColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm_add),
                label: 'Cuộc họp'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_alert_outlined),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Tài khoản',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: "Thư điện tử",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.new_releases_sharp),
              label: 'Tin mới nhận',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: "Trợ giúp",
            )
          ],
          currentIndex: this.widget.pageCurrent ?? 0,
          selectedItemColor: Colors.deepOrange,
          onTap: _onItemTapped,
        )
        /*Row(
        children: <Widget>[
          IconButton(padding:  UIUtils.iconNotificationPadding,
                     tooltip: Language.getText("home"),
                     icon: Icon(Icons.home,color: UIUtils.colorBottomIconButton),
                     iconSize: UIUtils.sizeBottomIconButton, onPressed: () {}),
          IconButton(padding:  UIUtils.iconNotificationPadding,
              tooltip: Language.getText("meeting"),
              icon: Icon(Icons.alarm_add,color: UIUtils.colorBottomIconButton),
              iconSize: UIUtils.sizeBottomIconButton, onPressed: () {}),
          IconButton(padding:  UIUtils.iconNotificationPadding,
              tooltip: Language.getText("thongbao"),
              icon: Icon(Icons.add_alert_outlined,color: UIUtils.colorBottomIconButton),
              iconSize: UIUtils.sizeBottomIconButton, onPressed: () {}),
          IconButton(padding:  UIUtils.iconNotificationPadding,
              tooltip: Language.getText("email"),
              icon: Icon(Icons.contact_mail,color: UIUtils.colorBottomIconButton),
              iconSize: UIUtils.sizeBottomIconButton, onPressed: () {}),
          Badge(
            position: UIUtils.badgePosition,
            animationDuration: Duration(milliseconds: 300),
            badgeColor: Colors.red,
            animationType: BadgeAnimationType.scale,
            badgeContent: UIUtils.setTextNotification("1"),
            child: IconButton(padding:  UIUtils.iconNotificationPadding,icon: Icon(Icons.admin_panel_settings_sharp,color: Colors.white  ), iconSize: 30, onPressed: () {}),
          ),IconButton(padding:  UIUtils.iconNotificationPadding,
              tooltip: Language.getText("caidat"),
              icon: Icon(Icons.settings,color: UIUtils.colorBottomIconButton),
              iconSize: UIUtils.sizeBottomIconButton, onPressed: () {}),
          ])*/
       /**/
    );

  }


}
