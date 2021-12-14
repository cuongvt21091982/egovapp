import 'dart:async';
import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/danhmuc/nhommauvanban.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/danhmuc/service-nhommauvanban.dart';
import 'package:egovapp/service/mauvanban/service-mauvanban.dart';
import 'package:egovapp/service/mauvanban/service-mauvanbanfile.dart';
import 'package:flutter/material.dart';
class EditMauVanBan extends StatefulWidget
{
  const EditMauVanBan({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditMauVanBanState createState() => _EditMauVanBanState();}
class _EditMauVanBanState extends State<EditMauVanBan>
{
  var  txtTenMauVanBan=  TextEditingController();
  var  txtGhiChu=  TextEditingController();
  NhomMauVanBan? nhomMauVanBan;
  List<FileItem> fileUploads= [];



  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceMauVanBan().getById(this.widget.id).then((value) {
        this.txtTenMauVanBan.value = new TextEditingValue(text: value.tenVanBan );
        this.txtGhiChu.value = new TextEditingValue(text: value.ghichu );
        if(value.nhomMauVanBan!=null)
          nhomMauVanBan=value.nhomMauVanBan;
        if (value.mauVanBanFiles.length > 0) {
          for (var f in value.mauVanBanFiles)
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
      ServiceMauVanBan().delete(fileItem.id).then((value) {
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
      ServiceMauVanBan().add(
          this.txtTenMauVanBan.text ,
          this.txtGhiChu.text,
          this.nhomMauVanBan?.id ?? 0,
          UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceMauVanBanFile().add(value.id, f.path!);
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
      ServiceMauVanBan().update(this.widget.id,
          this.txtTenMauVanBan.text ,
          this.txtGhiChu.text,
          this.nhomMauVanBan?.id ?? 0,
          UserAuthSession.staffId).then((value) {
        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
        for (var f in fileUploads) {
          if (f.path != null && f.action == false) {
            ServiceMauVanBanFile().add(value.id, f.path!);
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
  Future<List<NhomMauVanBan>> selectNhomMauVanBan(String? filter)
  {
    return ServiceNhomMauVanBan().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
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
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtTenMauVanBan,TextInputType.text,
                    Language.getText('tenmauvanban'), Language.getText('tenmauvanban'), true, Language.getText('tenmauvanban')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtGhiChu,TextInputType.multiline,
                    Language.getText('ghichu'), Language.getText('ghichu'), false, '')
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<NhomMauVanBan>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: this.nhomMauVanBan,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('nhommauvanban'), Language.getText('select_nhommauvanban'),false),
                    onFind: (String? filter) => selectNhomMauVanBan(filter),
                    itemAsString: (NhomMauVanBan? u) => u!.ten,
                    onChanged: (data) {
                      this.nhomMauVanBan = data;
                    }

                )
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_mauvanban_question'));
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
