import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/thongbao/service-thongbao.dart';
import 'package:egovapp/service/thongbao/service-thongbaofilexl.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class YKienThongBao extends StatefulWidget
{
  const YKienThongBao({Key? key,
    required this.id,
    required this.title
  }) : super(key: key);
  final String title;
  final int id;
  @override
  _YKienThongBaoState createState() => _YKienThongBaoState();}
class _YKienThongBaoState extends State<YKienThongBao>
{
  HtmlEditorController controller = HtmlEditorController();
  List<FileItem> fileUploads= [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
    }
  }
  Future<void> deleteFile(FileItem fileItem)
  async {
    if(fileItem.action == false)
      fileUploads.remove(fileItem);
  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    final valueContent = await controller.getText();
    ServiceThongBao().updateXuLy(this.widget.id,valueContent, ParamUtils.statusChuaXuLy, UserAuthSession.staffId,0 ).then((value) {
      UIUtils.showToastSuccess(Language.getText('message_success_ykien'), context);
      for(var f in fileUploads)
      {
        if(f.path !=null && f.action == false)
        {
          ServiceThongBaoFileXL().add(value, f.path!);
        }
      }
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
                padding: UIUtils.paddingForm,
                child: AttachFileFormAction(fileUploads: fileUploads, deleteFile: deleteFile)
            ),
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
