import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/vanbandi/service-vanbandi.dart';
import 'package:flutter/material.dart';
class ChangeDateVanBanDi
{
  ChangeDateVanBanDi({required this.context, required this.id, required this.callBackRefresh});
  final BuildContext context;
  final int id;
  final VoidCallback callBackRefresh;
  var  dtThoiHan =  TextEditingController();
  void action() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceVanBanDi().changeThoiHan(id, dtThoiHan.text).then((value) {
      UIUtils.showToastSuccess(
          Language.getText('message_change_date_success'), context);
      callBackRefresh();
      Navigator.pop(dialogContext,true);

    }).catchError((onError){
      UIUtils.showToastError(onError.toString(), context);
      Navigator.pop(dialogContext,true);
    });
  }
  void showChange()
  {
    ServiceVanBanDi().getById(this.id).then((value){
      dtThoiHan.text= value.thoiHan;
      var formEdit= Container(
          padding: UIUtils.paddingForm,
          child:   UIDateTimeAction( textEdit: this.dtThoiHan,
              title:  Language.getText('thoihan'),
              description: Language.getText('thoihan'),
              validate: false,
              messageRequired: '')

      );
      new UICustomDialog(action).show(context,Language.getText('updatedate'),
          Language.getText('change'),formEdit);
    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });



  }
}