import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/vanbanphapquy/service-vanbanphapquy.dart';
import 'package:egovapp/service/vanbanphapquy/service-vanbanphapquyfile.dart';
import 'package:flutter/material.dart';
class EditVanBanPhapQuy extends StatefulWidget
{
  const EditVanBanPhapQuy({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditVanBanPhapQuyState createState() => _EditVanBanPhapQuyState();}
class _EditVanBanPhapQuyState extends State<EditVanBanPhapQuy>
{
  var  txtSoHieuGoc=  TextEditingController();
  var  dtNgayKy=  TextEditingController();
  TextEditingController  txtTrichYeu =  TextEditingController();
  TextEditingController  txtNoiGuiPhatHanh =  TextEditingController();
  List<FileItem> fileUploads= [];
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceVanBanPhapQuy().getById(this.widget.id).then((value) {
        this.txtTrichYeu.value = new TextEditingValue(text: value.trichYeu );
        this.txtNoiGuiPhatHanh.value = new TextEditingValue(text: value.noiGui );
        this.txtSoHieuGoc.value = new TextEditingValue(text: value.soHieuGoc);
        this.dtNgayKy.value = new TextEditingValue(text: value.ngayKy);
        if (value.vanBanPhapQuyFiles.length > 0) {
          for (var f in value.vanBanPhapQuyFiles)
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
      ServiceVanBanPhapQuy().delete(fileItem.id).then((value) {
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
    if(this.widget.id ==0) {
      ServiceVanBanPhapQuy().add(
          this.txtSoHieuGoc.text ,
          this.dtNgayKy.text,
          this.txtTrichYeu.text
          , this.txtNoiGuiPhatHanh.text).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceVanBanPhapQuyFile().add(value.id, f.path!);
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
      ServiceVanBanPhapQuy().update(this.widget.id,
          this.txtSoHieuGoc.text ,
          this.dtNgayKy.text,
          this.txtTrichYeu.text
          , this.txtNoiGuiPhatHanh.text).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceVanBanPhapQuyFile().add(value.id, f.path!);
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
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtSoHieuGoc,TextInputType.text,
                    Language.getText('sohieugoc'), Language.getText('sohieugoc'), true, Language.getText('sohieugoc')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgayKy,
                    title:Language.getText('ngayky'),
                    description: Language.getText('ngayky'),
                    validate: true,
                    messageRequired: Language.getText('ngayky')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtTrichYeu,TextInputType.multiline,
                    Language.getText('trichyeu'), Language.getText('trichyeu'), true, Language.getText('trichyeu')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtNoiGuiPhatHanh,TextInputType.multiline,
                    Language.getText('noiguiphathanh'), Language.getText('noiguiphathanh'), true, Language.getText('noiguiphathanh')+Language.getText('required_empty'))
            ),
            Container(
                padding: UIUtils.paddingForm,
                child: AttachFileFormAction(fileUploads: fileUploads, deleteFile: deleteFile)
            ),
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_vanbanphapquy_question'));
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
