import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/vpp/dangkyhop.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/vpp/service-dangkyhop.dart';
import 'package:egovapp/service/vpp/service-dangkynguoiduyet.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class PheDuyetDangKyDatPhong extends StatefulWidget
{
  const PheDuyetDangKyDatPhong({Key? key,
    required this.id,
    required this.title,
    required this.callBackRefresh
  }) : super(key: key);
  final String title;
  final int id;
  final VoidCallback callBackRefresh;
  @override
  _PheDuyetDangKyDatPhongState createState() => _PheDuyetDangKyDatPhongState();}
class _PheDuyetDangKyDatPhongState extends State<PheDuyetDangKyDatPhong>
{
  HtmlEditorController controller = HtmlEditorController();
  List<FileItem> fileUploads= [];
  final formKey = GlobalKey<FormState>();
  int status= ParamUtils.statusHoanThanh;
  DangKyHop? dangKy;

  @override
  void initState() {
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceDangKyHop().getById(this.widget.id).then((value) {
        dangKy=value;

      }).catchError((onError){
        Navigator.pop(context, false);
        UIUtils.showToastError(onError.toString(), context);
      });
    }
  }


  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    final valueContent = await controller.getText();
    ServiceDangKyHop().approved(this.widget.id,
        dangKy!.ngay,
        dangKy!.ghiChu,
        dangKy!.phongID,
        dangKy!.noiDung,
        dangKy!.thoiGian,
        valueContent,
        dangKy!.nguoiChuTri,
        dangKy!.nguoiDangKyID,status).then((value) {
      ServiceDangKyNguoiDuyet().approved(this.widget.id,
          UserAuthSession.staffId, valueContent, status,
          ParamUtils.dangKyPhong
      ).then((value) => null).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
      });
      UIUtils.showToastSuccess(status == ParamUtils.statusHoanThanh ? Language.getText('message_success_approve_status') : Language.getText('message_success_reject_status'), context);
      Navigator.pop(dialogContext, true);
      this.widget.callBackRefresh();
      Navigator.pop(context, true);
    }).catchError((e){

      UIUtils.showToastError(e.toString(), context);
      Navigator.pop(dialogContext, true);
    });
  }
  @override
  Widget build(BuildContext context) {
    var futureContent=  Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child:
            SizedBox(
                height: 400,
                child: UIUtils.setHtmlEditor(controller,'')
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
                            this.status = ParamUtils.statusHoanThanh;
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('question_approved_status'));
                          }
                        },
                          style:UIUtils.setButtonApprovedStyle(),
                          icon: UIUtils.setButtonIcon(Icons.verified_user) ,
                          label: UIUtils.setButtonResetText(Language.getText("save_approved")
                          ),

                        )
                    ),
                    Container(
                        padding: UIUtils.paddingLite,
                        child: TextButton.icon(onPressed: () async{
                          if (formKey.currentState!.validate())
                          {
                            this.status = ParamUtils.statusDangXuLy;
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('question_reject_status'));
                          }
                        },
                          style:UIUtils.setButtonRejectStyle(),
                          icon: UIUtils.setButtonIcon(Icons.details) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("save_reject")
                          ),

                        )
                    )
                  ],)
            )

          ],
        ),
      ),
    );


    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIUtils.colorAppBar,
          title: Text(widget.title),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: futureContent

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
