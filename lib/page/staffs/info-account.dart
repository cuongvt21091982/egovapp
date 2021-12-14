import 'dart:async';
import 'dart:convert';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/menu/bottom-bar-action.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/staffs/app-bar-action.dart';
import 'package:egovapp/page/staffs/change-password.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/staffs/service-staffs.dart';
import 'package:flutter/material.dart';

class InfoAccount extends StatefulWidget
{
  const InfoAccount({Key? key
  }) : super(key: key);


  @override
  _InfoAccountState createState() => _InfoAccountState();}
class _InfoAccountState extends State<InfoAccount>
{
  TextEditingController  txtHoDem =  TextEditingController();
  TextEditingController  txtTen =  TextEditingController();
  TextEditingController  txtBiDanh =  TextEditingController();
  var  dtNgaySinh =  TextEditingController();
  int gioiTinh=ParamUtils.male;
  TextEditingController  txtDienThoaiCoQuan =  TextEditingController();
  TextEditingController  txtDienThoaiNhaRieng =  TextEditingController();
  TextEditingController  txtDiDong =  TextEditingController();
  TextEditingController  txtThuDienTu =  TextEditingController();
  TextEditingController  txtEmail =  TextEditingController();
  TextEditingController  txtDiaChiNhaRieng =  TextEditingController();
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();

      UIUtils.progressLoad();
      ServiceStaffs().getById(UserAuthSession.staffId).then((value) {
        //this.txtHoDem = value.choThamKhao == ParamUtils.statusON ? true: false;
        this.gioiTinh = value.gioiTinh;
        this.txtHoDem.value = new TextEditingValue(text: value.hoDem );
        this.txtTen.value = new TextEditingValue(text: value.ten );
        this.txtBiDanh.value = new TextEditingValue(text: value.biDanh );
        this.dtNgaySinh.value = TextEditingValue(text: value.ngaySinh);
        this.txtDienThoaiCoQuan.value = new TextEditingValue(text: value.telOffice );
        this.txtDienThoaiNhaRieng.value = new TextEditingValue(text: value.telHome );
        this.txtDiDong.value = new TextEditingValue(text: value.mobile );
        this.txtThuDienTu.value = new TextEditingValue(text: value.email );
        this.txtDiaChiNhaRieng.value = new TextEditingValue(text: value.address );
        setState((){

        });
      }).catchError((onError) {
        Navigator.pop(context, false);
        UIUtils.showToastError(onError.toString(), context);
      });

  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
      ServiceStaffs().update(UserAuthSession.staffId,
      txtHoDem.text, txtTen.text, txtBiDanh.text,txtDiDong.text, dtNgaySinh.text, this.gioiTinh,
      txtDienThoaiCoQuan.text, txtDienThoaiNhaRieng.text,txtEmail.text, txtDiaChiNhaRieng.text).then((value) {
        UIUtils.showToastSuccess( Language.getText('message_update_staff_success') , context);
        Navigator.pop(dialogContext, true);
        UserAuthSession.getAccount();
        Navigator.pop(context, true);
      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
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
                child: UIFormAction().setTextFormField(this.txtHoDem,TextInputType.text,
                    Language.getText('hodem'), Language.getText('hodem'), true, Language.getText('hodem')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtTen,TextInputType.text,
                    Language.getText('ten'), Language.getText('ten'), true, Language.getText('ten')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtBiDanh,TextInputType.text,
                    Language.getText('bidanh'), Language.getText('bidanh'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgaySinh,
                    title:Language.getText('ngaysinh'),
                    description: Language.getText('ngaysinh'),
                    validate: true,
                    messageRequired: Language.getText('ngaysinh')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDienThoaiCoQuan,TextInputType.text,
                    Language.getText('teloffice'), Language.getText('teloffice'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDiaChiNhaRieng,TextInputType.text,
                    Language.getText('telhome'), Language.getText('telhome'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDiDong,TextInputType.text,
                    Language.getText('mobile'), Language.getText('mobile'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtEmail,TextInputType.text,
                    Language.getText('email'), Language.getText('email'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtDiaChiNhaRieng,TextInputType.multiline,
                    Language.getText('address'), Language.getText('address'), false, '')
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: ParamUtils.male,
                        groupValue: gioiTinh,
                        onChanged: (int? value) {
                          setState(() {
                            gioiTinh = value!;
                          });
                        },
                      ),UIUtils.setNamePerson(Language.getText("male"))
                      ,Radio(

                        value: ParamUtils.female,
                        groupValue: gioiTinh,
                        onChanged: (int? value) {
                          setState(() {
                            gioiTinh = value!;
                          });
                        }
                      ),UIUtils.setNamePerson(Language.getText("female"))
                    ]
                )
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_profile_question'));
                          }
                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonResetText(Language.getText("save_info")
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
          title: Text(Language.getText("info_account")),
          actions: [AppBarUserAction()],
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: formEdit,
        bottomNavigationBar: BottomBarAction(pageCurrent: ParamUtils.bottomPageTaiKhoan)
    ),

        onWillPop:  () {
          return new Future.value(true);
        });

  }
}
