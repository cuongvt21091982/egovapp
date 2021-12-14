import 'dart:async';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/service/yeucau/service-yeucau.dart';
import 'package:egovapp/service/yeucau/service-yeucaufilexl.dart';
import 'package:egovapp/service/yeucau/service-yeucauxuly.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class YKienYeuCau extends StatefulWidget
{
  const YKienYeuCau({Key? key,
    required this.id,
    required this.title
  }) : super(key: key);
  final String title;
  final int id;
  @override
  _YKienYeuCauState createState() => _YKienYeuCauState();}
class _YKienYeuCauState extends State<YKienYeuCau>
{
  HtmlEditorController controller = HtmlEditorController();
  List<FileItem> fileUploads= [];
  final formKey = GlobalKey<FormState>();
  int status= ParamUtils.statusHoanThanh;

  @override
  void initState() {
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
      ServiceYeuCau().getById(this.widget.id).then((value) {
      setState((){
        this.status = value.trangThai;
      });

      }).catchError((onError){
        Navigator.pop(context, false);
        UIUtils.showToastError(onError.toString(), context);
      });
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
    ServiceYeuCauXuLy().updateXuLy(this.widget.id,valueContent, status, UserAuthSession.staffId,0  ).then((value) {
      UIUtils.showToastSuccess(status == ParamUtils.statusHoanThanh ? Language.getText('message_success_ykien_status') : Language.getText('message_success_ykien'), context);
      for(var f in fileUploads)
      {
        if(f.path !=null && f.action == false)
        {
          ServiceYeuCauFileNXL().add(value, f.path!);
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
                                    child:
                                    TextButton.icon(onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        this.status = ParamUtils.statusHoanThanh;
                                        UIAction(actionForm).showDialogConfirm(context, Language.getText('question_ykien_status'));
                                      }
                                    },
                                      style:UIUtils.setButtonConfirmStyle(),
                                      icon: UIUtils.setButtonIcon(Icons.send) ,
                                      label: UIUtils.setButtonResetText(Language.getText("save_hoanthanh")
                                      ),

                                    )
                                ),
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
