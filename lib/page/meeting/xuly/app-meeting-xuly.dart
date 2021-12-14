import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/meeting/xuly/assign.dart';
import 'package:egovapp/page/meeting/xuly/change-date.dart';
import 'package:egovapp/page/meeting/xuly/meeting-edit.dart';
import 'package:egovapp/page/meeting/xuly/ykientonghop.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/meeting/service-meeting.dart';
import 'package:egovapp/service/meeting/service-meetingfile.dart';
import 'package:egovapp/service/meeting/service-meetingxuly.dart';
import 'package:flutter/material.dart';
class AppBarMeetingXuLyAction extends StatefulWidget {
  const AppBarMeetingXuLyAction({Key? key, required this.id,
    required this.title,
    required this.callBackRefresh}) : super(key: key);
  final VoidCallback callBackRefresh;
  final int id;
  final String title;
  @override
  _AppBarMeetingXuLyActionState createState() => _AppBarMeetingXuLyActionState();
}

class _AppBarMeetingXuLyActionState extends State<AppBarMeetingXuLyAction> {
  List<PopupMenuEntry<String>> menuList= [];
  @override
  void initState() {
    super.initState();
    ServiceMeeting().getById(this.widget.id).then((value){
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
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai != ParamUtils.statusHoanThanh) {
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionChangeDate,
          child: UIUtils.setMenuIconText(
              Language.getText('updatedate'), Icons.date_range_sharp),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionAssign,
          child: UIUtils.setMenuIconText(Language.getText('assignhop'), Icons.person_add),
        ));

      }
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai != ParamUtils.statusHoanThanh && value.choThamKhao == ParamUtils.choThamKhao)
        menuList.add( PopupMenuItem(
          value: ParamUtils.actionAcceptTK,
          child: UIUtils.setMenuIconText(Language.getText('khongchophepthamkhao'), Icons.verified_user_outlined),
        ));
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai != ParamUtils.statusHoanThanh && value.choThamKhao == ParamUtils.khongChoThamKhao)
        menuList.add(  PopupMenuItem(
          value: ParamUtils.actionAcceptTK,
          child: UIUtils.setMenuIconText(Language.getText('chophepthamkhao'), Icons.verified_user),
        ));
      if(value.maNguoiChuTri == UserAuthSession.staffId && value.trangThai !=ParamUtils.statusHoanThanh)
      {
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionUpdate,
          child: UIUtils.setMenuIconText(Language.getText('update'), Icons.edit),
        ));
        menuList.add(PopupMenuItem(
          value: ParamUtils.actionDelete,
          child: UIUtils.setMenuIconText(Language.getText('delete'), Icons.delete_rounded),
        ));
      }
      ServiceMeetingXuLy().getByMaVBAndMaXL(widget.id, UserAuthSession.staffId).then((value2) {
        if((value.maNguoiChuTri == UserAuthSession.staffId || value2.trangThai != ParamUtils.statusHoanThanh ) && value.trangThai != ParamUtils.statusHoanThanh) {
          menuList.add(PopupMenuItem(
            value: ParamUtils.actionSuccess,
            child: UIUtils.setMenuIconText(
                Language.getText('ketthuc'), Icons.task_alt),
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
    ServiceMeeting().delete(this.widget.id).then((value){
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
    ServiceMeetingXuLy().changeStatus(this.widget.id, ParamUtils.statusHoanThanh, UserAuthSession.staffId).then((value){
      UIUtils.showToastSuccess(value == ParamUtils.statusSuccess ? Language.getText('change_ketthuc_success') : Language.getText('message_error'), context);
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
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditMeeting(id: this.widget.id,
                        title: Language.getText('capnhatmeeting'), callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionDelete) {
                    UIAction(_delete).showDialogConfirm(context, Language.getText('message_delete_question') );
                  }
                  if(value==ParamUtils.actionChangeDate) {
                    new ChangeDateMeeting(id: this.widget.id, context: context, callBackRefresh: this.widget.callBackRefresh).showChange();
                  }
                  if(value==ParamUtils.actionAssign) {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new AssignMeeting(id: this.widget.id,
                        title: Language.getText('assignhop'), callBackRefresh: () =>
                            setState((){ })
                    )),);
                  }
                  if(value==ParamUtils.actionFileAttach) {
                    ServiceMeetingFile().getAllByMeetingId(this.widget.id).then((value)
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
                          builder: (BuildContext context) => MeetingYKienTongHopDialog(id: this.widget.id, title: this.widget.title),
                          fullscreenDialog: true,
                        ));
                  }
                  if(value==ParamUtils.actionSuccess) {
                    UIAction(_changeStatus).showDialogConfirm(context, Language.getText('message_hoanthanh_question') );
                  }

                })
          ]
      );


  }


}
