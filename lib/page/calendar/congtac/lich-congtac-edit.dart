import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/format-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/calendar/service-calendarnews.dart';
import 'package:egovapp/service/calendar/service-calendarnewsfile.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class EditLichCongTac extends StatefulWidget
{
  const EditLichCongTac({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditLichCongTacState createState() => _EditLichCongTacState();}
class _EditLichCongTacState extends State<EditLichCongTac>
{
  HtmlEditorController controller = HtmlEditorController();
  var  dtTuNgay=  TextEditingController();
  var  dtTuGio=  TextEditingController();
  var  dtDenGio=  TextEditingController();
  var  dtDenNgay=  TextEditingController();
  TextEditingController  txtNguoiChuTri =  TextEditingController();
  TextEditingController  txtDiaDiem =  TextEditingController();
  TextEditingController  txtGhiChu =  TextEditingController();
  List<FileItem> fileUploads= [];
  String users= '';
  String noiDung='';
  Color pickColor = Colors.red;
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceCalendarNews().getById(this.widget.id).then((value) {
        this.txtNguoiChuTri.value = new TextEditingValue(text: value.chuTri );
        this.txtGhiChu.value = new TextEditingValue(text: value.ghiChu );
        this.txtDiaDiem.value=new TextEditingValue(text: value.diaDiem );
        this.pickColor = FormatUtils.fromHex(value.bgColor);
        if (value.calendarNewsFiles.length > 0) {
          for (var f in value.calendarNewsFiles)
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
  callColorPick(Color color)
  {
    this.pickColor = color;
    debugPrint(FormatUtils.toHex(this.pickColor));
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
      ServiceCalendarNewsFile().delete(fileItem.id).then((value) {
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
      ServiceCalendarNews().add(
          FormatUtils.formatDateVN(dtTuNgay.text),
          dtTuGio.text,
          FormatUtils.formatDateVN(dtDenNgay.text),
          dtDenGio.text,
          valueContent,
          txtDiaDiem.text,
          txtNguoiChuTri.text,
          txtGhiChu.text,
          FormatUtils.toHex(this.pickColor),
           UserAuthSession.staffId,
          0,
          0
        ).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceCalendarNewsFile().add(value.id, f.path!);
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
      ServiceCalendarNews().update(this.widget.id,
          FormatUtils.formatDateVN(dtTuNgay.text),
          dtTuGio.text,
          FormatUtils.formatDateVN(dtDenNgay.text),
          dtDenGio.text,
          valueContent,
          txtDiaDiem.text,
          txtNguoiChuTri.text,
          txtGhiChu.text,
          FormatUtils.toHex(this.pickColor),
          UserAuthSession.staffId,
          0,
          0).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceCalendarNewsFile().add(value.id, f.path!);
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
                child: UIFormAction().setTextFormField(this.txtNguoiChuTri,TextInputType.text,
                    Language.getText('nguoichutri'), Language.getText('nguoichutri'), false, Language.getText('nguoichutri')+Language.getText('required_empty'))
            ),
            Container(
                padding: UIUtils.paddingForm,
                child: UIPickerColorAction(colorPicker: callColorPick,colorDefault: this.pickColor)
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtTuNgay,
                    title:Language.getText('tungay'),
                    description: Language.getText('tungay'),
                    validate: false,
                    messageRequired: '')
            ), Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.dtTuGio,TextInputType.text,
                    Language.getText('tugio'), Language.getText('tugio'), false, Language.getText('tugio')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtDenNgay,
                    title:Language.getText('denngay'),
                    description: Language.getText('denngay'),
                    validate: false,
                    messageRequired: '')
            ), Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.dtDenGio,TextInputType.text,
                    Language.getText('dengio'), Language.getText('dengio'), false, Language.getText('dengio')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDiaDiem,TextInputType.multiline,
                    Language.getText('diadiem'), Language.getText('diadiem'), false, Language.getText('diadiem')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDiaDiem,TextInputType.multiline,
                    Language.getText('ghichu'), Language.getText('ghichu'), false, Language.getText('ghichu')+Language.getText('required_empty'))
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_lichcongtac_question'));
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
