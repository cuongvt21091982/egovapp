import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/vanbanden/service-vanbanden.dart';
import 'package:flutter/material.dart';
class AssignVanBanDen extends StatefulWidget
{
  const AssignVanBanDen({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final VoidCallback callBackRefresh;
  final String title;
  final int id;
  @override
  _AssignVanBanDenState createState() => _AssignVanBanDenState();}
class _AssignVanBanDenState extends State<AssignVanBanDen>
{
  var  dtThoiHan =  TextEditingController();
  List<Staff> staffsSelect = [];
  Staff? nguoiChuTri;
  String users= '';
  TextEditingController  txtButPhe =  TextEditingController();
  TextEditingController  txtTrichYeu =  TextEditingController();
  bool nguoiGiaoHoanThanh = false;
  bool theoDoiCapTiep = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();     
        this.txtTrichYeu.value = TextEditingValue(text: this.widget.title);     
    }
  }
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceVanBanDen().addXuLy(this.widget.id,
                               this.staffsSelect.map((e) => e.id).toList().join(','),
                               nguoiGiaoHoanThanh == true? 1 :0 ,
                               theoDoiCapTiep == true? 1: 0,
                                dtThoiHan.text,
                                nguoiChuTri?.id ?? 0,
                                ParamUtils.statusChuaXuLy,
                                ParamUtils.statusChuaXuLy,
                                UserAuthSession.staffId, txtButPhe.text).then((value) {
      UIUtils.showToastSuccess(
          Language.getText('message_giaoxuly_vanban_success'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
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
                child: UIFormAction().setTextFormVisibleField(this.txtTrichYeu,TextInputType.multiline,
                    Language.getText('trichyeu'), Language.getText('trichyeu'))
            ),
            Container(
              child: UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoinhan')) ,
              padding: UIUtils.paddingForm,
            ),
            Container(
                padding: UIUtils.paddingForm,
                child: DropdownSearch<Staff>(
                    mode: Mode.DIALOG,
                    showClearButton: true,
                    items: staffsSelect,
                    dropdownSearchDecoration:  UIUtils.setInputDecoration(Language.getText('nguoichutri'), Language.getText('nguoichutri'),true),
                    itemAsString: (Staff? u) => u!.fullName,
                    onChanged: (data) {
                      this.nguoiChuTri = data;
                    },
                    validator: (value) {
                      if(value == null)
                        return Language.getText('select_empty') + Language.getText('nguoichutri').toLowerCase();
                      return null;
                    }

                )
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtButPhe,TextInputType.multiline,
                    Language.getText('butphe'), Language.getText('butphe'), false, '')
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
                          value: nguoiGiaoHoanThanh,
                          onChanged: (bool? value) {
                            setState(() {
                              nguoiGiaoHoanThanh = value!;
                            });
                          }),
                      UIUtils.setTextUserName(Language.getText('nguoigiaohoanthanh'))
                    ]
                )
            ),

            Container(
                padding:  UIUtils.paddingForm,
                child: Row(
                    children: [
                      Checkbox(
                          value: theoDoiCapTiep,
                          onChanged: (bool? value) {
                            setState(() {
                              theoDoiCapTiep = value!;
                            });
                          }),
                      UIUtils.setTextUserName(Language.getText('theodoixulycaptiep'))
                    ]
                )
            ),Container(
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
                        child: TextButton.icon(onPressed: () async{
                          if(this.staffsSelect.length ==0 )
                            UIUtils.showToastError(Language.getText("select_empty_required"), context);
                          else
                            if (formKey.currentState!.validate()) {
                              UIAction(actionForm).showDialogConfirm(context,
                                  Language.getText('assign_vanban_question'));
                            }

                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("assign_staff_xuly")
                          ),

                        )
                    )
                    ,
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          Navigator.pop(context, true);
                        },
                          style:UIUtils.setButtonCancelStyle(),
                          icon: UIUtils.setButtonIcon(Icons.cancel) ,
                          label: UIUtils.setButtonResetText(Language.getText("no")
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
          title: Text(Language.getText("giaoxulyvanbanden")),
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
