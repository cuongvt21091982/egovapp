import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/hoso/service-hososhare.dart';
import 'package:flutter/material.dart';
class ShareHoSoDonVi extends StatefulWidget
{
  const ShareHoSoDonVi({Key? key,
    required this.id,
    required this.title
  }) : super(key: key);

  final String title;
  final int id;
  @override
  _ShareHoSoDonViState createState() => _ShareHoSoDonViState();}
class _ShareHoSoDonViState extends State<ShareHoSoDonVi>
{
  List<Staff> staffsSelect = [];
  String users= '';
  TextEditingController  txtGhiChu =  TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
    }
  }
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceHoSoShare().addShare(this.widget.id, UserAuthSession.staffId,
        this.staffsSelect.map((e) => e.id).toList().join(','),txtGhiChu.text).then((value) {
      UIUtils.showToastSuccess(Language.getText('message_share_hoso_success') , context);
      Navigator.pop(dialogContext, true);
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
              child: UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoinhan')) ,
              padding: UIUtils.paddingForm,
            ) ,Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtGhiChu,TextInputType.multiline,
                    Language.getText('ghichu'), Language.getText('ghichu'), false, ParamUtils.stringEmpty)
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
                                Language.getText('share_staff_hoso_question'));
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("share")
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
          title: Text(widget.title),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: formEdit
    ),
        onWillPop:  () {
          return new Future.value(true);
        });

  }
}
