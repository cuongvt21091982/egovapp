
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/page/staffs/change-avatar.dart';
import 'package:egovapp/page/staffs/change-password.dart';
import 'package:flutter/material.dart';
class AppBarUserAction extends StatefulWidget {
  const AppBarUserAction({Key? key
    }) : super(key: key);
  @override
  _AppBarUserActionState createState() => _AppBarUserActionState();
}

class _AppBarUserActionState extends State<AppBarUserAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();

      menuList.add(
          PopupMenuItem(
            value: ParamUtils.actionChangePassword,
            child: UIUtils.setMenuIconText(Language.getText('change_password'), Icons.lock_open),
          )
      );
      menuList.add(PopupMenuItem(
        value: ParamUtils.actionChangeAvatar,
        child: UIUtils.setMenuIconText(Language.getText('change_avatar'), Icons.image),
      ));



  }
  void _changePassword() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChangePassword()));
  }

  @override
  Widget build(BuildContext context) {
    return
      Row(
          children: <Widget>[
            PopupMenuButton(
                itemBuilder: (context) {
                  return menuList;
                },
                onSelected: (String value) async{
                  if(value==ParamUtils.actionChangePassword) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChangePassword()));
                  }
                  if(value==ParamUtils.actionChangeAvatar) {
                    new ChangeAvatar(context: context).showChange();
                  }

                })
          ]
      );


  }


}
