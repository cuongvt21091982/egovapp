import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/totrinh/xuly/assign.dart';
import 'package:egovapp/page/totrinh/xuly/chenhoso.dart';
import 'package:egovapp/page/totrinh/xuly/chuyengiaoviec.dart';
import 'package:egovapp/page/totrinh/xuly/chuyentrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinhxuly.dart';
import 'change-date.dart';
import 'edittotrinh.dart';
import 'ykientonghop.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinhfile.dart';
import 'package:flutter/material.dart';
class AppBarToTrinhXuLyAction extends StatefulWidget {
  const AppBarToTrinhXuLyAction({Key? key, required this.id,
                                  required this.title,
                                  required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarToTrinhXuLyAction createState() => _AppBarToTrinhXuLyAction();
}
class _AppBarToTrinhXuLyAction extends State<AppBarToTrinhXuLyAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();
    ServiceToTrinh().getById(this.widget.id).then((value){
      menuList.add(
          PopupMenuItem(
            value: ParamUtils.actionSumComment,
            child: UIUtils.setMenuIconText(Language.getText('ykientonghop'), Icons.add_reaction),
          )
      );
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
        child: UIUtils.setMenuIconText(Language.getText('chuyengiaoviec'), Icons.add_to_photos_sharp),
      ));
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai != ParamUtils.statusHoanThanh) {
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionChangeDate,
          child: UIUtils.setMenuIconText(
              Language.getText('updatedate'), Icons.date_range_sharp),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionAssign,
          child: UIUtils.setMenuIconText(Language.getText('assign'), Icons.person_add),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionUpdate,
          child: UIUtils.setMenuIconText(Language.getText('update'), Icons.edit),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionDelete,
          child: UIUtils.setMenuIconText(Language.getText('delete'), Icons.delete_rounded),
        ));
      }
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai == ParamUtils.statusHoanThanh)
        menuList.add( PopupMenuItem(
          value: ParamUtils.actionRepeat,
          child: UIUtils.setMenuIconText(Language.getText('xulylai'), Icons.refresh),
        ));
      ServiceToTrinhXuLy().getByMaVBAndMaXL(widget.id, UserAuthSession.staffId).then((value2) {
        if((value.maNguoiChuTri == UserAuthSession.staffId || value2.trangThai != ParamUtils.statusHoanThanh ) && value.trangThai != ParamUtils.statusHoanThanh) {
          menuList.add(PopupMenuItem(
            value: ParamUtils.actionSuccess,
            child: UIUtils.setMenuIconText(
                Language.getText('hoanthanh'), Icons.task_alt),
          ));
        }
      }).catchError((ex){
        UIUtils.showToastError(ex.toString(), context);
      });

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
    });
  }
  dynamic _delete() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
      ServiceToTrinh().delete(this.widget.id).then((value){
        UIUtils.showToastSuccess(value.status == true ? Language.getText('message_delete_success') : Language.getText('message_error'), context);
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context,true);
      }).catchError((e){
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
  }
  dynamic _changeStatus() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceToTrinhXuLy().changeStatus(this.widget.id, ParamUtils.statusHoanThanh, UserAuthSession.staffId).then((value){
      UIUtils.showToastSuccess(value == ParamUtils.statusSuccess ? Language.getText('change_hoanthanh_success') : Language.getText('message_error'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context,true);

    }).catchError((e){
      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  dynamic _xuLyLai() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceToTrinhXuLy().xuLyLai(this.widget.id, ParamUtils.statusChuaXuLy, UserAuthSession.staffId).then((value){
      UIUtils.showToastSuccess(value == ParamUtils.statusSuccess ? Language.getText('message_xulylai_success') : Language.getText('message_error'), context);
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
    return Container(
        child:
        Row(
            children: <Widget>[
              PopupMenuButton(
                  itemBuilder: (context) {
                    return menuList;
                  },
                  onSelected: (String value) async{
                    if(value==ParamUtils.actionUpdate) {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditToTrinh(id: this.widget.id,
                          title: Language.getText('capnhattotrinh'), callBackRefresh: () =>
                              setState((){ })
                      )),);
                    }
                    if(value==ParamUtils.actionDelete) {
                      UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_question') );
                    }
                    if(value==ParamUtils.actionChangeDate) {
                      new ChangeDateToTrinh(id: this.widget.id, context: context, callBackRefresh: this.widget.callBackRefresh).showChange();
                    }
                    if(value==ParamUtils.actionAssign) {
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new AssignToTrinh(id: this.widget.id,
                          title: Language.getText('assign'), callBackRefresh: () =>
                              setState((){ })
                      )),);
                    }
                    if(value==ParamUtils.actionFileAttach) {
                      ServiceToTrinhFile().getAllByToTrinhId(this.widget.id).then((value)
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
                    if(value==ParamUtils.actionSumComment) {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ToTrinhYKienTongHopDialog(id: this.widget.id, title: this.widget.title),
                            fullscreenDialog: true,
                          ));
                    }
                    if(value==ParamUtils.actionSuccess) {
                      UIAction(_changeStatus).showDialogConfirm(context, Language.getText('message_hoanthanh_question') );
                    }
                    if(value==ParamUtils.actionRepeat) {
                      UIAction(_xuLyLai).showDialogConfirm(context, Language.getText('message_xulylai_question') );
                    }
                    if(value==ParamUtils.actionChuyenTrinh) {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ChuyenTrinhToTrinh(id: this.widget.id, title: Language.getText("chuyentrinh")),
                            fullscreenDialog: true,
                          ));
                    }
                    if(value==ParamUtils.actionChenHoSo) {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ToTrinhChenHoSo(id: this.widget.id),
                            fullscreenDialog: true,
                          ));
                    }
                    if(value==ParamUtils.actionChuyenGiaoViec) {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => ToTrinhChuyenGiaoViec(id: this.widget.id, title: Language.getText("chuyengiaoviec")),
                            fullscreenDialog: true,
                          ));
                    }
                  })
            ]
        )
    );

  }


}
