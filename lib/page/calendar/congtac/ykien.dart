import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/calendar/service-calendarnewscomment.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class YKienCalendarNews extends StatefulWidget
{
  const YKienCalendarNews({Key? key,
    required this.year,
    required this.week,
    required this.title
  }) : super(key: key);
  final String title;
  final int year;
  final int week;
  @override
  _YKienCalendarNewsState createState() => _YKienCalendarNewsState();}
class _YKienCalendarNewsState extends State<YKienCalendarNews>
{
  HtmlEditorController controller = HtmlEditorController();
  List<FileItem> fileUploads= [];
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    final valueContent = await controller.getText();
    ServiceCalendarNewsComment().add(this.widget.week, this.widget.year,
        valueContent, UserAuthSession.staffId ).then((value) {
      UIUtils.showToastSuccess(Language.getText('message_success_ykien') , context);
      Navigator.pop(dialogContext, true);
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
            )
            ,
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: UIUtils.paddingLite,
                        child: TextButton.icon(onPressed: () async{
                          if (formKey.currentState!.validate())
                          {
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('question_ykien'));
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("save_ykien")
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
