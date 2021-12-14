import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/meeting/meetingxuly.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/meeting/service-meeting.dart';
import 'package:egovapp/service/meeting/service-meetingfile.dart';
import 'package:egovapp/service/meeting/service-meetingxuly.dart';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class EditMeeting extends StatefulWidget
{
  const EditMeeting({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditMeetingState createState() => _EditMeetingState();}
class _EditMeetingState extends State<EditMeeting>
{
  HtmlEditorController controller = HtmlEditorController();
  var  dtThoiHan =  TextEditingController();
  TextEditingController  txtChuDe =  TextEditingController();
  bool choPhepThamKhao= false;
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  String users= '';
  String noiDung='';
  int status = ParamUtils.statusDraft;
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceMeeting().getById(this.widget.id).then((value) {
        this.status = value.trangThai;
        this.noiDung = noiDung;
        this.choPhepThamKhao = value.choThamKhao == ParamUtils.statusON ? true: false;
        this.dtThoiHan.value = TextEditingValue(text: value.thoiGianHoanThanh);
        this.txtChuDe.value = new TextEditingValue(text: value.chuDe );
        if (value.meetingFiles.length > 0) {
          for (var f in value.meetingFiles)
            this.fileUploads.add(new FileItem(id: f.id,
                key: f.fileKey,
                name: f.name,
                path: f.folder,
                action: true));
        }
        setState((){
          this.noiDung = value.noiDung;
        });
      }).catchError((onError) {
        Navigator.pop(context, false);
        UIUtils.showToastError(onError.toString(), context);
      });
    }
  }
  Future<void> deleteFile(FileItem fileItem)
  async {
    if(fileItem.action == false)
    {
      setState(() {
        fileUploads.remove(fileItem);
      });
    }
    else
    {
      final dialogContextCompleter = UIUtils.progressAction(context);
      final dialogContext = await dialogContextCompleter.future;
      ServiceMeetingFile().delete(fileItem.id).then((value) {
        Navigator.pop(dialogContext, true);
        setState(() {
          fileUploads.remove(fileItem);
        });
      }).catchError((e){
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      }
      );
    }
  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    final valueContent = await controller.getText();
    if(this.widget.id ==0) {
      ServiceMeeting().add(
          this.staffsSelect.map((e) => e.id).toList().join(','),
          this.txtChuDe.text,
          dtThoiHan.text,
          (this.choPhepThamKhao == true? ParamUtils.statusON: ParamUtils.statusOFF)
          ,valueContent
          , status, UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceMeetingFile().add(value.id, f.path!);
          }
        }
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context, true);
      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }else
    {
      ServiceMeeting().update(
          this.staffsSelect.map((e) => e.id).toList().join(','),
          this.widget.id,
          this.txtChuDe.text,
          dtThoiHan.text,
          (this.choPhepThamKhao == true? ParamUtils.statusON: ParamUtils.statusOFF)
          ,valueContent
          , status, UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceMeetingFile().add(value.id, f.path!);
          }
        }
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context, true);
      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var formEdit=Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FutureBuilder(
                future: ServiceMeetingXuLy().getAllByMaYeuCau(this.widget.id).catchError((e){
                  UIUtils.showToastError(e.toString(), context);
                }),
                builder: (context ,AsyncSnapshot  snapshot) {
                  if(snapshot.hasData) {
                    List<MeetingXuLy> meetingXuLyList= [];
                    staffsSelect=[];
                    meetingXuLyList.addAll(snapshot.data);
                    for (var st in meetingXuLyList)
                      staffsSelect.add(st.nguoiXuLy);

                  }
                  return UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoihop'));

                },

              )
              ,
              padding: UIUtils.paddingForm,
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtChuDe,TextInputType.text,
                    Language.getText('chude'), Language.getText('chude'), true, Language.getText('chude')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtThoiHan,
                    title:Language.getText('thoihan'),
                    description: Language.getText('thoihan'),
                    validate: false,
                    messageRequired: '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: Row(
                    children: [
                      Checkbox(
                          value: choPhepThamKhao,
                          onChanged: (bool? value) {
                            setState(() {
                              choPhepThamKhao = value!;
                            });
                          }),
                      UIUtils.setTextUserName(Language.getText('chophepthamkhaohop'))
                    ]
                )
            ),
            Container(
                padding: UIUtils.paddingForm,
                child: AttachFileFormAction(fileUploads: fileUploads, deleteFile: deleteFile)
            ),
            Container(child:
            SizedBox(
                height: 400,
                child: UIUtils.setHtmlEditor(controller, this.noiDung)
            )
            ) ,
            Container(
                alignment: Alignment.topLeft,
                padding: UIUtils.paddingForm,
                child: UIUtils.getNoteRequired()
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            this.status = ParamUtils.statusDangXuLy;
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_meeting_question'));
                          }

                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.send) ,
                          label: UIUtils.setButtonResetText(Language.getText("save")
                          ),

                        )
                    )
                  ],)
            )

          ],
        ),
      ),
    );
    return new WillPopScope(child:  Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: Text(widget.title),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: formEdit
    ),
        onWillPop:  () {
          this.widget.callBackRefresh();
          return new Future.value(true);
        });

  }
}
