import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/home/home-main.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController  txtUserName =  TextEditingController();
  TextEditingController  txtPassword =  TextEditingController();
  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressLoginAction(context);
    final dialogContext = await dialogContextCompleter.future;
      UserAuthSession.checkLogin(txtUserName.text, txtPassword.text).then((value) {
        Navigator.pop(dialogContext, true);
        if(value == true)
          {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new HomeMain(),
              ),
            );
          }else
            {
              UIAlert().showDialogConfirm(context,Language.getText("error_login"));
            }


      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });

  }
  @override
  Widget build(BuildContext context) {
    final logo =
      Container(
          padding: EdgeInsets.fromLTRB(0.0, 0.0,0.0, 50.0),
          child:Image.asset('assets/images/logo.png')

      );

    var formEdit=Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding:  EdgeInsets.fromLTRB(5.0, 40.0,5.0, 5.0),
                child: UIFormAction().setTextFormIcon(Icons.account_circle,
                    Colors.black12,this.txtUserName,TextInputType.text,
                    Language.getText('username'), Language.getText('username'), true, Language.getText('username')+Language.getText('required_empty'))
            ),Container(
                padding:  EdgeInsets.fromLTRB(5.0, 10.0,5.0, 10.0),
                child: UIFormAction().setTextFormPasswordIcon(Icons.lock,Colors.black12,this.txtPassword,TextInputType.visiblePassword,
                    Language.getText('password'), Language.getText('password'), true, Language.getText('password')+Language.getText('required_empty'))
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            actionForm();
                          }
                        },

                          style:UIUtils.setButtonRadius(Colors.red),
                          child: UIUtils.setButtonCustomText(Language.getText("login").toUpperCase(), Colors.white, 15
                          ),
                        )
                    )
                  ],)
            )

          ],
        ),
      ),
    );
    var centerLogin= Center(
        child: SizedBox(
            height: 500,
            width: 350,
            child: Column(
              children: [
                logo,
                Container(
                  child: formEdit,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 4.0,style: BorderStyle.solid), //Border.all
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow:[ BoxShadow(
                        color: Colors.white,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 0.0,
                        spreadRadius: 10.0,
                      )
                      ]
                  ),

                )
              ],
            )
        )
    );
    return Scaffold(
      backgroundColor: Colors.red,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.fill),
        ),
        child: centerLogin,
      )
    );
  }
}