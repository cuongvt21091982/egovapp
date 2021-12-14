import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/staffs/service_user.dart';
import 'package:flutter/material.dart';
class ChangePassword extends StatefulWidget
{
  const ChangePassword({Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();}
class _ChangePasswordState extends State<ChangePassword>
{
  TextEditingController  txtPassword =  TextEditingController();
  TextEditingController  txtPasswordConfrim =  TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();

  }
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    ServiceUser().update(UserAuthSession.userId,UserAuthSession.userName,
        UserAuthSession.staffId,txtPassword.text
        ).then((value) {
      UserAuthSession.checkLogin(UserAuthSession.userName, txtPassword.text).then((value) {
      }).catchError((e) {
      });
      UIUtils.showToastSuccess( Language.getText('message_change_password_success') , context);
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
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormPasswordIcon(Icons.lock,Colors.black12,this.txtPassword,TextInputType.visiblePassword,
                    Language.getText('passwordnew'), Language.getText('passwordnew'), true, Language.getText('passwordnew')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormPasswordIcon(Icons.lock,Colors.black12,this.txtPasswordConfrim,TextInputType.visiblePassword,
                    Language.getText('passwordconfirm'), Language.getText('passwordconfirm'), true, Language.getText('passwordconfirm')+Language.getText('required_empty'))
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
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_save_change_password_question'));
                          }
                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.lock) ,
                          label: UIUtils.setButtonResetText(Language.getText("thaydoithongtinmatkhau")
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
          title: Text(Language.getText("thaydoithongtinmatkhau")),
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
