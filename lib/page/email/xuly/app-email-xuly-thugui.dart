import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/page/email/xuly/chenhoso.dart';
import 'package:egovapp/page/email/xuly/chuyengiaoviec.dart';
import 'package:egovapp/page/email/xuly/chuyentrinh.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-thutemp.dart';
import 'package:flutter/material.dart';
class AppBarEmailXuLyThuGuiAction extends StatefulWidget {
  const AppBarEmailXuLyThuGuiAction({Key? key, required this.id,
    required this.title,
    required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarEmailXuLyThuGuiActionState createState() => _AppBarEmailXuLyThuGuiActionState();
}

class _AppBarEmailXuLyThuGuiActionState extends State<AppBarEmailXuLyThuGuiAction> {
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
    ServiceThuTemp().deleteAllByIds(this.widget.id.toString(),ParamUtils.statusOFF,ParamUtils.statusON).then((value){
      UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
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
                    ServiceThuTemp().getById(this.widget.id).then((value)
                    {
                      List<FileLink> fileLinks=[];
                      for(var item in value.thuFiles)
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
