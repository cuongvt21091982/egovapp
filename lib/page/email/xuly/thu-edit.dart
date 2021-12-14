import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/email/service-documentdraft.dart';
import 'package:egovapp/service/email/service-documentdraftfile.dart';
import 'package:egovapp/service/email/service-thu.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class EditThu extends StatefulWidget
{
  const EditThu({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditThuState createState() => _EditThuState();}
class _EditThuState extends State<EditThu>
{
  HtmlEditorController controller = HtmlEditorController();
  TextEditingController  txtChuDe =  TextEditingController();
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  String users= '';
  String noiDung='';
  bool sendMail= false;
  bool send = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceDocumentDraft().getById(this.widget.id).then((value) {
        this.txtChuDe.value = new TextEditingValue(text: value.chuDe );
        if(value.lstReceiveUsers!='')
          ServiceStaffs().findAllByStaffId(value.lstReceiveUsers).then((value2){
                setState(() {
                  this.noiDung = value.noiDung;
                  staffsSelect=value2;
                });
          })..catchError((onError2) {
            UIUtils.showToastError(onError2.toString(), context);
          });
        if (value.documentDraftFiles.length > 0) {
          for (var f in value.documentDraftFiles)
            this.fileUploads.add(new FileItem(id: f.id,
                key: f.fileKey,
                name: f.name,
                path: f.folder,
                action: true));
        }

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
      ServiceDocumentDraftFile().delete(fileItem.id).then((value) {
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
      ServiceDocumentDraft().add(txtChuDe.text,
          UserAuthSession.staffId,
          valueContent,
          ParamUtils.docTypeEmail,
          this.staffsSelect.map((e) => e.id).toList().join(','),
          0,
          sendMail?ParamUtils.statusON:ParamUtils.statusOFF).then((value) {
          UIUtils.showToastSuccess(
            Language.getText('message_send_success'), context);
          if(send== true) {
            ServiceThu().addByDraftId(value.id).then((value2) {
                for (var f in fileUploads) {
                    if (f.path != null && f.action == false) {
                  ServiceDocumentDraftFile().add(value2.nhomThu,0,1, f.path!);
                }
              }
                UIUtils.showToastSuccess(
                    Language.getText( 'message_send_mail_success'), context);
                Navigator.pop(dialogContext, true);
                this.widget.callBackRefresh();
                Navigator.pop(context, true);
            }).catchError((e2) {
            UIUtils.showToastError(e2.toString(), context);
            });

          }else {
            for (var f in fileUploads) {
              if (f.path != null && f.action == false) {
                ServiceDocumentDraftFile().add(value.id,0,0, f.path!);
              }
            }
            UIUtils.showToastSuccess(
                Language.getText( 'message_send_mail_success'), context);
            Navigator.pop(dialogContext, true);
            this.widget.callBackRefresh();
            Navigator.pop(context, true);
          }

      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }else
    {
      ServiceDocumentDraft().update(this.widget.id,
          txtChuDe.text,
          UserAuthSession.staffId,
          valueContent,
          ParamUtils.docTypeEmail,
          this.staffsSelect.map((e) => e.id).toList().join(','),
          0,
          sendMail?ParamUtils.statusON:ParamUtils.statusOFF).then((value) {

        if(send== true) {
          ServiceThu().addByDraftId(value.id).then((value2) {
            for (var f in fileUploads) {
              if (f.path != null && f.action == false) {
                ServiceDocumentDraftFile().add(value2.nhomThu, 0, 1, f.path!);
              }
            }
            UIUtils.showToastSuccess(
                Language.getText( 'message_send_mail_success'), context);
            Navigator.pop(dialogContext, true);
            this.widget.callBackRefresh();
            Navigator.pop(context, true);
          }).catchError((e2) {
            UIUtils.showToastError(e2.toString(), context);
          });

        }else {

          for (var f in fileUploads) {
            debugPrint("PATH FILE:"+f.path!);
            debugPrint("PATH ACTION:"+f.action.toString());
            if (f.path != null && f.action == false) {

              ServiceDocumentDraftFile().add(value.id,0,0, f.path!);
            }
          }
          UIUtils.showToastSuccess(
              Language.getText( 'message_update_success'), context);
          Navigator.pop(dialogContext, true);
          this.widget.callBackRefresh();
          Navigator.pop(context, true);
        }
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
              child: UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoinhan'))
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
                child: Row(
                    children: [
                      Checkbox(
                          value: sendMail,
                          onChanged: (bool? value) {
                            setState(() {
                              sendMail = value!;
                            });
                          }),
                      UIUtils.setTextUserName(Language.getText('guirangoai'))
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_email_question'));
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonResetText(Language.getText("save_draft")
                          ),
                        )
                    ),
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            this.send = true;
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_send_email_question'));
                          }
                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.send) ,
                          label: UIUtils.setButtonResetText(Language.getText("send")
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
