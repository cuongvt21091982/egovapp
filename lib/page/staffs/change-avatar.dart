import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:flutter/material.dart';
class ChangeAvatar
{
  ChangeAvatar({required this.context});
  final BuildContext context;
  String avatar='';
  Future<void> uploadAvatar(String key)async
  {
    this.avatar =key;
  }
  void action() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceStaffs().changeAvatar(UserAuthSession.staffId, this.avatar).then((value) {
      UIUtils.showToastSuccess(
          Language.getText('message_change_avatar_success'), context);
     UserAuthSession.getAccount();
      Navigator.pop(dialogContext,true);
    }).catchError((onError){
      UIUtils.showToastError(onError.toString(), context);
      Navigator.pop(dialogContext,true);
    });
  }
  void showChange()
  {
    ServiceStaffs().getById(UserAuthSession.staffId).then((value){
      var formEdit= Container(
          height: 300,
          child:   ProfileFileFormAction(setKey: uploadAvatar,urlPath: value.anh)
      );
      new UICustomDialog(action).show(context,Language.getText('capnhatanhdaidien'),
          Language.getText('change'),formEdit);
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
}