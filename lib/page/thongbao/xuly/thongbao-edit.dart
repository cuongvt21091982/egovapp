import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/meeting/meetingxuly.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/thongbao/thongbaonguoidoc.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/thongbao/service-thongbao.dart';
import 'package:egovapp/service/thongbao/service-thongbaofile.dart';
import 'package:egovapp/service/thongbao/service-thongbaonguoidoc.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class EditThongBao extends StatefulWidget
{
  const EditThongBao({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditThongBaoState createState() => _EditThongBaoState();}
class _EditThongBaoState extends State<EditThongBao>
{
  HtmlEditorController controller = HtmlEditorController();
  var  dtNgayHieuLuc=  TextEditingController();
  var  dtNgayHetHieuLuc=  TextEditingController();
  TextEditingController  txtChuDe =  TextEditingController();
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  String users= '';
  String noiDung='';
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceThongBao().getById(this.widget.id).then((value) {
        this.dtNgayHieuLuc.value = TextEditingValue(text: value.ngayHieuLuc);
        this.dtNgayHetHieuLuc.value = TextEditingValue(text: value.ngayHetHieuLuc);
        this.txtChuDe.value = new TextEditingValue(text: value.chuDe );
        if (value.thongBaoFiles.length > 0) {
          for (var f in value.thongBaoFiles)
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
      ServiceThongBaoFile().delete(fileItem.id).then((value) {
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
      ServiceThongBao().add(
          this.staffsSelect.map((e) => e.id).toList().join(','),
          this.txtChuDe.text,
          dtNgayHieuLuc.text
          ,valueContent
          ,dtNgayHetHieuLuc.text, UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceThongBaoFile().add(value.id, f.path!);
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
      ServiceThongBao().update(
          this.staffsSelect.map((e) => e.id).toList().join(','),
          this.widget.id,
          this.txtChuDe.text,
          dtNgayHieuLuc.text
          ,valueContent
          ,dtNgayHetHieuLuc.text, UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceThongBaoFile().add(value.id, f.path!);
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
                future: ServiceThongBaoNguoiDoc().getAllByThongBaoId(this.widget.id).catchError((e){
                  UIUtils.showToastError(e.toString(), context);
                }),
                builder: (context ,AsyncSnapshot  snapshot) {
                  if(snapshot.hasData) {
                    List<ThongBaoNguoiDoc> thongBaoNguoiDocList= [];
                    staffsSelect=[];
                    thongBaoNguoiDocList.addAll(snapshot.data);
                    for (var st in thongBaoNguoiDocList)
                      staffsSelect.add(st.nguoiDoc);
                  }
                  return UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoidoc'));
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
                child:    UIDateTimeAction( textEdit: this.dtNgayHieuLuc,
                    title:Language.getText('ngayhieuluc'),
                    description: Language.getText('ngayhieuluc'),
                    validate: true,
                    messageRequired: Language.getText('ngayhieuluc')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgayHetHieuLuc,
                    title:Language.getText('ngayhethieuluc'),
                    description: Language.getText('ngayhethieuluc'),
                    validate: true,
                    messageRequired: Language.getText('ngayhethieuluc')+Language.getText('required_empty'))
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_thongbao_question'));
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
