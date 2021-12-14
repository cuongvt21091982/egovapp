import 'dart:async';
import 'package:egovapp/constants/api-util.dart';
import 'package:egovapp/constants/language.dart';
import 'package:egovapp/constants/params.dart';
import 'package:egovapp/constants/ui-util.dart';
import 'package:egovapp/constants/user-global.dart';
import 'package:egovapp/model/staffs/staff.dart';
import 'package:egovapp/model/totrinh/totrinhxuly.dart';
import 'package:egovapp/page/files/download-file.dart';
import 'package:egovapp/page/files/file-item.dart';
import 'package:egovapp/page/files/filelink.dart';
import 'package:egovapp/page/ui/ui-action.dart';
import 'package:egovapp/page/yeucau/xuly/noidungtrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinh.dart';
import 'package:egovapp/service/totrinh/service-totrinhfile.dart';
import 'package:egovapp/service/totrinh/service-totrinhxuly.dart';
import 'package:egovapp/service/yeucau/service-yeucau.dart';
import 'package:egovapp/service/yeucau/service-yeucaufile.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
class ChuyenTrinhYeuCau extends StatefulWidget
{
  const ChuyenTrinhYeuCau({Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);
  final String title;
  final int id;
  @override
  _ChuyenTrinhYeuCauState createState() => _ChuyenTrinhYeuCauState();}
class _ChuyenTrinhYeuCauState extends State<ChuyenTrinhYeuCau>
{
  HtmlEditorController controller = HtmlEditorController();
  var  dtThoiHan =  TextEditingController();
  TextEditingController  txtChuDe =  TextEditingController();
  List<FileItem> fileUploads= [];
  List<Staff> staffsSelect = [];
  String users= '';
  String noiDung='';
  int status = ParamUtils.statusDraft;
  final formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    if(this.widget.id !=0) {
      UIUtils.progressLoad();
    }
  }
  Future<void> deleteFile(FileItem fileItem)
  async {
    if(fileItem.action == false)
    {
      setState(() {
        fileUploads.remove(fileItem);
      });
    }
  }

  Future<void> actionForm() async
  {
    final dialogContextCompleter = UIUtils.progressAction(context);
    final dialogContext = await dialogContextCompleter.future;
    final valueContent = await controller.getText();
    ServiceToTrinh().add(
        this.staffsSelect.map((e) => e.id).toList().join(','), this.txtChuDe.text, valueContent, UserAuthSession.staffId,
        dtThoiHan.text, status).then((value) {
      ServiceYeuCau().chuyenTrinh(value.id, this.widget.id, UserAuthSession.staffId).then((value) {

      }).catchError((e) {
        UIUtils.showToastError(e.toString(), context);
        Navigator.pop(dialogContext, true);
      });
      UIUtils.showToastSuccess(
          status == ParamUtils.statusChuaXuLy ? Language.getText(
              'message_send_success') : Language.getText('message_insert_success'), context);
      for (var f in fileUploads) {
        if (f.path != null && f.action == false) {
          ServiceToTrinhFile().add(value.id, f.path!);
        }
      }
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
              child: FutureBuilder(
                future: ServiceToTrinhXuLy().getAllByMaYeuCau(this.widget.id).catchError((e){
                  UIUtils.showToastError(e.toString(), context);
                }),
                builder: (context ,AsyncSnapshot  snapshot) {
                  if(snapshot.hasData) {
                    List<ToTrinhXuLy> toTrinhXuLyList= [];
                    staffsSelect=[];
                    toTrinhXuLyList.addAll(snapshot.data);
                    for (var st in toTrinhXuLyList)
                      staffsSelect.add(st.nguoiXuLy);
                  }
                  return UIStaffSelect(staffsSelect:  this.staffsSelect, titleAction:  Language.getText('select_nguoinhan'));

                },

              )
              ,
              padding: UIUtils.paddingForm,
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child: UIFormAction().setTextFormField(this.txtChuDe,TextInputType.text,
                    Language.getText('chude'), Language.getText('chude'), true, Language.getText('chude')+Language.getText('required_empty'))
            ),
            Container(
                padding:  UIUtils.paddingForm,
                child:    UIDateTimeAction( textEdit: this.dtThoiHan,
                    title:Language.getText('thoihan'),
                    description: Language.getText('thoihan'),
                    validate: false,
                    messageRequired: '')
            ),Container(
                padding: UIUtils.paddingListView,
                child:
                Row(
                    children: [
                      TextButton.icon(onPressed: () async {
                        ServiceYeuCauFile().getAllByYeuCauId(this.widget.id).then((value)
                        {
                          List<FileLink> fileLinks=[];
                          for(var item in value)
                          {
                            fileLinks.add(new FileLink(name: item.name,
                                link: ApiUtils().getDownloadFileUrl(item.folder, item.fileKey, item.width, item.name)));
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    DonwloadFileDialog( files: fileLinks),
                                fullscreenDialog: true,
                              ));
                        });
                      },
                          style:UIUtils.setButtonAttachViewStyle(),
                          icon: UIUtils.setButtonIcon(Icons.attach_file),
                          label: UIUtils.setButtonText(Language.getText("xemfiledinhkem")
                          )
                      )
                    ]
                )

            )
            ,
            Container(
                padding: UIUtils.paddingForm,
                child: AttachFileFormAction(fileUploads: fileUploads, deleteFile: deleteFile)
            ),Container(
                padding: UIUtils.paddingListView,
                child:
                Row(
                    children: [
                      TextButton.icon(onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => YeuCauNoiDungTrinh(id: this.widget.id, title: Language.getText("noidungtrinh")),
                              fullscreenDialog: true,
                            ));
                      },
                          style:UIUtils.setButtonTrinhViewStyle(),
                          icon: UIUtils.setButtonIcon(Icons.policy_outlined),
                          label: UIUtils.setButtonText(Language.getText("noidungtrinh")
                          )
                      )
                    ]
                )

            ) ,

            Container(child:
            SizedBox(
                height: 400,
                child: UIUtils.setHtmlEditor(controller, this.noiDung)
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
                        child: TextButton.icon(onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            UIAction(actionForm).showDialogConfirm(context,
                                Language.getText('message_save_question'));
                          }
                        },
                          style:UIUtils.setButtonSubmitStyle(),
                          icon: UIUtils.setButtonIcon(Icons.save) ,
                          label: UIUtils.setButtonSubmitText(Language.getText("draft")
                          ),

                        )
                    )
                    ,
                    Container(
                        padding: UIUtils.paddingLite,
                        child:
                        TextButton.icon(onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            this.status = ParamUtils.statusChuaXuLy;
                            UIAction(actionForm).showDialogConfirm(context, Language.getText('message_send_question'));
                          }

                        },
                          style:UIUtils.setButtonConfirmStyle(),
                          icon: UIUtils.setButtonIcon(Icons.send) ,
                          label: UIUtils.setButtonResetText(Language.getText("sendtotrinh")
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
