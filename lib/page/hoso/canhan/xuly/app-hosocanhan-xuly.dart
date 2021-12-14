import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/hoso/canhan/xuly/hosocanhan-edit.dart';
import 'package:egovapp/page/hoso/canhan/xuly/share.dart';
import 'package:egovapp/page/hoso/donvi/xuly/hosodonvi-edit.dart';
import 'package:egovapp/page/hoso/donvi/xuly/ykientonghop.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/hoso/service-hoso.dart';
import 'package:egovapp/service/hoso/service-hosofile.dart';

import 'package:flutter/material.dart';
class AppBarHoSoCaNhanXuLyAction extends StatefulWidget {
  const AppBarHoSoCaNhanXuLyAction({Key? key, required this.id,
    required this.title,
    required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarHoSoCaNhanXuLyActionState createState() => _AppBarHoSoCaNhanXuLyActionState();
}

class _AppBarHoSoCaNhanXuLyActionState extends State<AppBarHoSoCaNhanXuLyAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();
    ServiceHoSo().getById(this.widget.id).then((value){
      menuList.add(PopupMenuItem(
        value: ParamUtils.actionFileAttach,
        child: UIUtils.setMenuIconText(Language.getText('filedinhkem'), Icons.attach_file),
      ));

      if(value.nguoiTao == UserAuthSession.staffId)
      {
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionUpdate,
          child: UIUtils.setMenuIconText(Language.getText('update'), Icons.edit),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionDelete,
          child: UIUtils.setMenuIconText(Language.getText('delete'), Icons.delete_rounded),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionShare,
          child: UIUtils.setMenuIconText(Language.getText('share'), Icons.share),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionFolder,
          child: UIUtils.setMenuIconText(Language.getText('foldersave'), Icons.folder),
        ));
      }

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceHoSo().delete(this.widget.id).then((value){
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
                  if(value==ParamUtils.actionUpdate) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditHoSoCaNhan(id: this.widget.id,
                        title: Language.getText('capnhathosocanhan'), callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionDelete) {
                    UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_question') );
                  }

                  if(value==ParamUtils.actionFileAttach) {
                    ServiceHoSoFile().getAllByHoSoId(this.widget.id).then((value)
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

                  if(value==ParamUtils.actionShare) {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ShareHoSoCaNhan(id: this.widget.id, title: this.widget.title),
                          fullscreenDialog: true,
                        ));
                  }
                  if(value==ParamUtils.actionFolder) {

                  }
                })
          ]
      );


  }


}
