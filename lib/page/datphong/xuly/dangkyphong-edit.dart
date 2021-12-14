import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/enviroments.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/danhmuc/phong.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/vpp/dangkynguoiduyet.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/danhmuc/service-phong.dart';
import 'package:egovapp/service/vpp/service-dangkyhop.dart';
import 'package:egovapp/service/vpp/service-dangkynguoiduyet.dart';
import 'package:flutter/material.dart';
class EditDangKyPhong extends StatefulWidget
{
  const EditDangKyPhong({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _EditDangKyPhongState createState() => _EditDangKyPhongState();}
class _EditDangKyPhongState extends State<EditDangKyPhong>
{

  var  dtNgayKy=  TextEditingController();
  TextEditingController  txtNoiDung =  TextEditingController();
  TextEditingController  txtGhiChu =  TextEditingController();
  TextEditingController  txtYeuCauTraLoi =  TextEditingController();
  TextEditingController  txtThoiGian =  TextEditingController();
  TextEditingController  txtNguoiChuTri =  TextEditingController();
  Phong? phong;
  List<Staff> staffsSelect = [];
  String users= '';
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceDangKyHop().getById(this.widget.id).then((value) {
        this.txtNoiDung.value = new TextEditingValue(text: value.noiDung );
        this.txtGhiChu.value = new TextEditingValue(text: value.ghiChu );
        this.txtThoiGian.value = new TextEditingValue(text: value.thoiGian );
        this.txtYeuCauTraLoi.value = new TextEditingValue(text: value.yeuCauTraLoi);
        this.txtNguoiChuTri.value = new TextEditingValue(text: value.nguoiChuTri);
        this.dtNgayKy.value = new TextEditingValue(text: value.ngay);
        this.phong= value.phong;

      }).catchError((onError) {
        Navigator.pop(context, false);
        UIUtils.showToastError(onError.toString(), context);
      });
    }
  }
  Future<List<Phong>> selectPhong(String? filter)
  {
    return ServicePhong().getPaging(filter!,  Enviroments.currentPage,Enviroments.pageSizeMax).catchError((e) {
      UIUtils.showToastError(e.toString(), context);
    });
  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    if(this.widget.id ==0) {
      ServiceDangKyHop().add(
          this.dtNgayKy.text ,
          this.txtGhiChu.text,
          this.phong?.id ?? 0,
          this.txtNoiDung.text,
          this.txtThoiGian.text,
          this.txtYeuCauTraLoi.text,
          this.txtNguoiChuTri.text,
          UserAuthSession.staffId,
          ParamUtils.statusChuaXuLy).then((value) {
        ServiceDangKyNguoiDuyet().addMulti(value.dangKyId,  this.staffsSelect.map((e) => e.id).toList().join(',')
            , ParamUtils.dangKyPhong).then((value) => null).catchError((e) {
          UIUtils.showToastError(e.toString(), context);
        });
        UIUtils.showToastSuccess( Language.getText('message_send_success') , context);
        Navigator.pop(dialogContext, true);
        this.widget.callBackRefresh();
        Navigator.pop(context, true);
      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
    }else
    {
      ServiceDangKyHop().update(this.widget.id,
          this.dtNgayKy.text ,
          this.txtGhiChu.text,
          this.phong?.id ?? 0,
          this.txtNoiDung.text,
          this.txtThoiGian.text,
          this.txtYeuCauTraLoi.text,
          this.txtNguoiChuTri.text,
          UserAuthSession.staffId,
          ParamUtils.statusChuaXuLy).then((value) {
        ServiceDangKyNguoiDuyet().addMulti(value.dangKyId,  this.staffsSelect.map((e) => e.id).toList().join(',')
            , ParamUtils.dangKyPhong).then((value) => null).catchError((e) {
          UIUtils.showToastError(e.toString(), context);
        });

        UIUtils.showToastSuccess(
            Language.getText( 'message_update_success'), context);
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
                future: ServiceDangKyNguoiDuyet().findAllByDangKyId(this.widget.id, ParamUtils.dangKyVPP).catchError((e){
                  UIUtils.showToastError(e.toString(), context);
                }),
                builder: (context ,AsyncSnapshot  snapshot) {
                  if(snapshot.hasData) {
                    List<DangKyNguoiDuyet> dangKyNguoiDuyetList=[];
                    dangKyNguoiDuyetList.addAll(snapshot.data);
                    for (var st in dangKyNguoiDuyetList)
                      staffsSelect.add(st.nguoiDuyet);
                  }
                  return UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoiduyet'));

                },

              )
              ,
              padding: UIUtils.paddingForm,
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtNgayKy,
                    title:Language.getText('ngay'),
                    description: Language.getText('ngay'),
                    validate: true,
                    messageRequired: Language.getText('ngay')+Language.getText('required_empty'))
            ),Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<Phong>(
                    mode: Mode.DIALOG,
                    showSearchBox: true,
                    showClearButton: true,
                    selectedItem: this.phong,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('phong'), Language.getText('select_phong'),false),
                    onFind: (String? filter) => selectPhong(filter),
                    itemAsString: (Phong? u) => u!.tenPhong,
                    onChanged: (data) {
                      this.phong = data;
                    }

                )
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtThoiGian,TextInputType.text,
                    Language.getText('thoigian'), Language.getText('thoigian'), false, Language.getText('thoigian')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtThoiGian,TextInputType.text,
                    Language.getText('nguoichutri'), Language.getText('nguoichutri'), false, Language.getText('nguoichutri')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtNoiDung,TextInputType.multiline,
                    Language.getText('noidung'), Language.getText('noidung'), true, Language.getText('noidung')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtGhiChu,TextInputType.multiline,
                    Language.getText('ghichu'), Language.getText('ghichu'), false, Language.getText('ghichu')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtYeuCauTraLoi,TextInputType.multiline,
                    Language.getText('yeucautraloi'), Language.getText('yeucautraloi'), false, Language.getText('yeucautraloi')+Language.getText('required_empty'))
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_phonghop_question'));
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
