import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/email/xuly/chenhoso.dart';
import 'package:egovapp/page/email/xuly/chuyengiaoviec.dart';
import 'package:egovapp/page/email/xuly/chuyentrinh.dart';
import 'package:egovapp/page/email/xuly/thu-guitiep.dart';
import 'package:egovapp/page/email/xuly/thu-traloi.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/email/service-thufile.dart';
import 'package:flutter/material.dart';
class AppBarEmailXuLyAction extends StatefulWidget {
  const AppBarEmailXuLyAction({Key? key, required this.id,
    required this.title,
    required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarEmailXuLyActionState createState() => _AppBarEmailXuLyActionState();
}

class _AppBarEmailXuLyActionState extends State<AppBarEmailXuLyAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();
    menuList.add(PopupMenuItem(
      value: ParamUtils.actionDelete,
      child: UIUtils.setMenuIconText(Language.getText('delete'), Icons.delete_rounded),
    ));
    menuList.add(PopupMenuItem(
        value: ParamUtils.actionFileAttach,
        child: UIUtils.setMenuIconText(Language.getText('filedinhkem'), Icons.attach_file),
      ));
      menuList.add(PopupMenuItem(
          value: ParamUtils.actionGuiTiep,
          child: UIUtils.setMenuIconText(Language.getText('guitiep'), Icons.send_outlined),
        ));

    menuList.add(PopupMenuItem(
      value: ParamUtils.actionTraLoi,
      child: UIUtils.setMenuIconText(Language.getText('traloi'), Icons.next_plan_rounded),
    ));
    menuList.add(PopupMenuItem(
      value: ParamUtils.actionTraLoiTatCa,
      child: UIUtils.setMenuIconText(Language.getText('traloitatca'), Icons.supervised_user_circle_outlined),
    ));

    ServiceThu().getById(this.widget.id).then((value) {
      if(value.ghim == ParamUtils.statusOFF)
      menuList.add(PopupMenuItem(
        value: ParamUtils.actionGhimThu,
        child: UIUtils.setMenuIconText(Language.getText('ghimthu'), Icons.star),
      ));
      if(value.ghim == ParamUtils.statusON)
      menuList.add(PopupMenuItem(
        value: ParamUtils.actionHuyGhimThu,
        child: UIUtils.setMenuIconText(Language.getText('huyghimthu'), Icons.star_border_outlined),
      ));
    });

    menuList.add(PopupMenuItem(
      value: ParamUtils.actionChuyenTrinh,
      child: UIUtils.setMenuIconText(Language.getText('chuyentrinh'), Icons.add_business_rounded),
    ));
    menuList.add(PopupMenuItem(
      value: ParamUtils.actionChenHoSo,
      child: UIUtils.setMenuIconText(Language.getText('chenhoso'), Icons.account_balance_wallet_rounded),
    ));
    menuList.add(PopupMenuItem(
      value: ParamUtils.actionChuyenGiaoViec,
      child: UIUtils.setMenuIconText(Language.getText('chuyengiaoviec'), Icons.filter),
    ));

  }
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThu().deleteAllByIds(this.widget.id.toString(),ParamUtils.statusOFF,ParamUtils.statusON).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context,true);

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _ghimThu() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThu().ghimMail(this.widget.id,UserAuthSession.staffId).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_ghimthu_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context,true);

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _huyGhimThu() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceThu().unGhimMail(this.widget.id).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_unghimthu_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context,true);

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
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

                  if(value==ParamUtils.actionDelete) {
                    UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_question') );
                  }
                  if(value==ParamUtils.actionFileAttach) {
                    ServiceThuFile().getAllByThuId(this.widget.id).then((value)
                    {
                      List<FileLink> fileLinks=[];
                      for(var item in value)
                      {
                        fileLinks.add(new FileLink(name: item.name,
                            link: ApiUtils().getDownloadFileUrl(item.folder, item.fileKey, item.width, item.name)));
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                DonwloadFileDialog( files: fileLinks),
                            fullscreenDialog: true,
                          ));
                    });
                  }
                  if(value==ParamUtils.actionGuiTiep) {
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => new GuiTiepThu(id: this.widget.id,
                        title: Language.getText('guitiep'), callBackRefresh: () =>
                        setState((){ })
                        )),);
                  }
                  if(value==ParamUtils.actionTraLoi) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new TraLoiThu(
                        id: this.widget.id,
                        title: Language.getText('traloi'),
                        traLoi: false,
                        callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionTraLoiTatCa) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new TraLoiThu(
                        id: this.widget.id,
                        title: Language.getText('traloitatca'),
                        traLoi: true,
                        callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionGhimThu) {
                    UIAction(_ghimThu).showDialogConfirm(context, Language.getText('message_ghimthu_question') );
                  }
                  if(value==ParamUtils.actionHuyGhimThu) {
                    UIAction(_huyGhimThu).showDialogConfirm(context, Language.getText('message_unghimthu_question') );
                  }
                  if(value==ParamUtils.actionChuyenTrinh) {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ChuyenTrinhThu(id: this.widget.id, title: Language.getText("chuyentrinh")),
                          fullscreenDialog: true,
                        ));
                  }
                  if(value==ParamUtils.actionChenHoSo) {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ThuChenHoSo(id: this.widget.id),
                          fullscreenDialog: true,
                        ));
                  }
                  if(value==ParamUtils.actionChuyenGiaoViec) {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ThuChuyenGiaoViec(id: this.widget.id, title: Language.getText("chuyengiaoviec")),
                          fullscreenDialog: true,
                        ));
                  }
                })
          ]
      );


  }


}
