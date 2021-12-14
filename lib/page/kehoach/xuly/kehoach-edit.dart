import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/danhmuc/loaikehoach.dart';
import 'package:egovapp/model/kehoach/kehoachnguoidoc.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/danhmuc/service-loaikehoach.dart';
import 'package:egovapp/service/kehoach/service-kehoach.dart';
import 'package:egovapp/service/kehoach/service-kehoachfile.dart';
import 'package:egovapp/service/kehoach/service-kehoachnguoidoc.dart';


import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class EditKeHoach extends StatefulWidget
{
  const EditKeHoach({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditKeHoachState createState() => _EditKeHoachState();}
class _EditKeHoachState extends State<EditKeHoach>
{
  HtmlEditorController controller = HtmlEditorController();
  var  dtNgayHieuLuc=  TextEditingController();
  var  dtNgayHetHieuLuc=  TextEditingController();
  TextEditingController  txtChuDe =  TextEditingController();
  TextEditingController  txtGhiChu =  TextEditingController();
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  LoaiKeHoach? loaiKeHoach;
  String users= '';
  String noiDung='';
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceKeHoach().getById(this.widget.id).then((value) {
        this.txtChuDe.value = new TextEditingValue(text: value.tenKH );
        if (value.keHoachFiles.length > 0) {
          for (var f in value.keHoachFiles)
            this.fileUploads.add(new FileItem(id: f.id,
                key: f.fileKey,
                name: f.name,
                path: f.folder,
                action: true));
        }
        setState((){
          this.noiDung = value.noiDungKH;
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
      ServiceKeHoachFile().delete(fileItem.id).then((value) {
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
      ServiceKeHoach().add(
          this.staffsSelect.map((e) => e.id).toList().join(','),
          (this.loaiKeHoach?.id??0),
          this.txtChuDe.text ,
          valueContent,
          txtGhiChu.text
          , UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceKeHoachFile().add(value.id, f.path!);
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
      ServiceKeHoach().update(this.widget.id,
          this.staffsSelect.map((e) => e.id).toList().join(','),
          (this.loaiKeHoach?.id??0),
          this.txtChuDe.text ,
          valueContent,
          txtGhiChu.text
          , UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceKeHoachFile().add(value.id, f.path!);
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
  Future<List<LoaiKeHoach>> selectLoaiKeHoach(String? filter)
  {
    return ServiceLoaiKeHoach().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
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
                future: ServiceKeHoachNguoiDoc().getAllByKeHoachId(this.widget.id).catchError((e){
                  UIUtils.showToastError(e.toString(), context);
                }),
                builder: (context ,AsyncSnapshot  snapshot) {
                  if(snapshot.hasData) {
                    List<KeHoachNguoiDoc> keHoachNguoiDocList= [];
                    staffsSelect=[];
                    keHoachNguoiDocList.addAll(snapshot.data);
                    for (var st in keHoachNguoiDocList)
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
                    Language.getText('tenkehoach'), Language.getText('tenkehoach'), true, Language.getText('tenkehoach')+Language.getText('required_empty'))
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<LoaiKeHoach>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: loaiKeHoach,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('loaikehoach'), Language.getText('select_loaikehoach'),true),
                    onFind: (String? filter) => selectLoaiKeHoach(filter),
                    itemAsString: (LoaiKeHoach? u) => u!.tenKeHoach,
                    onChanged: (data) {
                      this.loaiKeHoach = data;
                    },
                    validator: (value) {
                      if(value == null)
                        return Language.getText('select_empty') + Language.getText('loaikehoach').toLowerCase();
                      return null;
                    }

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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_kehoach_question'));
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
